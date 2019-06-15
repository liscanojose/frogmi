json.feature_public_id @feature.f_id
json.comments @feature.comments do |comment|
  json.extract! comment, :message
end