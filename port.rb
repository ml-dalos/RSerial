require 'rubyserial'

class SerialPort < Serial
	attr_reader :adress

	def initialize adress ,baude_rate=9600, data_bits=8, parity=:none 
    @adress = adress
    super
  end

  def set_baud_rate baud_rate
    this = SerialPort.new @adress, baud_rate
  end
end