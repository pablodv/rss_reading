When /^I display the channel$/ do
  visit "/users/#{@user.id}/channels/#{@channel.id}"
end