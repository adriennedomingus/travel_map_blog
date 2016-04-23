class BlogCreator
  attr_reader :blog, :current_user

  def initialize(blog, current_user)
    @blog = blog
    @current_user = current_user
  end

  def update
    blog.set_slug
    blog.set_color
    blog.set_weather
  end

  def setup
    update
    Tweet.new(@blog, current_user, "http://wander-map.herokuapp.com/blogs/#{@blog.slug}")
    current_user.blogs << @blog
  end
end
