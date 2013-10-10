require 'spec_helper'

feature "User contextualizes nutshell", %Q{
  As a new user
  I would like to contextualize my idea by listing relevant information
  so that I can better describe its mileu
 } do

  # ACCEPTANCE CRITERIA
  # -"nutshell" must be completed
  # -current users  will be prompted to fill in predetermined list after filling in "nutshell"
  # -Users must provide at least one point of context
  scenario "user selects a contextul category successfully" do
    idea = FactoryGirl.build(:nutshell)
    user = idea.user
    idea_count = user.nutshells.count
    # prev_count = idea.categorizations.count
    sign_in_as(user)
    visit new_nutshell_path
    fill_in "Title", with: idea.title
    fill_in "Content", with: idea.content
    select "art", from: "Context of Thynkdup"

    click_button "Create Thynkdup"

    expect(idea.categorizations.count).to eql(prev_count + 1)
    expect(user.nutshells.count).to eql(idea_count + 1)
    expect(page).to have_content "Sounds like a great idea!"
  end


end


