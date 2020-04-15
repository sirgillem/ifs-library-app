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

  def to_s
    name
  end
end
