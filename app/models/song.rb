class Song < ActiveRecord::Base
  include Contributable
  belongs_to :publisher
  belongs_to :pack
  has_many :song_parts, inverse_of: :song, dependent: :destroy
  accepts_nested_attributes_for :publisher, reject_if: :all_blank
  accepts_nested_attributes_for :song_parts,
                                allow_destroy: true,
                                reject_if: :all_blank
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
    if label.empty?
      title
    else
      "#{label} - #{title}"
    end
  end
end
