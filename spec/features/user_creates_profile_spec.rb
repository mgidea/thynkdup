require 'spec_helper'

feature "user creates a profile", %Q{
  As an authenticated user
  I want to create a profile
  so that I will have a public presence
} do

#   Acceptance Criteria
# * User must be authenticated to create profile
# * User must have nutshell created to create profile
# * All fields are optional
# * must be associated with a user
# * User will be notified of their new profile upon success

  let(:user) {FactoryGirl.create(:user)}
  let!(:idea) {FactoryGirl.create(:nutshell, user: user)}
  let(:profile) {FactoryGirl.build(:profile, user: user)}

  scenario "user successfully creates profile" do
    prev_count = user.profiles.count

    sign_in_as(user)
    visit new_profile_path
    fill_in "Occupation", with: profile.occupation
    fill_in "Interests", with: profile.interests
    fill_in "Inspirations", with: profile.inspirations
    fill_in "Aspirations", with: profile.aspirations
    fill_in "Goals", with: profile.goals
    fill_in "Recommendations", with: profile.recommendations
    click_button "Create Profile"

    expect(user.profiles.count).to eql(prev_count + 1)
    expect(page).to have_content "Welcome to your new Profile Page"
  end

  scenario "user fills in no fields but profile is still created" do
    prev_count = user.profiles.count
    sign_in_as(user)
    visit new_profile_path
    click_button "Create Profile"

    expect(user.profiles.count).to eql(prev_count + 1)
    expect(page).to have_content "Welcome to your new Profile Page"
  end

  scenario "user tries to create profile without nutshell" do
    another = FactoryGirl.create(:user)
    sign_in_as(another)
    visit new_profile_path
    click_button "Create Profile"

    expect(page).to have_content "You must create a nutshell before working on a profile"
    expect(page).to_not have_content "Occupation"
  end

  context "as an unauthenticated user" do
    scenario "user is unable to view new profile page" do
      visit new_profile_path

      expect(page).to have_content "Please Sign Up or Login if you want to view this page."
      expect(page).to_not have_content "Occupation"
    end
  end
end
