class FeaturesController < ApplicationController
  before_action :set_feature, only: %i[create_message]
  def index
    features = Feature.get_list_features[:features]
    features.each do |feature|
      Feature.find_or_create_by(
        f_id: feature[:id],
        mag: feature[:properties][:mag],
        time: feature[:properties][:time],
        url: feature[:properties][:url],
        mag_type: feature[:properties][:magType],
        longitude: feature[:geometry][:coordinates][0],
        latitude: feature[:geometry][:coordinates][1]
      )
    end
    @features = Feature.all
    render json: {features: @features}, status: 200
  end

  def create_message
    message = params[:message].to_s
    unless @feature.comments.new(message: message).save
      p "errors: " + @feature.errors.to_hash(true).to_s
      render json: {errors: @feature.errors.to_hash(true)}, status: :unprocessable_entity
    else
      render json: {feature:  @feature}, status: 200
    end
  end
  private

    # Use callbacks to share common setup or constraints between actions.
    def set_feature
      @feature = Feature.find(params[:id])
    end
end

# populate.task

# namespace :db do
#   task populate: :environment do
#     $restaurants.each_with_index do |r, index|
#       PopulateRestaurantWorker.perform_in((index * 0.25).seconds, r) # stagger the scheduling or you can schedule via #perform_async to enqueue all at once
#     end
#   end
# end

#curl
# curl 'http://localhost:3000/features/11274/create_message' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: es-CL,es;q=0.8,en-US;q=0.5,en;q=0.3' --compressed -H 'Connection: keep-alive' -H 'Content-type: application/json' -H 'Upgrade-Insecure-Requests: 1' -H 'If-None-Match: W/"7c711c87aa38ddd00acccfe54f31d193"' -X POST -d '{"message":"value1"}' -H "Content-Type: application/json" -v -o /dev/null

