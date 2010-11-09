class BookLoansController < ApplicationController
  before_filter :authorize
  
  def index
    @book = Book.find(params[:book_id])
    if @book.loans.empty?
      flash[:notice] = "No book loans."
    end
  end

  def history
    @book = Book.find(params[:id])
    if @book.loans.empty?
      flash[:notice] = "No book history."
    end
  end

  def new
    @book = Book.find(params[:book_id])
    @loan = Loan.new
    @members = Member.members.sort! {|x, y| x.name <=> y.name}
  end

  def create
    @book = Book.find(params[:book_id])
    @book.loans << Loan.new(params[:loan])
    if @book.save
      flash.now[:notice] = "Book loan was successfully created."
      redirect_to book_loans_url(@book)
    else
      render new_book_loan_url(@book)
    end
  end

  def edit
    @book = Book.find(params[:book_id])
    @loan = Loan.find(params[:id])
    @members = Member.members.sort! {|x, y| x.name <=> y.name}
  end

  def update
    @book = Book.find(params[:book_id])
    @loan = Loan.find(params[:id])
    if @loan.update_attributes(params[:loan])
      flash.now[:notice] = "Book loan was successfully created."
      redirect_to book_loans_url(@book)
    else
      render new_book_loan(@book)
    end
  end

  def destroy
	@loan = Loan.find(params[:id])
	if @loan.destroy
	  flash[:notice] = "Loan was successfully deleted."
	  redirect_to book_loans_url(@book)
	end
  end
end
