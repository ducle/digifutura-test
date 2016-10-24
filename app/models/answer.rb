class Answer < ApplicationRecord
  belongs_to :question

  scope :correct_answers,  -> { where(is_answer: true) }
end
