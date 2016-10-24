require 'rails_helper'

RSpec.describe Questionnaire, type: :model do
  it "should be valid with factory method" do
    questionnaire = build(:questionnaire)
    questionnaire.should be_valid
  end

  it { should belong_to(:owner) }
end
