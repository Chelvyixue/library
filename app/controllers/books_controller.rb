# coding: utf-8
class BooksController < ApplicationController
  before_action :logged_in_admin, only: [:create, :check_exist,
                                         :edit_number, :update_number]

  def index
    @books = Book.paginate(page: params[:page])
  end

  def new
  end

  def create
    @book = Book.new(book_params)
    @book.total_storage = @book.storage
    if @book.save
      flash[:success] = "入库成功"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def check_exist
    @book = Book.find_by(isbn: params[:qisbn])
    if @book.nil? # not exist
      @book = Book.new
      @book.isbn = params[:qisbn]
      render 'new'
    else
      render 'edit_number'
    end
  end

  def edit_number
  end

  def update_number
    @book = Book.find_by(isbn: params[:isbn])
    if @book.increase_by(params[:increase_number])
      flash[:success] = "入库成功"
      redirect_to root_url
    else
      flash[:danger] = "入库数量必须为正整数"
      render 'edit_number'
    end
  end

  def import_mul
  end

  def process_books
    books = params[:book_list].split("\n")
    import_count = _process_books(books)
    flash[:success] = "共添加#{import_count}本书"
    redirect_to root_url
  end

  private

  def book_params
    params.require(:book).permit(:isbn, :category, :title, :publisher,
                                 :author, :year, :price, :storage)
  end

  # Given a list of book info, convert it to books
  def _process_books(books)
    import_count = 0
    books.each do |book|
      attrs = book.split("$")
      if attrs.size != 8    # 8 parameters
        next
      end
      new_book = Book.find_by(isbn: attrs[0])
      if new_book    # found
        if new_book.increase_by(attrs[7])
          import_count += attrs[7].to_i
        end
      else    # not found, create new book
        new_book = Book.new(isbn: attrs[0], title: attrs[1], category: attrs[2],
                            publisher: attrs[3], author: attrs[4], year: attrs[5],
                            price: attrs[6], total_storage: attrs[7], storage: attrs[7])
        if new_book.save
          import_count += attrs[7].to_i
        end
      end
    end
    import_count
  end
end
