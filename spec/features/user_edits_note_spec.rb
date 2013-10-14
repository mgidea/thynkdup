require 'spec_helper'

feature "User edits nutshell", %Q{
  As an authenticated User
  I want edit my note
  So that my thoughts and changes are reflected
} do

#   Acceptance Criteria
# * Only an authenticated user of the specific nutshell can edit it
# * If an unauthenticated user attempts to view the page they will be redirected to sign in
# * If the wrong user attempts to update they will be redirected to their page
# * If it fails to update the user will be notified
# * User can follow edit link to change existing note

  scenario "user successfully updates note" do
    user = FactoryGirl.create(:user)
    idea = FactoryGirl.create(:nutshell, user: user)
    note = FactoryGirl.create(:note, nutshell: idea)
    new_note = FactoryGirl.build(:note, nutshell: idea, content: "Notes")

    sign_in_as(user)
    visit edit_nutshell_note_path(idea, note)
    fill_in "Title", with: new_note.title
    fill_in "Note", with: new_note.content
    click_button "Update Your Note"

    expect(page).to have_content new_note.content
    expect(page).to have_content "Your Note has been Updated"

  end

  scenario "User Fails to Update note" do
    user = FactoryGirl.create(:user)
    idea = FactoryGirl.create(:nutshell, user: user)
    note = FactoryGirl.create(:note, nutshell: idea)

    sign_in_as(user)
    visit edit_nutshell_note_path(idea, note)

    fill_in "Title", with: ""
    fill_in "Note", with: ""
    click_button "Update Your Note"

    expect(page).to have_content "can't be blank"
    expect(page).to_not have_content "Your Note has been Updated"
  end

  scenario "User expects to see edit link on nutshell page with notes" do
    user = FactoryGirl.create(:user)
    idea = FactoryGirl.create(:nutshell, user: user)
    note = FactoryGirl.create(:note, nutshell: idea)
    sign_in_as(user)
    visit nutshell_path(idea)
    click_link "Edit Note"

    expect(page).to have_content "Update Your Note:"
  end

  context "As an unauthenticated user" do
    scenario "user cannot view edit page" do
      user = FactoryGirl.create(:user)
      idea = FactoryGirl.create(:nutshell, user: user)
      note = FactoryGirl.create(:note, nutshell: idea)

      visit edit_nutshell_path(idea, note)

      expect(page).to_not have_content "Update"
      expect(page).to have_content "Please Sign Up or Login if you want to view this page."
    end
  end

  context "As the wrong signed in user" do
    scenario "only note owner can update their nutshell" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      idea = FactoryGirl.create(:nutshell, user: user2)
      note = FactoryGirl.create(:note, nutshell: idea)

      sign_in_as(user)
      visit edit_nutshell_path(idea, note)

      expect(page).to_not have_content "Update"
      expect(page).to have_content "This is not your Thynkdup"
    end
  end
end


