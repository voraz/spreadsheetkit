module Spreadsheetkit
  autoload :Cell, "spreadsheetkit/cell"
  autoload :Font, "spreadsheetkit/font"
  autoload :Format, "spreadsheetkit/format"
  autoload :Row, "spreadsheetkit/row"
  autoload :Sheet, "spreadsheetkit/sheet"
  autoload :StyleParser, "spreadsheetkit/style_parser"
  
  class Base
    include StyleParser
    
    attr_reader :html, :xls, :sheets
    
    def initialize(html)
      @html = parse_html(Nokogiri::HTML(html))
      
      @sheets = []
      @html.css("table").each do |table|
        @sheets << Spreadsheetkit::Sheet.new(table)
      end
    end
    
    def render
      sio = StringIO.new
      compile_xls
      xls.write(sio)
      sio.string
    end
    
    private
    
    def compile_xls
      @xls = Spreadsheet::Workbook.new
      @sheets.each { |sheet| sheet.render(@xls) }
    end
    
  end
end
