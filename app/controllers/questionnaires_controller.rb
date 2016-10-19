class QuestionnairesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_questionnaire, only: [:show, :edit, :update, :destroy, :alert_answered]

  def index
    @questionnaires = Questionnaire.page(params[:page])
  end

  def show
  end

  def new
    @questionnaire = Questionnaire.new
  end

  def edit
  end

  def create
    @questionnaire = Questionnaire.new(questionnaire_params)
    @questionnaire.owner = current_user
    if @questionnaire.save
      redirect_to @questionnaire, notice: 'Questionnaire was successfully created.'
    else
      render :new
    end
  end

  def update
    if @questionnaire.update(questionnaire_params)
      redirect_to @questionnaire, notice: 'Questionnaire was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @questionnaire.destroy
    redirect_to questionnaires_url, notice: 'Questionnaire was successfully destroyed.'
  end

  def sharing
    @questionnaire = current_user.questionnaires.find(params[:id])
  end

  def share
    @questionnaire = current_user.questionnaires.find(params[:id])
    @questionnaire.user_ids = share_param[:user_ids]
    redirect_to questionnaires_path
  end

  def alert_answered
    @user = User.find params[:user_id]
    if @user.user_quizzes.where(questionnaire: @questionnaire).count == 0
      @message = "#{@user.name} has not taken the quiz yet"
    end
  end

  private

    def set_questionnaire
      @questionnaire = Questionnaire.find(params[:id])
    end

    def questionnaire_params
      params.require(:questionnaire).permit(:name)
    end

    def share_param
      params.require(:questionnaire).permit(:user_ids => [])
    end
end
