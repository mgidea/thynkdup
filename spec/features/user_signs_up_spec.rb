require 'spec_helper'

feature "user signs up", %Q{
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
    visit root_path
    click_link "Sign Up"

    fill_in "Email", with: email
    fill_in("Password", with: 'password', :match => :prefer_exact)
    fill_in("Password Confirmation", with: 'password', :match => :prefer_exact)
    fill_in "First Name", with: "Tom"
    fill_in "Last Name", with: "Corley"

    click_button "Sign Up"
    expect(page).to have_content "Get ready to build on your ideas!"
    expect(User.find_by(email: email)).to be_present
  end

  scenario "User does not sign up successfully" do
    prev_count = User.count
    visit root_path
    click_link "Sign Up"
    click_button "Sign Up"
    expect(page).to have_content "can't be blank"
    expect(User.count).to eql(prev_count)
  end

  scenario "User has non-matching password and password confirmation" do
    email = "tom@corley.com"
    visit root_path
    click_link "Sign Up"
    fill_in "Email", with: email
    fill_in("Password", with: 'password', :match => :prefer_exact)
    fill_in("Password Confirmation", with: 'different', :match => :prefer_exact)
    fill_in "First Name", with: "Tom"
    fill_in "Last Name", with: "Corley"
    click_button "Sign Up"

    expect(page).to have_content "doesn't match Password"
    expect(User.find_by(email: email)).to_not be_present
  end
end

