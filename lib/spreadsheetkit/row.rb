module Spreadsheetkit
  
  class Row
    attr_reader :cells, :tr, :format, :merge, :row
    
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
    
    def merge?
      merge
    end
    
    def render(row)
      @row = row
      apply_style
      
      @cells.each do |cell|
        cell_x = cell_x(cell)
        
        if merge?
          cell_x.upto(cell_x + cell.additional_columns) do |i| 
            row.set_format(i, cell.format.style)
          end
        else
          row.set_format(cell_x, cell.format.style)
        end
        row[cell_x] = cell.content
      end
    end
    
    private
    def cell_x(cell)
      index = @cells.index(cell)
      
      if merge? && index > 0
        @cells[0..index-1].each_with_index do |prev_cell, i| 
          index += i + prev_cell.additional_columns
        end
      end
      
      index
    end
        
    def apply_style
      @row.default_format = @format.style
      @format.inline_style.each do |attr, value|
        case attr
          when 'height' then height(value)
        end
      end
    end
    
    def height(value)
      size = Spreadsheetkit::Util.number_from_size(value)
      @row.height = size unless size.blank?
    end
  end
  
end
