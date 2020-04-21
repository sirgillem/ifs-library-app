class SongPart < ActiveRecord::Base
  scope :all_parts, -> do
    includes(:song, :song_template).order(
      'song_id IS NULL',
      Song.table_name + '.title',
      SongTemplate.table_name + '.name',
      'sequence', 'name'
    )
  end
  belongs_to :song
  belongs_to :song_template
  validate :owner?
  validates :name, presence: true
  validates :sequence, numericality: { greater_than_or_equal_to: 0 }

  # A part must belong to either a song or a song template
  def owner?
    if song && song_template
      errors.add :base, 'Part cannot belong to both a song and a song template'
    end

    unless song || song_template
      errors.add :base, 'Part must belong to either a song or a template'
    end
  end

  def to_s
    "#{song} - #{name}"
  end
end
