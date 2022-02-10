# frozen_string_literal: true

class AnswerDecorator < ApplicationDecorator
  decorates :answer
  delegate_all
  decorates_association :user

  def formatted_created_at
    l created_at, format: :long
  end
end
