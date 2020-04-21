class SongTemplate < ActiveRecord::Base
  has_many :song_parts, inverse_of: :song_template, dependent: :destroy
  accepts_nested_attributes_for :song_parts,
                                allow_destroy: true,
                                reject_if: :all_blank
  validates :name, presence: true

  def to_s
    name
  end
end
