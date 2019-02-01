json.extract! house, :id, :name, :location, :price, :bedrooms, :bathrooms, :floor_area, :furnishing, :floor_levels, :lease_left, :created_at, :updated_at
json.url house_url(house, format: :json)
