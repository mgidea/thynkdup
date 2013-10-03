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
  user = FactoryGirl.create(:user)
    sign_in_as user

end


