class Song < ActiveRecord::Base
  belongs_to :publisher
  belongs_to :pack
  validate :publisher_valid?
  validates :title, presence: true
  validates :duration, numericality: { greater_than: 0 }, allow_nil: true
  validates :tempo, numericality: { greater_than: 0 }, allow_nil: true

  # A publisher can either be defined through the publisher reference, or
  # through a pack, but not both.
  def publisher_valid?
    if publisher && pack
      errors.add :base, 'A song in a pack cannot have a publisher directly'
    end
  end

  def to_s
    if label
      "#{label} - #{name}"
    else
      name
    end
  end
end
