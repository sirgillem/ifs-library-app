json.extract! song_part, :id, :song_id, :name, :scanned, :notes, :template_id, :created_at, :updated_at
json.url song_part_url(song_part, format: :json)
