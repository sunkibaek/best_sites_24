class UrlSlug
  def initialize(url)
    @url = url
  end

  def slug
    url.gsub(/(https:\/\/|http:\/\/)/, '')
     .gsub(/\ /, '')
     .gsub(/\./, '-')
     .gsub(/\/$/, '')
  end

  private

  attr_reader :url
end

