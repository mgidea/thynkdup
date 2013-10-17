require 'spec_helper'

feature "User signs out",  %Q{
  As a signed in user
  I want to sign out
  so that no one else can access my account details
} do

  # Acceptance Criteria

  # - A signed in user can logout
  # - once signed out, they should see a login link
  # - once signed out they should not see a logout link
  # - A vistor can not sign out

  scenario "Signed in user signs out" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "LOGIN"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
    click_link "LOGOUT"

    expect(page).to_not have_content "LOGOUT"
    expect(page).to have_content "LOGIN", "SIGN UP"
  end

  scenario "visitor can not logout" do
    visit root_path
    expect(page).to_not have_content "LOGOUT"
  end
end
