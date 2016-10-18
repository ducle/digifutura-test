class Question < ApplicationRecord
  validates :content, :point, presence: true

  belongs_to :questionnaire
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc { |attributes| attributes['content'].blank? }

  before_validation :set_point

  private

  def set_point
    self.point ||= 0
  end
end
