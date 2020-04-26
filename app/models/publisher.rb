# Record information on publishers
class Publisher < ActiveRecord::Base
  has_many :packs, dependent: :destroy
  has_many :songs, dependent: :nullify
  validates :name, presence: true

  # Define a full URL for the website so it can be linked to correctly
  def full_url
    if website.match(/[A-Za-z]:\/\//)
      website
    else
      "http://#{website}"
    end
  end

  # Get the count of all songs by this publisher.
  def songs_count
    value = 0
    packs.each do |pack|
      value += pack.songs.count
    end
    value += songs.count
  end

  def to_s
    name
  end
end
