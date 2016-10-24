class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_questionnaire
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = @questionnaire.questions
  end

  def show
  end

  def new
    @question = @questionnaire.questions.new
    2.times { @question.answers.build }
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to [@questionnaire, @question], notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to [@questionnaire, @question], notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questionnaire_url(@question.questionnaire), notice: 'Question was successfully destroyed.'
  end

  private
    def set_questionnaire
      @questionnaire = current_user.questionnaires.find(params[:questionnaire_id])
    end

    def set_question
      @question = @questionnaire.questions.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:questionnaire_id, :content, :point,
        answers_attributes: [:id, :content, :is_answer, :_destroy])
    end
end
