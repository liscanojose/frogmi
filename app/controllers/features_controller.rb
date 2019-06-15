class FeaturesController < ApplicationController
  before_action :set_feature, only: %i[create_message comments]
  before_action :set_pagination, only: %i[index]
  
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
    #luego de que se hayan creado los nuevos de haber nuevos
    if params[:mag_type].blank?
      mag_type = Feature.all.pluck(:mag_type)
    else
      mag_type = params[:mag_type]
    end
    if @page && @current_page
      @features = Feature.where(mag_type: mag_type).paginate(page: @current_page, per_page: @per_page)
      total_pages = (Feature.count / @per_page).ceil
    else
      @features = Feature.where(mag_type: mag_type)
      @current_page = 1
    end
    @pagination = {
    "current_page": @current_page,
    "total": total_pages,
    "per_page": @per_page
    }
    render 'features/index.json.jbuilder'
  end

  def create_message
    message = params[:comment][:message].to_s
    comment = @feature.comments.new(message: message)
    unless comment.save
      render json: {errors: comment.errors}, status: :unprocessable_entity
    else
      redirect_to "http://localhost:3001/features/#{@feature.id}/comments"
    end
  end

  def comments
    render 'features/comments.json.jbuilder'
  end
  private

    # Use callbacks to share common setup or constraints between actions.
    def set_feature
      @feature = Feature.find(params[:id])
    end
    def set_pagination
      @page = params[:page]
      if @page
        @current_page = @page[:number]
      end
      @per_page = 10
    end
end

#curl
# curl 'http://localhost:3000/features/11274/create_message' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: es-CL,es;q=0.8,en-US;q=0.5,en;q=0.3' --compressed -H 'Connection: keep-alive' -H 'Content-type: application/json' -H 'Upgrade-Insecure-Requests: 1' -H 'If-None-Match: W/"7c711c87aa38ddd00acccfe54f31d193"' -X POST -d '{"message":"value1"}' -H "Content-Type: application/json" -v -o /dev/null

