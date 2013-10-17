require 'spec_helper'

describe Profile do
  it { should     have_valid(:user).when(User.new) }
  it { should_not have_valid(:user).when(nil) }

  it { should belong_to :user }
end
