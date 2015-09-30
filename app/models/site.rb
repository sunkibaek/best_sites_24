require 'open-uri'

class Site < ActiveRecord::Base
  USER_AGENT = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 ' \
    '(KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'

  has_many :views

  has_attached_file :screenshot,
    styles: { full_length: '848x>', thumb: '' },
    convert_options: { thumb: '-resize "263x" -crop "263x226+0+0" +repage' },
    default_url: '/images/:style/missing.png'

  validates :url, presence: true, uniqueness: true
  validates_attachment_content_type :screenshot, content_type: /\Aimage\/.*\Z/

  def self.with_tag(tag)
    where("? = ANY (tags)", tag)
  end

  def self.popular
    order(views_count: :desc)
  end

  def tags=(input_tag_in_text)
    super normalized_tags(input_tag_in_text)
  end

  def html_doc
    Nokogiri::HTML super
  end

  def fetch_html_doc
    self.html_doc = remote_site.to_s
    self.title = html_doc.title
    self.save!
  end

  def generate_url_slug
    self.url_slug = UrlSlug.new(url).slug
    self.save!
  end

  private

  def remote_site
    # Some sites block access without a fake user agent
    Nokogiri::HTML open(url, 'User-Agent' => USER_AGENT)
  end

  def normalized_tags(tag_in_text)
    tag_in_text.downcase.split(',').map do |tag|
      tag.strip.gsub(/\ +/, '_')
    end
  end
end
