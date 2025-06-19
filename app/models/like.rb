class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true

  # Makes sure that a like is associated with a user and the model it is referencing
  validates :user, :likable, presence: true
  # Makes sure that a user can only have one like per resource
  validates :user_id, uniqueness: { scope: [ :likable_id, :likable_type ] }
end
