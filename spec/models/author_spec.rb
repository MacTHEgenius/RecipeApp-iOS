require 'spec_helper'

describe Author do
  before { @author = FactoryGirl.build(:author) }

  subject { @author }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }
end
