require 'spec_helper'

feature "user edits their profile", %Q{
  As an authenticated user
  I want to edit my profile
  so that I can change my public presence
} do

#   Acceptance Criteria
# * User must be authenticated to edit profile
# * Only authors can edit their profiles
# * User will be notified of either successful or failed update
# * a new profile will not be saved in database

  let(:user) {FactoryGirl.create(:user)}
  let!(:idea) {FactoryGirl.create(:nutshell, user: user)}
  let!(:profile) {FactoryGirl.create(:profile, user: user)}

  scenario "authenticated user successfully edits their profile" do
    prev_count = Profile.count
    sign_in_as(user)
    visit edit_profile_path(profile)
    fill_in "Goals", with: "Life-Long success"
    click_button "Update Profile"

    expect(page).to have_content "Your Profile has been updated"
    expect(page).to have_content "Life-Long success"
    expect(Profile.count).to eql(prev_count)
  end

  scenario "authenticated non-author can not edit authors profile" do
    user2 = FactoryGirl.create(:user)
    sign_in_as(user2)
    visit edit_profile_path(profile)

    expect(page).to have_content "This is the Public Version"
    expect(page).to have_content "You are not the owner of this profile"
    expect(page).to_not have_content "Update"
  end

  context "as an unauthenticated user" do
    scenario "user can not edit a profile" do
    visit edit_profile_path(profile)

    expect(page).to have_content "Please Sign Up or Login if you want to view this page"
    expect(page).to_not have_content "Update"
    end
  end
end
