class Song < ActiveRecord::Base
  include Contributable

  # Scopes for filtering
  scope :filter_by_label, ->(label) { where 'LENGTH(label) > 0' }
  scope :filter_by_title, ->(title) { where('title LIKE ?', "%#{title}%") }
  scope :filter_by_serial, ->(serial) { where('serial LIKE ?', "%#{serial}%") }
  scope :filter_by_style, ->(style) { where('style LIKE ?', "%#{style}%") }
  scope :filter_by_min_dur, ->(min) { where('duration >= ?', min) }
  scope :filter_by_max_dur, ->(max) { where('duration <= ?', max) }
  scope :filter_by_min_tempo, ->(min) { where('tempo >= ?', min) }
  scope :filter_by_max_tempo, ->(max) { where('tempo <= ?', max) }
  scope :filter_by_instrument, ->(instrument) do
    joins(song_parts: { part_instruments: :instrument })
      .where("#{Instrument.table_name}.name LIKE ?", "%#{instrument}%")
      .uniq
  end

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
    if label && label.empty?
      title
    else
      "#{label} - #{title}"
    end
  end

  # Convert duration to a display string
  def duration_string
    return '' unless duration
    hours = duration / 3600
    working_dur = duration % 3600
    minutes = working_dur / 60
    seconds = working_dur % 60
    if hours > 0
      minutes = '%02d' % minutes
    else
      hours = nil
    end
    seconds = '%02d' % seconds
    [hours, minutes, seconds].reject(&:blank?).join(':')
  end
end
