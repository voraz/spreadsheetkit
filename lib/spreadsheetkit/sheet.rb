module Spreadsheetkit
  
  class Sheet
    attr_accessor :sheet, :table, :rows, :title
    
    def initialize(table, options = {})
      @table = table
      
      @rows = []
      @table.css("tr").each{ |tr| @rows << Spreadsheetkit::Row.new(tr) }
      @title = @table[:title]
    end
    
    def render(xls)
      @sheet = xls.create_worksheet
      @sheet.name = @title unless @title.blank?
      
      @rows.each_with_index do |row, row_x| 
        row.render @sheet.row(row_x)
      end
    end
    
  end
  
end
