Given /^I am a registered user$/ do
  FactoryGirl.create(:user, username: "lio10")
end

When /^I go to the login page$/ do
  visit "/"
end

And /^I fill in username "([^"]*)" and password "([^"]*)"$/ do |username, password|
  within ".navbar-form" do
    fill_in "user_username", with: username
    fill_in "user_password", with: password
  end
end

When /^I press \"([^"]+)"$/ do |string|
  within ".navbar-form" do
    click_button string
  end
end
