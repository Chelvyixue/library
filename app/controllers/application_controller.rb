# coding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_admin
    unless logged_in?
      store location
      flash[:danger] = "请登录后再试"
      redirect_to login_url
    end
  end
end
