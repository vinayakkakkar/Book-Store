class User < ApplicationRecord
  has_many :books

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:omniauthable, :recoverable, :rememberable, :validatable
end
