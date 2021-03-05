this_dir = File.expand_path(File.dirname(__FILE__))
pb_dir = File.join(this_dir, './pb')
$LOAD_PATH.unshift(pb_dir) unless $LOAD_PATH.include?(pb_dir)

require 'grpc'
require 'hello_services_pb'

class HelloServer < Hello::Service
  def hello(hello_message, _unused_call)
    HelloResponse.new(msg: "Hello #{hello_message.name}")
  end
end

def main
  s = GRPC::RpcServer.new
  s.add_http2_port('127.0.0.1:19003', :this_port_is_insecure)
  s.handle(HelloServer)
  # Runs the server with SIGHUP, SIGINT and SIGQUIT signal handlers to
  #   gracefully shutdown.
  # User could also choose to run server via call to run_till_terminated
  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main
