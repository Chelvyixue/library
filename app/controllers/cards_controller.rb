# coding: utf-8
class CardsController < ApplicationController
  before_action :logged_in_admin, only: [:create, :destroy,
                                         :borrow_book, :return_book]

  def index
    @card = Card.new()    # for adding a card
    @cards = Card.paginate(page: params[:page])    # for showing cards
  end

  def card_id
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
    card = Card.find(params[:id])
    if card.borrows.any?
      flash.now[:danger] = "删除前先归还所有图书"
      @card = Card.new()
      @cards = Card.paginate(page: params[:page])
      render 'index'
    else
      card.destroy
      flash[:success] = "删除成功"
      redirect_to cards_path
    end
  end

  def borrow_book
    @card = Card.find_by(id: params[:id])
    book = Book.find_by(isbn: params[:isbn])
    if book.nil?
      flash.now[:danger] = "借书失败，书号不存在"
      @books = @card.borrows.paginate(page: params[:page])
      render 'show'
    elsif @card.nil?
      flash.now[:danger] = "借书证不存在"    # This case never happens
      @books = @card.borrows.paginate(page: params[:page])
      render 'show'
    elsif not book.borrow_book
      record = Record.where(book_id: book.id).order("returned_at DESC").first
      return_time = record.to_return_at.localtime.strftime('%Y年%m月%d日')
      flash.now[:danger] = "借书失败，库存不足，最近归还时间：#{return_time}"
      @books = @card.borrows.paginate(page: params[:page])
      render 'show'
    else
      current_admin.records.create(card_id: @card.id, book_id: book.id)
      flash[:success] = "借书成功"
      redirect_to @card
    end
  end

  def return_book
    @card = Card.find_by(id: params[:id])
    book = Book.find_by(isbn: params[:isbn])
    if book.nil?
      flash.now[:danger] = "还书失败，书号不存在"
      @books = @card.borrows.paginate(page: params[:page])
      render 'show'
    elsif @card.nil?
      flash.now[:danger] = "借书证不存在"    # This case never happens
      @books = @card.borrows.paginate(page: params[:page])
      render 'show'
    elsif not book.return_book(@card.id)
      flash.now[:danger] = "还书失败，未借这本书"
      @books = @card.borrows.paginate(page: params[:page])
      render 'show'
    else
      flash[:success] = "还书成功"
      redirect_to @card
    end
  end

  def show
    @card = Card.find_by(id: params[:id])
    if params[:id].empty?
      flash.now[:danger] = "借书证不能为空"
      render 'card_id'
    elsif @card.nil?
      flash.now[:danger] = "借书证不存在"
      render 'card_id'
    else
      @books = @card.borrows.paginate(page: params[:page])
    end
  end

  private

  def card_params
    params.require(:card).permit(:name, :dept, :card_type)
  end
end
