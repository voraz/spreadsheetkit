module Spreadsheetkit
  
  class Format
    attr_reader :style, :inline_style
    
    def initialize(html)
      
      unless html.blank?
        @style = Spreadsheet::Format.new
        
        unless html[:style].blank?
          create_hash_style html[:style]
          @font = Spreadsheetkit::Font.new @style.font, @inline_style
          parse_style
        end
        
        merge html[:colspan]
      end
    end
    
    private
    
    def create_hash_style(inline_style)
      @inline_style = {}
      inline_style.split(';').each do |attribute|
        attr, value = attribute.split(':')
        unless value.blank? && attr.blank?
          @inline_style.store attr.strip, value.strip
        end
      end
    end
    
    def merge(colspan)
      @style.horizontal_align = :merge if colspan.to_i > 1
    end
    
    def parse_style
      @style.font = @font.style
      inline_style.each do |attr, value|
        case attr
          when 'border' then border(value)
          when 'text-align' then text_align(value)
          when 'vertical-align' then vertial_align(value)
        end
      end
    end
    
    def border(value)
      #p value 
      #@style.horizontal_align = value.to_sym
    end
        
    def text_align(value)
      @style.horizontal_align = value.to_sym
    end
    
    def vertial_align(value)
      case value
      when /baseline|bottom|text-bottom/ then @style.vertical_align = :bottom
      when /top|text-top/ then @style.vertical_align = :top
      when 'middle' then @style.vertical_align = :middle
      end
    end
    
  end
  
end
