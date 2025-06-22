class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, uniqueness: { scope: :followed_id }
  validate :cannot_follow_self

  private
    def cannot_follow_self
      errors.add(:followed, "can't follow yourself") if follower == followed
    end
end
