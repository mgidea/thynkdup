require 'spec_helper'

feature "User deletes a nutshell", %Q{
  As an authenticated User
  I want to be able to delete a thynkdup
  so that I can remove things I do not need anymore
} do

#   Acceptance Criteria
# * User must be authenticated and the owner of nutshell
# * Upon successful deletion the nutshell will no longer exist
# * unauthenticated users can not see delete link
# * User will be notified when successful

  scenario "authenticated user successfully deletes nutshell" do
    user = FactoryGirl.create(:user)
    idea = FactoryGirl.create(:nutshell, user: user)
    prev_count = user.nutshells.count
    sign_in_as(user)
    visit nutshell_path(idea)
    click_link "Delete Your Thynkdup"

    expect(page).to have_content "Your Thynkdup has been Removed.  Let's Work on Some new Ideas."
    expect(user.nutshells.count).to eql(prev_count - 1)
  end

  scenario "wrong authenticated user can not delete nutshell" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    idea = FactoryGirl.create(:nutshell, user: user2)
    sign_in_as(user)

    visit nutshell_path(idea)

    expect(page).to_not have_content "Delete Thynkdup"
    expect(page).to have_content "This is not your Thynkdup"
  end

  context "As an unauthenticated user" do
    scenario "user can not see a delete link and is prompted to login" do
      idea = FactoryGirl.create(:nutshell)

      visit nutshell_path(idea)
      expect(page).to_not have_content "Delete Thynkdup"
      expect(page).to have_content "Please Sign Up or Login if you want to view this page."
    end
  end
end

