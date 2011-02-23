Dummy::Application.routes.draw do
  root :to => "home#index"
  
  
  match "/reports/example1(.:format)", :to => "reports#example1", :as => :report_example1
  match "/reports/example2(.:format)", :to => "reports#example2", :as => :report_example2
end
