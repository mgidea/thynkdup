require 'spec_helper'

feature "user deletes a profile", %Q{
  As an authenticated user
  I want to be able to delete a profile
  so that I can control my public presence
} do

#   Acceptance Criteria
# * User must be authenticated to delete profile
# * Only authors can delete their profiles
# * User will be notified of either successful deletion
# * a profile will be removed from database

  let(:user) {FactoryGirl.create(:user)}
  let!(:idea) {FactoryGirl.create(:nutshell, user: user)}
  let!(:profile) {FactoryGirl.create(:profile, user: user)}

  scenario "author successfully deletes their profile" do
    sign_in_as(user)
    binding.pry
    prev_count = user.profiles.count
    visit profile_path(profile)
    click_link "Delete Profile"

    expect(user.profiles.count).to eql(prev_count - 1)
    expect(page).to have_content "You just deleted your profile.  Follow the link to add profile to create a new one"
    expect(page).to have_content idea.title
  end

  scenario "non-author can not delete account" do
    'user_views_profile_spec.rb'
  end

  context "as an unauthenticated user" do
    scenario "user is unable to delete profile" do
      'user_views_profile_spec.rb'
    end
  end
end


