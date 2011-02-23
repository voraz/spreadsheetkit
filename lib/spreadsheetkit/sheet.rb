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
        @sheet.row(row_x).default_format = row.format.style
        
        row.cells.each do |cell|
          cell_x = row.cell_x(cell)
          
          if cell.merge?
            cell_x.upto(cell_x + cell.additional_columns) do |i| 
              @sheet.row(row_x).set_format(i, cell.format.style)
            end
          else
            @sheet.row(row_x).set_format(cell_x, cell.format.style)
          end

          @sheet[row_x, cell_x] = cell.content
        end
      end
    end
    
  end
  
end
