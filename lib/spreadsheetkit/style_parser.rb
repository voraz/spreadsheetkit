# Extracted from https://github.com/binarylogic/mail_style/blob/master/lib/mail_style/inline_styles.rb
# Credits: Jim Neath

module Spreadsheetkit
  
  module StyleParser
    def parse_html(html)
      # Parse original html
      html_document = absolutize_image_sources(html)

      # Write inline styles
      element_styles = {}
      
      css_parser(html_document).each_selector do |selector, declaration, specificity|
        next if selector.include?(':')
        html_document.css(selector).each do |element|
          declaration.to_s.split(';').each do |style|
            # Split style in attribute and value
            attribute, value = style.split(':').map(&:strip)

            # Set element style defaults
            element_styles[element] ||= {}
            element_styles[element][attribute] ||= { :specificity => 0, :value => '' }

            # Update attribute value if specificity is higher than previous values
            if element_styles[element][attribute][:specificity] <= specificity
              element_styles[element][attribute] = { :specificity => specificity, :value => value }
            end
          end
        end
      end

      # Loop through element styles
      element_styles.each_pair do |element, attributes|
        # Elements current styles
        current_style = element['style'].to_s.split(';').sort

        # Elements new styles
        new_style = attributes.map{|attribute, style| "#{attribute}: #{update_image_urls(style[:value])}"}

        # Concat styles
        style = (current_style + new_style).compact.uniq.map(&:strip).sort

        # Set new styles
        element['style'] = style.join(';')
      end

      # Return HTML
      html_document
    end
    
    def css_parser(html)
      parser = CssParser::Parser.new
      
      html.xpath("//head/link[@type='text/css']" ).each do |style|
        parser.load_uri! "#{Rails.root}/public#{style[:href]}"
      end
      
      parser
    end
    
    
    def absolutize_image_sources(document)
      document.css('img').each do |img|
        src = img['src']
        img['src'] = src.gsub(src, absolutize_url(src))
      end

      document
    end
    
    # Absolutize URL (Absolutize? Seriously?)
    def absolutize_url(url, base_path = '')
      ############# Refactor
      # original_url = url
      #unless original_url[URI::regexp(%w[http https])]
      #  protocol = default_url_options[:protocol]
      #  protocol = "http://" if protocol.blank?
      #  protocol+= "://" unless protocol.include?("://")

      #  host = default_url_options[:host]

      #  [host,protocol].each{|r| original_url.gsub!(r,"") }
      #  host = protocol+host unless host[URI::regexp(%w[http https])]

      #  url = URI.join host, base_path, original_url
      #end

      #url.to_s
      
      url
    end
    
    # Update image urls
    def update_image_urls(style)
      ############# Refactor
      #if default_url_options[:host].present?
        # Replace urls in stylesheets
      #  style.gsub!($1, absolutize_url($1, 'stylesheets')) if style[/url\(['"]?(.*?)['"]?\)/i]
      #end

      style
    end    
      
  end
  
end
