#!/usr/bin/env ruby

$LOAD_PATH << File.join(__dir__, "ruby")

require "benchmark"
require "json"
require "msgpack"

require_relative "ruby/person_message_pb"
require_relative "ruby/group_message_pb"

def measure
  n = 10
  "%0.6f" % [n.times.sum {
    Benchmark.realtime { yield }
  } / n]
end

puts ["", "protobuf", "json", "msgpack", "slim msgpack"].join("\t")

[100, 1000, 2000, 5000, 10000].each do |count|
  people = (1..count).map do |i|
    PersonMessage.new(id: i,
                      name: "##{i}",
                      email: "foo.bar#{i}@example.com")
  end

  group = GroupMessage.new(people: people)

  data = JSON.parse(GroupMessage.encode_json(group))

  cols = people.first.to_hash.keys
  slim_people = [cols.size] + cols
  people.each do |person|
    slim_people += person.to_hash.values
  end
  slim_data = { group: slim_people }

  protobuf = measure { GroupMessage.encode(group) }
  json = measure { GroupMessage.encode_json(group) }
  msgpack = measure { MessagePack.dump(data) }
  slim_msgpack = measure { MessagePack.dump(slim_data) }

  puts [count, protobuf, json, msgpack, slim_msgpack].join("\t")
end
