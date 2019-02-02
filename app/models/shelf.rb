class Shelf < ApplicationRecord
  validates :title, presence: true

  belongs_to :user
  has_many :shelved_books
  has_many :books, through: :shelved_books
end
