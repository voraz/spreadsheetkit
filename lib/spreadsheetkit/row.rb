module Spreadsheetkit
  
  class Row
    attr_reader :cells, :tr, :format, :merge
    
    def initialize(tr)
      @tr = tr
      @format = Spreadsheetkit::Format.new(@tr)
      
      @cells = []
      @tr.css("td, th").each do|td| 
        cell = Spreadsheetkit::Cell.new(td)
        @merge = true if cell.merge?
        @cells << cell
      end
    end
    
    def cell_x(cell)
      index = @cells.index(cell)
      
      if merge? && index > 0
        @cells[0..index-1].each_with_index do |prev_cell, i| 
          index += i + prev_cell.additional_columns
        end
      end
      
      index
    end
    
    def merge?
      merge
    end
  end
  
end
