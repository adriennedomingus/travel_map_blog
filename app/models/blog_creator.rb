class BlogCreator
  attr_reader :blog, :current_user, :path

  def initialize(blog, current_user, path)
    @blog = blog
    @current_user = current_user
    @path = path
  end

  def update
    blog.set_slug
    blog.set_color
    blog.set_weather
  end

  def setup
    update
    # Tweet.new(@blog, current_user, path)
    current_user.blogs << @blog
  end


end
