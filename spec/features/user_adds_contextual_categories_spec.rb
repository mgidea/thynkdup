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
    category = FactoryGirl.create(:category)
    category2 = FactoryGirl.create(:category, name: 'music')
    category3 = FactoryGirl.create(:category, name: 'politics')
    user = FactoryGirl.create(:user)
    idea = FactoryGirl.build(:nutshell, user: user)
    idea_count = user.nutshells.count

    sign_in_as(user)
    visit new_nutshell_path
    fill_in "Title", with: idea.title
    fill_in "Content", with: idea.content
    page.check('art')
    page.check('music')
    page.check('politics')

    click_button "Create Thynkdup"

    expect(page).to have_content "art"
    expect(page).to have_content "music"
    expect(page).to have_content "politics"
    expect(page).to have_content "Sounds like a great idea!"
  end
end
