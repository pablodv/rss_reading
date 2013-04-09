require 'spec_helper'

feature "Sign up" do
  scenario "should sign up a valid user" do
    visit "/"

    within "#new_user" do
      fill_in "user_first_name", with: "Lionel"
      fill_in "user_last_name",  with: "Messi"
      fill_in "user_username",   with: "lio10"
      fill_in "user_email",      with: "lio10@messi.com"
      fill_in "user_password",   with: "12345678"
      fill_in "user_password_confirmation", with: "12345678"
      click_button 'Sign up'
    end

    page.should have_content "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
  end
end
