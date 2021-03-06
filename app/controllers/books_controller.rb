# coding: utf-8
class BooksController < ApplicationController
  before_action :logged_in_admin, only: [:create, :check_exist,
                                         :edit_number, :update_number,
                                         :import_one, :import_mul]

  def index
    @books = Book.order("title").paginate(page: params[:page])
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
    if params[:isbn].empty?
      flash.now[:danger] = "书号不能为空"
      render 'import_one'
    else
      @book = Book.find_by(isbn: params[:isbn])
      if @book.nil? # not exist
        @book = Book.new
        @book.isbn = params[:isbn]
        render 'new'
      else
        @books = Book.where(isbn: params[:isbn]).paginate(page: nil)
        render 'edit_number'
      end
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
      flash.now[:danger] = "入库数量必须为正整数"
      @books = Book.where(isbn: params[:isbn]).paginate(page: nil)
      render 'edit_number'
    end
  end

  def import_one
  end

  def import_mul
  end

  def process_batch_import
    books = params[:book_list].split("\n")
    import_count = _process_batch_import(books)
    flash[:success] = "共添加#{import_count}本书"
    redirect_to root_url
  end

  def search
    @books = Book.where(title: "").paginate(page: params[:page])    # returns an empty page
  end

  def query
    if params[:query].empty?
      flash.now[:danger] = "查询内容不能为空"
      @books = Book.where(title: "").paginate(page: params[:page])
      render 'search'
    else
      like_query = "N'%#{params[:query]}%'"
      where_clause = case params[:column].to_i
                     when 1 then "title LIKE #{like_query}"
                     when 2 then "title = '#{params[:query]}'"
                     when 3 then "category LIKE #{like_query}"
                     when 4 then "author LIKE #{like_query}"
                     when 5 then "publisher LIKE #{like_query}"
                     when 6 then "year = #{params[:query]}"
                     when 7 then "price = #{params[:query]}"
                     end
      order_clause = case params[:order].to_i
                     when 1 then "title"
                     when 2 then "isbn"
                     when 3 then "category"
                     when 4 then "author"
                     when 5 then "publisher"
                     when 6 then "year"
                     when 7 then "price"
                     end
      @books = Book.where(where_clause).order(order_clause).paginate(page: params[:page])
      flash.now[:danger] = "无结果" if @books.empty?
      render 'search'
    end
  end

  private

  def book_params
    params.require(:book).permit(:isbn, :category, :title, :publisher,
                                 :author, :year, :price, :storage)
  end

  # Given a list of book info, convert it to books
  def _process_batch_import(books)
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
