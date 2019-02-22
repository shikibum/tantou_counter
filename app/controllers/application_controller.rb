# frozen_string_literal: true

class ApplicationController < ActionController::Base
  attr_reader :current_user
  helper_method :current_user

  def require_current_user
    if session[:user_id].nil?
      @current_user = User.create(share_id: SecureRandom.hex(16))
      session[:user_id] = @current_user.id
    else
      @current_user = User.find(session[:user_id])
    end
  end
end
