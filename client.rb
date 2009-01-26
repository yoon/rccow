require 'socket'                           # Sockets are in standard library
 
sock = TCPSocket.open("localhost",1234)    # Socket to listen on port 1234
 
#   l = STDIN.gets                           # Get a single input from console
#   sock.puts(l)                             # Send input to the server
#   sock.flush                               # Force input
#   line = sock.readpartial(4096)            # Read server's response
#   puts line                                # Display the response to the user
#  
# sock.close                                 # Close the socket
# 

while (input = gets.chop!)                     # Loop server while user gives an input
  sock.puts(input)                             # Send input to the server
  sock.flush                               # Force input
  line = sock.readpartial(4096)            # Read server's response
  puts line                                # Display the response to the user
  
  if input =~ /exit/
    sock.close
    break
  end
end