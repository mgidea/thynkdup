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

  let(:person) {FactoryGirl.create(:user)}
  let(:idea) {FactoryGirl.build(:nutshell)}


  scenario "User creates nutshell" do
    user = FactoryGirl.create(:user)
    prev_count = Nutshell.count
    sign_in_as(user)
    visit new_nutshell_path
    fill_in "Title", with: idea.title
    fill_in "Content", with: idea.content
    click_button "Create Thynkdup"
    expect(page).to have_content "Sounds like a great idea!"
    expect(Nutshell.count).to eql(prev_count + 1)
    expect(page).to have_content idea.content
  end

  scenario "User fails to create Nutshell" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    prev_count = Nutshell.count
    visit new_nutshell_path
    click_button "Create Thynkdup"

    expect(page).to have_content "can't be blank"
    expect(Nutshell.count).to eql(prev_count)
  end

  scenario "User attempts to create nutshell unauthenticated" do
    visit new_nutshell_path
    expect(page).to have_content "You must be logged in to view this page"
    expect(page).to_not have_content "Title", "Content"
  end
end


