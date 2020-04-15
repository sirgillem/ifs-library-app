json.extract! song, :id, :title, :label, :publisher_id, :serial, :details, :notes_perf, :notes_lib, :pack_id, :recording, :style, :duration, :tempo, :purchased_at, :created_at, :updated_at
json.url song_url(song, format: :json)
