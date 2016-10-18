class UserService
  def self.point(user, questionnaire)
    return nil if user.user_quizzes.where(questionnaire: questionnaire).count == 0
    user_answers = user.user_answers.where(question_id: questionnaire.question_ids)
    total_point = 0
    user_answers.find_each do |o|
      total_point += o.question.point if o.answer.is_answer
    end
    total_point
  end

end
