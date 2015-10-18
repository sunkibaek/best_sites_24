require 'open-uri'

class RemoteSite
  FAKE_USER_AGENT = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 ' \
    '(KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'

  def initialize(url)
    @url = url
  end

  def document
    # Some sites block access without a fake user agent
    Nokogiri::HTML open(url, 'User-Agent' => FAKE_USER_AGENT)
  end

  private

  attr_reader :url
end
