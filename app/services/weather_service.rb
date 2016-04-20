class WeatherService
  def initialize
    @_connection = Faraday.new("http://api.worldweatheronline.com/premium/v1/past-weather.ashx")
    connection.params['key'] = "046f25cbe2ad431a902190109162004"
  end

  def weather_description(blog)
    date = blog.date = blog.date.strftime("%Y-%m-%d")
    response = connection.get("?format=json&q=#{blog.latitude.to_f},#{blog.longitude.to_f}&date=#{date}")
    JSON.parse(response.body)
  end

  private

    def connection
      @_connection
    end
end
