require 'test_helper'

class NavigationTest < ActiveSupport::IntegrationCase
  test 'xls request sends a xls as file' do
    visit root_path
    find('#example1').click_link('XLS')
    assert_equal 'binary', headers['Content-Transfer-Encoding']
    assert_equal 'attachment; filename="contents.xls"',
    headers['Content-Disposition']
    assert_equal 'application/vnd.ms-excel', headers['Content-Type']
  end
  
  test 'example 2 xls request sends a xls as file' do
    visit root_path
    find('#example2').click_link('XLS')
    assert_equal 'binary', headers['Content-Transfer-Encoding']
    assert_equal 'attachment; filename="contents.xls"',
    headers['Content-Disposition']
    assert_equal 'application/vnd.ms-excel', headers['Content-Type']
  end  

  protected

  def headers
    page.response_headers
  end

end
