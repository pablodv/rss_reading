Given /^the following user record$/ do |table|
  table.hashes.each do |hash|
    @user = FactoryGirl.create(:user, username: hash['username'])
    @user.confirm!
  end
end

Given /^I am logged in as "([^\"]*)" with password "([^\"]*)"$/ do |username, password|
  unless username.blank?
    visit "/"
    within ".navbar-form" do
      fill_in "user_username", with: username
      fill_in "user_password", with: password
      click_button("Sign in")
    end
  end
end

Then /^I should see "([^\"]*)"$/ do |string|
  page.has_content?(string).should be_true
end

Given /^I have no (.+)$/ do |collection|
  eval collection.classify + ".delete_all"
end

When /^I follow "([^\"]*)"$/ do |string|
  click_link string
end

And /^I fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in field, with: value
end

And /^I press "([^\"]*)"$/ do |string|
  click_button string
end

When /^I confirm popup$/ do
  page.evaluate_script('window.confirm = function() { return true; }')
end

And /I should not see "([^\"]*)"$/ do |string|
  page.has_content?(string).should_not be_true
end