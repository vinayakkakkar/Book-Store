module ApplicationHelper
  def user_owns_book?(book)
    current_user == @book.user
  end
end
