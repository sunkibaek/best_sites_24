require 'open-uri'

class Site < ActiveRecord::Base
  has_attached_file :screenshot,
    styles: { full_length: '848x>', thumb: '' },
    convert_options: { thumb: '-resize "263x" -crop "263x226+0+0" +repage' },
    default_url: '/images/:style/missing.png'

  validates :url, presence: true
  validates_attachment_content_type :screenshot, content_type: /\Aimage\/.*\Z/

  def tags=(input_tags)
    super input_tags.downcase.split(',').map { |e| e.strip.gsub(/\ +/, '_') }
  end

  def tags_in_text
    tags.join(', ')
  end

  def html_doc
    Nokogiri::HTML(super)
  end

  def fetch_html_doc
    self.html_doc = remote_site.to_s
    self.title = html_doc.title
  end

  private

  def remote_site
    Nokogiri::HTML open(url)
  end
end

