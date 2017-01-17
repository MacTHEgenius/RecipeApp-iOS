require 'spec_helper'

describe Author do
  before { @author = FactoryGirl.build(:author) }

  subject { @author }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }

  it { should validate_uniqueness_of(:auth_token)}

  it { should be_valid }
end

describe "when email is not present" do
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }
end


describe "#generate_authentication_token!" do
  it "generates a unique token" do
    Devise.stub(:friendly_token).and_return("auniquetoken123")
    @author.generate_authentication_token!
    expect(@author.auth_token).to eql "auniquetoken123"
  end

  it "generates another token when one already has been taken" do
    existing_author = FactoryGirl.create(:user, auth_token: "auniquetoken123")
    @author.generate_authentication_token!
    expect(@author.auth_token).not_to eql existing_author.auth_token
  end
end