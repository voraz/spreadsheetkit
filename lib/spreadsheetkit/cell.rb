module Spreadsheetkit
  
  class Cell
    attr_accessor :td, :colspan, :content, :format
    
    def initialize(td)
      @td = td
      @colspan = @td[:colspan].to_i
      @content = @td.content.strip
      @format = Spreadsheetkit::Format.new(@td)
    end
    
    def merge?
      @colspan > 1
    end
    
    def additional_columns
      if merge?
        @colspan - 1
      else
        1
      end
    end
  end
  
end
