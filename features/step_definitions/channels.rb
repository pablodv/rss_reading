Given /^I have channels named (.+)$/ do |names|
  names.split(", ").each do |name|
    name = name.downcase.delete(" ")
    raw_response_file = File.open(File.join(Rails.root, "spec/support/#{name}.xml"))
    stub_request(:get, "http://feeds.feedburner.com/#{name}").to_return(body: raw_response_file)

    FactoryGirl.create(:channel, user: @user, url: "http://feeds.feedburner.com/#{name}")
  end
end

When /^I go to the list of channels$/ do
  visit "/users/#{@user.id}/channels"
end

When /^I display the channel$/ do
  raw_response_file = File.open(File.join(Rails.root, "spec/support/railscasts.xml"))
  stub_request(:get, "http://feeds.feedburner.com/railscasts").to_return(body: raw_response_file)

  user = FactoryGirl.create(:user)
  channel = FactoryGirl.create(:channel, user: user, url: "http://feeds.feedburner.com/railscasts")

  visit "/users/#{user.id}/channels/#{channel.id}"
end

Then /^I should have ([0-9]+) channels?$/ do |count|
  Channel.count.should == count.to_i
end
