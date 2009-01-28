require 'rubygems'
require 'ruby-hl7'
require 'gserver'
 
class Server < GServer                  # Server class derived from GServer super class
  def initialize(port=1234, *args)      # to use the initialize function
      super(port, *args)
  end
  def serve(io)                         # Serve method handles connections
      raw_input = io.readlines             # Get input from client console
      raw_input.each do |input|
        msg = HL7::Message.new( input )
        puts msg.to_s
        puts "message type: %s" % msg[:MSH].message_type
        puts "recv_app: %s" % msg[:MSH].recv_app
        puts "recv_facility: %s" % msg[:MSH].recv_facility
        puts "processing_id: %s" % msg[:MSH].processing_id
        # io.puts(shuffle(input))           # Return the shuffled input onto the client console
        # puts input                        # Print the client message 
      end
  end
end

server = Server.new

while (input = gets)                     # Loop server while user gives an input
 server.audit = true 
 if input =~ /start/
   server.start                          # Start the server if the user types "init"
 end
 
 if input =~ /shutdown/
   server.shutdown                       # Shut the server down if the user types "shutdown"
 break
 end
 
end