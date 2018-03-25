#!/usr/bin/env ruby

$LOAD_PATH << File.join(__dir__, "ruby")

count = (ARGV[0] || 100).to_i

require "benchmark"
require "json"
require "msgpack"

require_relative "ruby/person_message_pb"
require_relative "ruby/group_message_pb"

people = (1..count).map do |i|
  PersonMessage.new(id: i,
                    name: "##{i}",
                    email: "foo.bar#{i}@example.com")
end

group = GroupMessage.new(people: people)

protobuf = Benchmark.realtime { GroupMessage.encode(group) }
puts "protobuf	%0.6f" % protobuf

json = Benchmark.realtime { GroupMessage.encode_json(group) }
puts "json	%0.6f" % json

data = JSON.parse(GroupMessage.encode_json(group))

msgpack = Benchmark.realtime { MessagePack.dump(data) }
puts "msgpack	%0.6f" % msgpack

cols = people.first.to_hash.keys
slim_people = [cols.size] + cols
people.each do |person|
  slim_people += person.to_hash.values
end
slim_data = { group: slim_people }
slim_msgpack = Benchmark.realtime { MessagePack.dump(slim_data) }
puts "slim msgpack	%0.6f" % slim_msgpack
