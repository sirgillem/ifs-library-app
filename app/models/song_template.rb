class SongTemplate < ActiveRecord::Base
  has_many :song_parts, dependent: :destroy
  validates :name, presence: true

  def to_s
    name
  end
end
