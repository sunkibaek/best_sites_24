class Site < ActiveRecord::Base
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

  private

  def normalized_tags(tag_in_text)
    tag_in_text.downcase.split(',').map do |tag|
      tag.strip.gsub(/\ +/, '_')
    end
  end
end
