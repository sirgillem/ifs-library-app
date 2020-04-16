class SongPart < ActiveRecord::Base
  belongs_to :song
  belongs_to :template
end
