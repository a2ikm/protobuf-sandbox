#!/usr/bin/env ruby

$LOAD_PATH << File.join(__dir__, "ruby")

require "json"
require "msgpack"

require_relative "ruby/person_message_pb"
require_relative "ruby/group_message_pb"

people = (1..100).map do |i|
  PersonMessage.new(id: i,
                    name: "##{i}",
                    email: "foo.bar#{i}@example.com")
end

group = GroupMessage.new(people: people)

protobuf = GroupMessage.encode(group)
puts "protobuf: #{protobuf.bytesize}"

json = GroupMessage.encode_json(group)
puts "json: #{json.bytesize}"

data = JSON.parse(json)

msgpack = MessagePack.dump(data)
puts "msgpack: #{msgpack.bytesize}"

cols = people.first.to_hash.keys
slim_people = [cols.size] + cols
people.each do |person|
  slim_people += person.to_hash.values
end
slim_data = { group: slim_people }
slim_msgpack = MessagePack.dump(slim_data)
puts "slim msgpack: #{slim_msgpack.bytesize}"
