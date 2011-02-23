module Spreadsheetkit
  
  class Font
    attr_reader :style
        
    def initialize(style, inline_style)
      @style = style
      parse inline_style
    end
    
    def parse(inline_style)
      inline_style.each do |attr, value|
        case attr
        when 'font-size' then font_size(value)
        when 'font-style' then font_style(value)
        when 'font-weight' then font_weight(value)
        when 'text-decoration' then font_style(value)
        when 'text-shadow' then text_shadow(value)
        when 'vertical-align' then vertial_align(value)          
        end
      end
    end
    
    private
    
    def font_size(value)
      unless value.include?("%")
        value = value.scan(/\d+/)[0]
        @style.size = value.to_i unless value.blank?
      end
    end

    def font_style(value)
      @style.italic = true if value == 'italic'
    end
            
    def font_weight(value)
      if value.to_i > 0
        @style.weight = value
      elsif 
        value = value.to_sym
        @style.weight = value if [:normal, :bold].include?(value)
      end
    end
    
    def text_decoration(value)
      @style.underline = :single if value == 'underline'
    end
    
    def text_shadow(value)
      @style.shadow = true
    end
    
    def vertial_align(value)
      case value
      when 'sub' then @style.escapement = :subscript
      when 'super' then @style.escapement = :superscript
      end
    end
  end
  
end
