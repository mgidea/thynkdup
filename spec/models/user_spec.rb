require 'spec_helper'

describe User do
  it { should     have_valid(:first_name).when("Tom","BRIAN") }
  it { should_not have_valid(:first_name).when(nil," ") }

  it { should     have_valid(:last_name).when("Corley","ANDERSON") }
  it { should_not have_valid(:last_name).when(nil," ") }

  it "has matching password and password confirmation" do
    prev_count = User.count
    user = User.new
    user.password = "password"
    user.password_confirmation = "different"
    expect(user).to_not be_valid
  end
end
