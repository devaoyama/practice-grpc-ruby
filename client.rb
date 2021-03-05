this_dir = File.expand_path(File.dirname(__FILE__))
pb_dir = File.join(this_dir, './pb')
$LOAD_PATH.unshift(pb_dir) unless $LOAD_PATH.include?(pb_dir)

require 'grpc'
require 'hello_services_pb'

def main
  user = '山田太郎'
  hostname = '127.0.0.1:19003'
  stub = Hello::Stub.new(hostname, :this_channel_is_insecure)
  begin
    message = stub.hello(HelloMessage.new(name: user)).msg
    p "Greeting: #{message}"
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.message}"
  end
end

main
