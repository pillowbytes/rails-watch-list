class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, presence: true, length: { minimum: 6, message: 'must be at least 6 characters long' }
  validates :movie_id, uniqueness: { scope: :list_id, message: 'This movie is already in this list' }
end
