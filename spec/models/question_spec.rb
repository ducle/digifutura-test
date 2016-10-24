require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:questionnaire) }
  it { should have_many(:answers) }
end
