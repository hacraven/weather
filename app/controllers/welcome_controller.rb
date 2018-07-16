class WelcomeController < ApplicationController
  def test
  	response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/AZ/Flagstaff.json")
  
  	@location = response['location']['city']
  	@temp_f = response['current_observation']['temp_f']
  	@temp_c = response['current_observation']['temp_c']
  
  	@weather_icon = response['current_observation']['icon_url']
  	@weather_words = response['current_observation']['weather']
  	@forecast_link = response['current_observation']['forecast_url']
  	@real_feel = response['current_observation']['feelslike_strings']

  end

  def index
  	@states = %w(AL AK AZ AR CA CO CT DE FL GA SC NC VA WV MD PA NJ NY RI MA ME NH VT OH MI IN IL KY TN MS LA DC MO IA WI MN ND SD NE KS OK TX NM WY MT ID UT NV OR WA HI).sort!
  end
end

# class WelcomeController < ApplicationController
#   def test
#   	response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/AZ/Flagstaff.json")

#   	  @location = response['location']['city']
#   	@temp_f = response['current_observation']['temp_f']
#   	@temp_c = response['current_observation']['temp_c']
#   	@weather_icon = response['current_observation']['icon_url']
#   	@weather_words = response['current_observation']['weather']
#   	@forecast_link = response['current_observation']['forecast_url']
#   	@real_feel = response['current_observation']['feelslike_string']
#   end

#   def index
#   end
# end