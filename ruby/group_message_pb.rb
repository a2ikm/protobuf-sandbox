# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: group_message.proto

require 'google/protobuf'

require 'person_message_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "GroupMessage" do
    repeated :people, :message, 1, "PersonMessage"
  end
end

GroupMessage = Google::Protobuf::DescriptorPool.generated_pool.lookup("GroupMessage").msgclass