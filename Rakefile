task :default => :compile

root = File.expand_path(__dir__)

task :compile do
  definitions = File.join(root, "definitions")
  ruby_out = File.join(root, "ruby")

  sh %W(
    protoc
    -I #{definitions}
    --ruby_out #{ruby_out}
    $(find #{definitions} -name "*.proto")
  ).join(" ")
end
