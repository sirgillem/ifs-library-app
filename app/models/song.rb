class Song < ActiveRecord::Base
  belongs_to :publisher
  belongs_to :pack
end
