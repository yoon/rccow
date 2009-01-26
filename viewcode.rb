# A Multithreaded Server
 
require 'socket'
 
# This method expects a socket connected to a client.
# It reads lines from the client, reverses them and sends them back.
# Multiple threads may run this method at the same time.
 
def handle_client(c)
 while true
   input = c.gets.chop                 # Read a line of input from the client
   break if !input                     # Exit if no more input
   break if input == "quit"            # or if the client asks to.
   c.puts(input.reverse)               # Otherwise, respond to client.
   c.flush                             # Force our output out
 end
 c.close                               # Close the client socket
end
 
server = TCPServer.open(2000) # Listen on port 2000
 
while true                             # Servers loop forever
 client = server.accept                # Wait for a client to connect
 Thread.start(client) do |c|           # Start a new thread
   handle_client(c)                    # And handle the client on that thread
 end
end