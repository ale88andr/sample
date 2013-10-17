module ApplicationHelper

  DEFAULT_APP_NAME = Rails.application.class.parent

  def title text = nil
    text.nil? ? DEFAULT_APP_NAME : DEFAULT_APP_NAME.to_s.concat(" | #{text}")
  end
end