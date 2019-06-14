class Feature < ApplicationRecord
	require 'httparty'
	has_many :comments, dependent: :delete_all
	API_URL_EARTHQUAKE = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=#{Time.now.strftime("%Y-%m-%d")}"
	validates :url, :mag_type, presence: true, allow_blank: true
	validates_numericality_of :mag, greater_than_or_equal_to: -1, less_than_or_equal_to: 10, on: :create
	validates_numericality_of :latitude, greater_than_or_equal_to: -90, less_than_or_equal_to: 90, on: :create
	validates_numericality_of :latitude, greater_than_or_equal_to: -180, less_than_or_equal_to: 180, on: :create
	def self.get_list_features
		earthquake_url = API_URL_EARTHQUAKE
		response = HTTParty.get(
			earthquake_url,
				{ 
				headers:
					{
						'Content-Type' => 'application/json; charset=utf-8',
						'Accept' => 'application/json'
					},
			},
		).body
			return JSON.parse(response, symbolize_names: true)
	end
end
