Given /^I am on the home page$/ do
  visit "/"
end

Then /^I should see \"([^"]+)"$/ do |string|
  page.has_content?(string).should be_true
end

When /^I follow \"([^"]+)"$/ do |string|
  click_link string
end