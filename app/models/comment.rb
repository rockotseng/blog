class Comment < ApplicationRecord
  belongs_to :article
  validates :commenter, presence: true, length: { in: 4..70 }
  validates :body, presence: true, length: { in: 4..140 }
end
