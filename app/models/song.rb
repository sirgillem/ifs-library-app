class Song < ActiveRecord::Base
  belongs_to :publisher
  belongs_to :pack
  validate :publisher_valid?
  validates :title, presence: true
  validates :duration, numericality: { greater_than: 0 }, allow_nil: true
  validates :tempo, numericality: { greater_than: 0 }, allow_nil: true

  # A publisher can either be defined through the publisher reference, or
  # through a pack.
  def publisher_valid?
    if publisher && pack
      errors.add :base, 'A song in a pack cannot have a publisher directly'
    end
    unless publisher || pack
      errors.add :base, 'Must belong to either a pack or a publisher'
    end
  end
end
