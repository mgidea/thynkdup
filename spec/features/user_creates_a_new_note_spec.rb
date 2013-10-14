require 'spec_helper'

feature "User creates a new note", %{
  As an authenticated thinker
  I want to add noted to my nutshells
  So that I can continue to develop my idea
} do

#   Acceptance Criteria
# * User must fill in content and can optionally add a title
# * User must have an existing nutshell to create a note for it
# * only nutshell owner can add a note
# * User will be notified if they fail to create note
# * User will be notified upon success

  scenario "user successfully creates a note" do
    user = FactoryGirl.create(:user)
    idea = FactoryGirl.create(:nutshell, user: user)
    note = FactoryGirl.build(:note)
    prev_count = idea.notes.count

    sign_in_as(user)
    visit nutshell_path(idea)
    click_link "Write a New Note"
    fill_in "Note", with: note.content
    click_button "Save"

    expect(idea.notes.count).to eql(prev_count + 1)
    expect(page).to have_content "Your note has been saved"
  end

  scenario "user fails to create a note" do
    user = FactoryGirl.create(:user)
    idea = FactoryGirl.create(:nutshell, user: user)
    note = FactoryGirl.build(:note)
    prev_count = idea.notes.count
    sign_in_as(user)
    visit nutshell_path(idea, note)
    click_link "Write a New Note"
    click_button "Save"

    expect(idea.notes.count).to eql(prev_count)
    expect(page).to have_content "can't be blank"
  end

  context "user is not owner of nutshell" do
    scenario "user fails to access new note page" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      idea = FactoryGirl.create(:nutshell, user: user2)
      sign_in_as(user)
      visit new_nutshell_note_path(idea)

      expect(page).to_not have_content "Save"
      expect(page).to have_content "This is not your Thynkdup"
    end
  end

  context "user is not authenticated" do
    scenario "user fails to access new note page" do
      idea = FactoryGirl.create(:nutshell)
      visit new_nutshell_note_path(idea)

      expect(page).to_not have_content "Save"
      expect(page).to have_content "Please Sign Up or Login if you want to view this page."
    end
  end
end
