class BooksController < ApplicationController

  def index
    @books = Book.all
    if @books.empty?
      flash[:notice] = "No books in database."
    end
  end

  def loans
    @loans = BookLoan.all(:conditions => {:date_to => nil})
    if @loans.empty?
      flash[:notice] = "No loans in database."
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      flash.now[:notice] = "Book was successfully created."
      redirect_to books_url
    else
      render new_book_url
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(params[:book])
      flash.now[:notice] = "Book was successfully updated."
      redirect_to books_url
    else
      render edit_book_url
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_url
    end
  end


end
