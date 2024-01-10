# app/models/book.rb
class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :cover_image

  validate :cover_image_format, if: :cover_image_attached?


  private

  def cover_image_format
    if !cover_image.image?
      errors.add(:cover_image, 'must be an image')
    end
  end

  def cover_image_attached?
    cover_image.attached?
  end 
  
end
