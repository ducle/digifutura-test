class QuizzesController < ApplicationController
  before_action :authenticate_user!

  def index
    @questionnaires = current_user.shared_questionnaires.all
  end

  def take
    @questionnaire = current_user.shared_questionnaires.find params[:questionnaire_id]
    if current_user.user_quizzes.where(questionnaire: @questionnaire).exists?
      redirect_to quizzes_url
    else
      current_user.user_quizzes.create(questionnaire: @questionnaire, start_time: Time.zone.now)
    end
  end

  def answer
    @questionnaire = current_user.shared_questionnaires.find params[:questionnaire_id]
    params[:user_answers].each do |k, user_answer|
      current_user.user_answers.create(question_id: user_answer[:question_id], answer_id: user_answer[:answer_id])
    end
    redirect_to result_quizzes_url(questionnaire_id: @questionnaire)
  end

  def result
    @user = User.find_by(id: params[:user_id]) || current_user
    @questionnaire = @user.shared_questionnaires.find params[:questionnaire_id]
  end
end
