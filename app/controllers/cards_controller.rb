class CardsController < ApplicationController
  before_action :logged_in_admin, only: [:create, :destroy]

  def index
    @cards = Card.paginate(page: params[:page])
  end

  def create
  end

  def destroy
  end
end
