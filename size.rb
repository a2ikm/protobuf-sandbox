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
puts protobuf.bytesize

json = GroupMessage.encode_json(group)
puts json.bytesize

data = JSON.parse(json)

msgpack = MessagePack.dump(data)
puts msgpack.bytesize
