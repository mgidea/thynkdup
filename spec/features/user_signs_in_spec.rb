require 'spec_helper'

feature "User signs in", %Q{
  As a an authenticated user
  I want to access my account
  so that I can explore the website
} do

# ACCEPTANCE CRITERIA
# -I will enter a valid email
# -I must enter matching authentic password
# -Invalid or unmatching email or password will cause an error message to appear,
#     which will direct me to insert proper values
# -A signed in user can not sign in again
  scenario "user successfully signs in" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "LOGIN"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    expect(page).to have_content "Let's work on those ideas together"
    expect(page).to have_content "LOGOUT"
    expect(page).to_not have_content "LOGIN"
  end

  scenario "user fails to sign in" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "LOGIN"
    click_button "Sign In"

    expect(page).to have_content "Invalid email or password"
    expect(page).to have_content "LOGIN"
    expect(page).to_not have_content "LOGOUT"
  end

  scenario "user enters invalid password" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "LOGIN"
    fill_in "Email", with: user.email
    fill_in "Password", with: "different"
    click_button "Sign In"

    expect(page).to have_content "Invalid email or password"
    expect(page).to have_content "LOGIN"
    expect(page).to_not have_content "LOGOUT"
  end
end
