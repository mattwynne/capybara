require 'spec_helper'
require 'capybara/rspec'

Capybara.app = TestApp

describe 'capybara/rspec' do
  it "should include Capybara in rpsec" do
    visit('/foo')
    page.body.should include('Another World')
  end

  context "resetting session" do
    it "sets a cookie in one example..." do
      visit('/set_cookie')
      page.body.should include('Cookie set to test_cookie')
    end

    it "...then it is not availbable in the next" do
      visit('/get_cookie')
      page.body.should_not include('test_cookie')
    end
  end

  context "setting the current driver" do
    it "sets the current driver in one example..." do
      Capybara.current_driver = :selenium
    end

    it "...then it has returned to the default in the next example" do
      Capybara.current_driver.should == :rack_test
    end
  end

  it "switches to the javascript driver when giving it as metadata", :js => true do
    Capybara.current_driver.should == :selenium
  end

  it "switches to the given driver when giving it as metadata", :driver => :culerity do
    Capybara.current_driver.should == :culerity
  end
end
