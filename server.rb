require 'gserver'
 
# Algorithm to shuffle a string
 
def shuffle(str)
 
lenth = str.length
 
index = (lenth-1)
 
  while(index >= 0) do
 
   random_number = rand(lenth)
 
   str[random_number], str[index] = str[index], str[random_number]
 
   index = index - 1
 
  end
 
str
end
 
class Server < GServer                  # Server class derived from GServer super class
  def initialize(port=1234, *args)      # to use the initialize function
      super(port, *args)
  end
 
  def serve(io)                         # Serve method handles connections
 
      input = io.gets.chop!             # Get input from client console
      io.puts(shuffle(input))           # Return the shuffled input onto the client console
      puts input                        # Print the client message 
 
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