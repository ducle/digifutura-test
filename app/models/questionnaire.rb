class Questionnaire < ApplicationRecord
  validates :name, presence: true

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_many :questions, dependent: :destroy
end
