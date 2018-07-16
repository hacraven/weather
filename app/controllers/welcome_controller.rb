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
  	# creates an array of states that our user can chose from our index page
  	@states = %w(AL AK AZ AR CA CO CT DE FL GA SC NC VA WV MD PA NJ NY RI MA ME NH VT OH MI IN IL KY TN MS LA DC MO IA WI MN ND SD NE KS OK TX NM WY MT ID UT NV OR WA HI).sort!
 		
 		 #removes spaces from the 2-word city names and replaces the space with an underscore
 		if params[ :city] != nil
 			 params[:city].gsub!(" ", "_")

  end


  #checks that the state and city params are not empty before calling the API
  	if params[:state] != "" && params[:city] != "" && params[:state] != nil && params[:city] != nil
  		response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json")

  		# if no error is returned from the call, we fill our instants variables with the result of the call
  	if response['response']['error'] == nil || response['error']

  	if response["location"] != nil
  		@location = response['location']['city']
	  	@temp_f = response['current_observation']['temp_f']
	  	@temp_c = response['current_observation']['temp_c']
	  
	  	@weather_icon = response['current_observation']['icon_url']
	  	@weather_words = response['current_observation']['weather']
	  	@forecast_link = response['current_observation']['forecast_url']
	  	@real_feel_f = response['current_observation']['feelslike_f']
	  	@real_feel_c = response['current_observation']['feelslike_c']

	  	# if there is an error, we report it to our user via the @error variable 
	  	else
	  		@error = "For some reason your City/State combo does not exsist.  Yes, I know that 
	  		you know what you are talking about---but I apparently don't--so try again!"	
	  	end
  	else
  		@error = response['response']['error']['description']
  	end

	  end	
  end		
end