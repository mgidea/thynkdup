require 'spec_helper'

feature "User deletes a note", %Q{
  As an authenticated User
  I want to be able to delete a thynkdup note
  so that I can remove things I do not need or want anymore
} do

#   Acceptance Criteria
# * User must be authenticated and the owner of note
# * Upon successful deletion the nutshell will no longer exist
# * User will see link on edit notes page and nutshell show page
# * unauthenticated users can not see delete link
# * User will be notified when successful

  scenario "authenticated user successfully deletes note" do
    user = FactoryGirl.create(:user)
    idea = FactoryGirl.create(:nutshell, user: user)
    note = FactoryGirl.create(:note, nutshell: idea)
    prev_count = user.notes.count
    sign_in_as(user)

    visit nutshell_path(idea)
    click_link "Delete Note"

    expect(page).to have_content "Your Note has been Removed.  Add new notes to continue to develop your Thynkdup"
    expect(user.notes.count).to eql(prev_count - 1)
  end

  scenario "wrong authenticated user can not delete note" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    idea = FactoryGirl.create(:nutshell, user: user2)
    note = FactoryGirl.create(:note, nutshell: idea)
    sign_in_as(user)

    visit nutshell_path(idea)

    expect(page).to_not have_content "Delete Note"
    expect(page).to have_content "This is not your Thynkdup"
  end

  context "As an unauthenticated user" do
    scenario "user can not see a delete link and is prompted to login" do
      idea = FactoryGirl.create(:nutshell)
      note = FactoryGirl.create(:note, nutshell: idea)

      visit nutshell_path(idea)
      expect(page).to_not have_content "Delete Note"
      expect(page).to have_content "Please Sign Up or Login if you want to view this page."
    end
  end
end
