require 'rubygems'
require 'ruby-hl7'
require 'socket'                           # Sockets are in standard library
 
sock = TCPSocket.open("localhost",1234)    # Socket to listen on port 1234
 
# #   l = STDIN.gets                           # Get a single input from console
# #   sock.puts(l)                             # Send input to the server
# #   sock.flush                               # Force input
# #   line = sock.readpartial(4096)            # Read server's response
# #   puts line                                # Display the response to the user
# #  
# # sock.close                                 # Close the socket
# # 
# 
# while (input = gets.chop!)                     # Loop server while user gives an input
#   sock.puts(input)                             # Send input to the server
#   sock.flush                               # Force input
#   line = sock.readpartial(4096)            # Read server's response
#   puts line                                # Display the response to the user
#   
#   if input =~ /exit/
#     sock.close
#     break
#   end
# end

# create a message
msg = HL7::Message.new
msg2 = HL7::Message.new

# create a MSH segment for our new message
msh = HL7::Message::Segment::MSH.new
msh.recv_app = "ruby hl7"
msh.recv_facility = "my office"
msh.processing_id = rand(10000).to_s
msg << msh # add the MSH segment to the message

msh2 = HL7::Message::Segment::MSH.new
msh2.recv_app = "ruby hl7 ccow"
msh2.recv_facility = "your office"
msh2.processing_id = rand(10000).to_s
msg2 << msh2 # add the MSH segment to the message

sock.puts(msg, msg2)

# sock.send(msg)

# puts msg.to_s # readable version of the message
# 
# puts msg.to_hl7 # hl7 version of the message (as a string)
# 
# puts msg.to_mllp # mllp version of the message (as a string)
