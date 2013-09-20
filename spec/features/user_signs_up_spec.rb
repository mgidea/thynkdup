require 'spec_helper'

feature "user signs up", %q{
  As a curious user
  I want to create an account
  so that I can use thynkdup
  } do


# ACCEPTANCE CRITERIA
# -I must use a valid email address
# -if email address is invalid produce error message
# -I must create a unique password
# -if email and password are valid, I will gain access to the application
# -When completed I am a signed in user and I am directed to my new profile page
  scenario "user signs up succesfully" do
    email = "tom@corley.com"
    visit new_user_registration_path
    fill_in "Email", with: email
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_button "Sign Up"

    expect(page).to have_content "Get ready to build on your ideas!"
    expect(User.find_by(email: email)).to be_present
  end

end

