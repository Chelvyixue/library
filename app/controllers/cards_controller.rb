# coding: utf-8
class CardsController < ApplicationController
  before_action :logged_in_admin, only: [:create, :destroy]

  def index
    @card = Card.new()    # for adding a card
    @cards = Card.paginate(page: params[:page])    # for showing cards
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      flash[:success] = "添加成功"
      redirect_to cards_path
    else
      @cards = Card.paginate(page: params[:page])
      render 'index'
    end
  end

  def destroy
    Card.find(params[:id]).destroy
    flash[:success] = "删除成功"
    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:name, :dept, :card_type)
  end
end
