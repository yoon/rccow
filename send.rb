require 'rubygems'
require 'ruby-hl7'
require 'socket'

# create the empty hl7 message
msg = HL7::Message.new

# create an empty MSH segment
msh = HL7::Message::Segment::MSH.new 

# create an empty NTE segment
nte = HL7::Message::Segment::NTE.new
msg << msh # add the MSH segment to our message
msg << nte  # add the NTE segment to our message

# let's fill in some fields using pre-defined aliases
msh.sending_app = "my test app"
msh.sending_facility = "my apartment"
nte.comment = "my message rocks, ruby-hl7 is great"

# let's create our own on-the-fly segment (NK1 is not implemented in code)
seg = HL7::Message::Segment::Default.new
seg.e0 = "NK1"             # define the segment's name
seg.e1 = "MORE INFO"   # define it's first field
seg.e2 = "OTHER INFO" # define it's second field
msg << seg  # add the new segment to the message
  
soc = TCPSocket.open( "192.168.1.234", 5700 )
soc.write msg.to_mllp
soc.close