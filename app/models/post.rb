class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
end
