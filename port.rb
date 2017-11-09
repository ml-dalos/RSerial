require 'rubyserial'

class SerialPort < Serial
	
	DELAY_SECONDS = 1
	JAM_SIGNAL = '~'
	attr_reader :adress
	
	def initialize adress ,baude_rate=9600, data_bits=8, parity=:none 
    @adress = adress
    super
  end

  def write data
    wait_chanel_free
  	data.each_byte do |byte|
      attemps = 0  
      loop do
     	  super byte.chr
  	    sleep 0.1
  	    if collide?
  	    	super JAM_SIGNAL 
  	    	attemps += 1
  	    	delay_write(attemps)
  	    else
  	    	break
  	    end 
      end
    end
  end

  def read size
  	message = nil
  	loop do
    	byte = super
    	case byte
      when nil
        return message
      when JAM_SIGNAL
        message.chop!
      else
        message += byte
      end    
    end
    message
  end

  def set_baud_rate baud_rate
    this = SerialPort.new @adress, baud_rate
  end
  
  private
  def wait_chanel_free
  	sleep(DELAY_SECONDS) if time_odd?
  end

  def time_odd?
  	Time.now.to_i.odd?
  end 

  def collide?
    flag = time_odd?
  	print 'x' if flag
  	flag
  end

  def delay_write attemp
  	sleep(rand([10, attemp].min ** 2) / 100)
  end
end