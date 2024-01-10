class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  
  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = current_user.books.new
  end

  def create
    @book = current_user.books.new(book_params)

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      flash.now[:alert] = 'Error creating Book.'
      render :new
    end
  end

  def edit
    unless user_owns_book?(@book)
      redirect_to root_path, alert: 'You are not authorized to edit this book.'
    end
  end

  def update
    unless user_owns_book?(@book)
      redirect_to root_path, alert: 'You are not authorized to update this book.'
      return
    end

    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      flash.now[:alert] = 'Error updating the book.'
      render :edit
    end
  end

  def destroy
    unless user_owns_book?(@book)
      redirect_to root_path, alert: 'You are not authorized to delete this book.'
      return
    end

    if @book.destroy
      redirect_to books_path, notice: 'Book was successfully deleted.'
    else
      redirect_to books_path, alert: 'Not able to delete Book.'
    end
  end

  private

  def user_owns_book?(book)
    current_user && current_user == book.user
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :description, :genre, :cover_image)
  end

end
