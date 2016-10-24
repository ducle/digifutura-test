class Question < ApplicationRecord

  belongs_to :questionnaire
  has_many :answers, dependent: :destroy

  validates :content, :point, presence: true
  validate :has_valid_answers
  validate :has_only_and_at_least_one_correct_answer

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc { |attributes| attributes['content'].blank? }

  before_validation :set_point

  private

  def set_point
    self.point ||= 0
  end

  def has_valid_answers

  end

  def has_only_and_at_least_one_correct_answer
    if self.answers.select{ |a| a.is_answer && !a.marked_for_destruction? }.size != 1
      errors.add(:base, "Question must have one correct answer")
    end

    if self.answers.select{ |a| !a.marked_for_destruction? }.size < 2
      errors.add(:base, "Question must have at least 2 answers")
    end
  end

end
