class SongPart < ActiveRecord::Base
  belongs_to :song
  belongs_to :song_template
  validate :owner?
  validates :name, presence: true

  # A part must belong to either a song or a song template
  def owner?
    if song && template
      errors.add :base, 'Part cannot belong to both a song and a song template'
    end

    unless song || template
      errors.add :base, 'Part must belong to either a song or a template'
    end
  end

  def to_s
    "#{song} - #{name}"
  end
end
