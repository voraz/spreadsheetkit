module Spreadsheetkit
  
  class Util
    
    class << self
      def number_from_size(size)
        number = size.scan(/\d+/)[0] unless size.include?("%")
        number.to_i unless number.blank?
      end
    end
    
  end
  
end
