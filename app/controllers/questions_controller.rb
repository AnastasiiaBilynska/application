# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :_question!, only: %i[show destroy edit update]

  def show
    @question = @question.decorate
    @answer = @question.answers.build
    @answers = @question.answers.order(created_at: :desc).page(params[:page])
    @answers = @answers.decorate
  end

  def destroy
    @question.destroy
    flash[:success] = t '.success'
    redirect_to questions_path
  end

  def edit; end

  def update
    if @question.update question_params
      flash[:success] = t '.success'
      redirect_to questions_path
    else
      render :edit
    end
  end

  def index
    @questions = Question.order(created_at: :desc).page(params[:page])
    @questions = @questions.decorate
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = t '.success'
      redirect_to questions_path
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def _question!
    @question ||= Question.find(params[:id])
  end
end
