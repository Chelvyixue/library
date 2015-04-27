# coding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by(name: params[:session][:name])
    if admin && admin.authenticate(params[:session][:password])
      flash[:success] = "登陆成功"
      log_in admin
      redirect_back_or root_url
    else
      flash.now[:danger] = "用户名或密码错误"
      render 'static_pages/_login.html.erb'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
