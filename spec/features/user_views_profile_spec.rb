require 'spec_helper'

feature "user views a profile", %Q{
  As an authenticated user
  I want to view my profile
  so that I can see what how I am presenting myself
} do

#   Acceptance Criteria
# * Only the author of the profile can see the private profile
# * User will see their profile information as well as nutshell titles with number of notes
# * User name will be identified
# * Non-authors will not be able to view the private version, as they will be directed to public page
# * authors will see delete and update links while non-authors will not

  let(:user) { FactoryGirl.create(:user) }
  let!(:idea) { FactoryGirl.create(:nutshell, user: user) }
  let!(:profile) { FactoryGirl.create(:profile, user: user) }

  scenario "user views their profile" do
    FactoryGirl.create_list(:note, 3, nutshell: idea)
    sign_in_as(user)
    visit profile_path(profile)

    expect(page).to have_content profile.occupation, profile.goals
    expect(page).to have_content profile.user.full_name
    expect(page).to have_content profile.user.nutshells.first.title
    expect(page).to have_content profile.user.nutshells.first.notes.count
    expect(page).to have_content "Update Profile"
    expect(page).to have_content "Delete Profile"
  end

  scenario "non-author views public profile of author" do
    user2 = FactoryGirl.create(:user)
    sign_in_as(user2)
    visit profile_path(profile)

    expect(page).to_not have_content "Update Profile"
    expect(page).to_not have_content "Delete Profile"
  end
end
