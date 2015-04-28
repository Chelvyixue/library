# coding: utf-8
class CardsController < ApplicationController
  before_action :logged_in_admin, only: [:create, :destroy]

  def index
    @card = Card.new()    # for adding a card
    @cards = Card.paginate(page: params[:page])    # for showing cards
  end

  def show
    @card = Card.find_by(id: params[:card_id] || params[:id])
    if @card
      @books = @card.borrows.paginate(page: params[:page])
    else
      flash[:danger] = "借书证不存在"
      redirect_to borrow_card_id_path
    end
  end

  def borrow_card_id
  end

  def borrow_book
    @card = Card.find_by(id: params[:id] || params[:card_id])
    book = Book.find_by(isbn: params[:isbn])
    if book
      if @card
        if book.borrow_book
          current_admin.records.create(card_id: @card.id, book_id: book.id)
          flash[:success] = "借书成功"
          redirect_to @card
        else
          flash.now[:danger] = "借书失败，库存不足"
          @books = @card.borrows.paginate(page: params[:page])
          render 'show'
        end
      else
        flash.now[:danger] = "借书证不存在"    # This case never happens
        @books = @card.borrows.paginate(page: params[:page])
        render 'show'
      end
    else
      flash.now[:danger] = "借书失败，书号不存在"
      @books = @card.borrows.paginate(page: params[:page])
      render 'show'
    end
  end

  def return_book
    @card = Card.find_by(id: params[:id] || params[:card_id])
    book = Book.find_by(isbn: params[:isbn])
    if book
      if @card
        if book.return_book(@card.id)
          flash[:success] = "还书成功"
          redirect_to @card
        else
          flash.now[:danger] = "还书失败，未借这本书"
          @books = @card.borrows.paginate(page: params[:page])
          render 'show'
        end
      else
        flash.now[:danger] = "借书证不存在"    # This case never happens
        @books = @card.borrows.paginate(page: params[:page])
        render 'show'
      end
    else
      flash.now[:danger] = "还书失败，书号不存在"
      @books = @card.borrows.paginate(page: params[:page])
      render 'show'
    end
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

  private

  def card_params
    params.require(:card).permit(:name, :dept, :card_type)
  end
end
