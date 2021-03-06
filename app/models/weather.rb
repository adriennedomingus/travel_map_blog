class Weather
  def self.all_data(blog)
    WeatherService.new.weather_description(blog)
  end

  def self.description(blog)
    if all_data(blog)["data"]["weather"]
      all_data(blog)["data"]["weather"].first["hourly"][4]["weatherDesc"].first["value"]
    end
  end
end
