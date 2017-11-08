require 'green_shoes'
require_relative 'port'

ADRESS = ENV['PORT']
BAUD_ARRAY = [110, 150, 300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200]

$serialport = SerialPort.new ADRESS.to_s
Shoes.app title: 'RSerial', width: 700, height: 500 do
	Thread.new do
		loop do
			@message = $serialport.read
			unless @message.empty? 
			  @messages.append do
			 	  stack width: 200, margin: 250 do
				 	  para fg @message, whitesmoke
			    end
			  end
		  end
		end
	end
  background dimgray
  flow do
    @contol = stack margin: 20, width: 250 do
  	  caption fg 'Write your message', whitesmoke
  	  @text_box = edit_box
  	  button 'Send message' do
  	    unless @text_box.text.empty?
  	      @messages.append do
		 	    	stack width: 200 do
			 	  		para fg @text_box.text, whitesmoke 
		  	 	  end
	  	 	  end
	  	 	  $serialport.write(@text_box.text)
	  		  @text_box.text = ''
	  	  end
  		end
  		list_box items: BAUD_ARRAY, choose: 9600 do |list|
        $serialport.set_baud_rate(list.text.to_i)
      end 
    end
    @messages = stack(margin: 5, width: 445){ border gray } 
  end
end
