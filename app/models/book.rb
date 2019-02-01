class Book < ApplicationRecord
  validates :author, presence: true
  validates :description, presence: true
  validates :page_count, presence: true
  validates :release_year, presence: true
  validates :title, presence: true, uniqueness: {case_sensitive: false}
end
