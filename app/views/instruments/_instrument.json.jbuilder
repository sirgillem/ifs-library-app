json.extract! instrument, :id, :name, :instrument_section_id, :created_at, :updated_at
json.url instrument_url(instrument, format: :json)
