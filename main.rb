require 'green_shoes'


BAUD_ARRAY = [9600, 11200, 15300, 19600]

Shoes.app title: 'RSerial', width: 700, height: 500 do
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
	  		  @text_box.text = ''
	  	  end
  		end
  		stack do
  			BAUD_ARRAY.each{|baud| flow { radio :baud; inscription baud } }
  		end
    end
    @messages = stack(margin: 5, width: 445){ border gray } 
  end
end

