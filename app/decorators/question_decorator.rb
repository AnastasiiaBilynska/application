# frozen_string_literal: true

class QuestionDecorator < ApplicationDecorator
  decorates :question
  delegate_all
  decorates_association :user

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def formatted_created_at
    l created_at, format: :long
  end
end
