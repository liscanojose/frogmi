json.data @features do |feature|
  json.extract! feature, :id
  json.type "feature"
  json.attributes do
    json.external_id feature.f_id
    json.magnitude feature.mag
    json.time feature.time
    json.mag_type feature.mag_type
    json.external_url feature.url
    json.coordinates do
        json.longitude feature.longitude
        json.latitude feature.latitude
      end
  end
end
json.pagination do 
	json.extract! @pagination, :current_page, :total, :per_page
end