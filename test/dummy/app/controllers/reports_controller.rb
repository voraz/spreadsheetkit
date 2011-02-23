class ReportsController < ApplicationController

  def example1
    respond_to do |format|
      format.html
      format.xls { render :xls => "contents" }
    end
  end
  
  def example2
    respond_to do |format|
      format.html
      format.xls { render :xls => "contents" }
    end
  end  
  
end

