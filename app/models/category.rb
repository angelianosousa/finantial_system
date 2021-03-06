class Category < ApplicationRecord
  has_many :recurrences
  has_many :transactions

  validates :title, uniqueness: true
end
