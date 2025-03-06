class Movie < ApplicationRecord
  has_many :bookmarks, dependent: :restrict_with_error

  validates :title, :overview, presence: true, uniqueness: { case_sensitive: false, message: 'Movies and Overviews must be unique' }
end

class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks

  validates :name, presence: true, uniqueness: { case_sensitive: false, message: 'All lists must have an unique name' }
end

class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, presence: true, length: { minimum: 6, message: 'must be at least 6 characters long' }
  validates :movie_id, uniqueness: { scope: :list_id, message: 'This movie is already in this list' }
end
