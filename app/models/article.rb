class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :author
  validates :title, presence: true,
                    length: { minimum: 5 }
end
