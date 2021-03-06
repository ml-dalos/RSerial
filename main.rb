require 'green_shoes'
require_relative 'port'

ADRESS = ENV['PORT']

serialport = Port.new ADRESS.to_s

Shoes.app title: 'RSerial', width: 700, height: 500 do
  background dimgray
  flow do
    @contol = stack margin: 20, width: 250 do
      inscription fg "Port adress: #{ADRESS}", whitesmoke
      caption fg 'Write your message', whitesmoke
      @text_box = edit_line
      button 'Send message' do
        unless @text_box.text.empty?
          $messages.append do
            stack width: 200 do
              para fg @text_box.text, whitesmoke 
            end
          end
          serialport.write(@text_box.text)
          @text_box.text = ''
        end
      end
      list_box items: Port::BAUD_ARRAY, choose: 9600 do |list|
        serialport.set_baud_rate(list.text.to_i)
      end
      para fg "Debugger", whitesmoke
      $debugger = stack(margin: 5, width: 230){ } 
    end
    $messages = stack(margin: 5, width: 445){ border gray } 
  end
  Thread.new do
    message = ''
    debug_message = ''
    loop do
      byte = serialport.read 1
      debug_message << byte
      if byte == Port::END_SIGNAL
        $debugger.clear do
          border gray
          stack width: 240 do
            para fg debug_message, lightyellow
          end
        end 
        $messages.append do
          stack width: 200, margin_left: 250 do
            para fg message, lightyellow
          end
        end
        debug_message = ''
        message = '' 
      elsif byte == Port::JAM_SIGNAL
        message.chop!  
      else
        message << byte  
      end
    end
  end
end