class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :author
  validates :title, presence: true, length: { in: 4..50 }
  validates :text, presence: true, length: { maximum: 280 }
end