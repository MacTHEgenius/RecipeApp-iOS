require 'spec_helper'

describe Mesure do
  let(:mesure) { FactoryGirl.build :mesure }
  subject { mesure }

  it { should respond_to(:name) }

  it { should validate_presence_of :name }

  it { should validate_uniqueness_of :name }
end
