# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: foo/person.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "foo.PersonMessage" do
    optional :id, :int32, 1
    optional :name, :string, 2
    optional :email, :string, 3
  end
end

module Foo
  PersonMessage = Google::Protobuf::DescriptorPool.generated_pool.lookup("foo.PersonMessage").msgclass
end