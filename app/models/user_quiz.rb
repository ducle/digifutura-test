class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :questionnaire

  validates :user_id, uniqueness: { scope: :questionnaire_id, message: "You have taken this quiz before!"}
end
