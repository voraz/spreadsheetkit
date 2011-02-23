require "action_controller"
require 'spreadsheet'

Mime::Type.register "application/vnd.ms-excel", :xls

module Spreadsheetkit
  autoload :Base, "spreadsheetkit/base"
  
  ActionController::Renderers.add :xls do |filename, options|
    xls = Spreadsheetkit::Base.new(render_to_string(options))
    send_data(xls.render, :filename => "#{filename}.xls", :type => "application/vnd.ms-excel", :disposition => "attachment")
  end  
end

