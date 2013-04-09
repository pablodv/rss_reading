require 'spec_helper'

feature "Loguin" do
  background { visit "/" }

  scenario "does sign in with twitter account" do
    visit "/"
    click_link "Sign in with Twitter"
    page.should have_content('Successfully authenticated from Twitter account.')
  end

  scenario "does sign in with Google account" do
    click_link "Sign in with Google"
    page.should have_content('Successfully authenticated from Google account.')
  end

  background { FactoryGirl.create(:user, username: "leo10") }

  scenario "does sign in" do
    within ".navbar-form" do
      fill_in "user_username", with: "leo10"
      fill_in "user_password", with: "12345678"
      click_button 'Sign in'
    end

    page.should have_content "Signed in successfully."
  end
end
