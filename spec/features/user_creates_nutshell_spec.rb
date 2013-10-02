require 'spec_helper'

feature "User creates nutshell", %Q{
  As a new user
  I need to create a nutshell description of idea
  so that I can publicize the gist of my idea
  } do

# ACCEPTANCE CRITERIA
# -only current signed in user can edit or produce the nutshell description
# -The nutshell cannot exceed 80 characters
# -The nutshell must be filled in after first sign up
# -an error message will appear if I try and view new pages without filling in nutshell
# -once completed and saved, I will be prompted to fill in contextual list

  scenario "User creates nutshell" do
    prev_count = Nutshell.count
    idea = FactoryGirl.build(:nutshell)
    person = FactoryGirl.create(:user)
    visit root_path
    visit new_user_session_path
    fill_in "Email", with: person.email
    fill_in "Password", with: person.password
    click_button "Sign In"
    visit new_nutshell_path
    fill_in "Title", with: idea.title
    fill_in "Content", with: idea.content
    click_button "Create Nutshell"

    expect(page).to have_content "Sounds like a great idea!"
    expect(Nutshell.count).to eql(prev_count + 1)
    expect(page).to have_content idea.content
  end
end
