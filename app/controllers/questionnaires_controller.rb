class QuestionnairesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_questionnaire, only: [:show, :edit, :update, :destroy]

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

  private

    def set_questionnaire
      @questionnaire = Questionnaire.find(params[:id])
    end

    def questionnaire_params
      params.require(:questionnaire).permit(:name)
    end
end
