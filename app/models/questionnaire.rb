class Questionnaire < ApplicationRecord

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_many :questions, dependent: :destroy

  has_and_belongs_to_many :users

  validates :name, presence: true
end
