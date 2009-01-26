PORT=2324

require 'socket'
require 'thread'

# A function called for each socket
def handle_incoming(sock)
  # Threads are easy - lets put each incoming socket in
  # Its own thread. =).
  Thread.new {

    # Socket.addr -> [networkdomain, port, name, ip]
    puts "New connection from #{sock.addr[2]} (#{sock.addr[3]})"

    # Echo each line we get back to the socket.
    # When the socket gets an error or is closed,
    # gets returns nil, so the while loop exits.
    while (line = sock.gets)
      sock.puts line
    end

    puts "Connection from #{sock.addr[2]} closed."

  }
end

# Create a new listener that listens on all addresses
# and the port number in constant PORT (defined above)
# TCPServer.new(local_address,port)
listener = TCPServer.new('',PORT)

# listener.accept returns sockets of new connections.
# This while loop calls handle_incoming on each new
# socket created. Doing it this way instead of putting
# the Thread.new { ... } code inside this while loop
# bypasses ickiness with local variables being shared.

while (new_socket = listener.accept)
  handle_incoming(new_socket)
end
