require 'rails_helper'

RSpec.describe Site, type: :model do
  subject(:site) do
    build :site,
      url: 'http://example.com',
      tags: 'test_tag, sample_tag'
  end
  let(:test_html) do
    '<!DOCTYPE html><html><head><title>Test HTML</title></head>' \
      '<body><h1>Hello, World!</h1></body></html>'
  end

  it { should validate_presence_of(:url) }
  it { should validate_uniqueness_of(:url) }

  describe 'USER_AGENT' do
    it 'is a string of user agent description' do
      expect(Site::USER_AGENT).to be_a String
    end
  end

  describe '.with_tag' do
    it 'returns sites only with a certain tag' do
      site_with_tag_a = create :site, tags: 'tag_a'
      site_with_tag_b = create :site, tags: 'tag_b'

      expect(Site.with_tag('tag_a')).to eq [site_with_tag_a]
    end
  end

  describe '#tags=' do
    it 'saves input texts as tags array' do
      expect(site.tags).to eq ['test_tag', 'sample_tag']
    end
  end

  describe '#html_doc' do
    it 'parses saved html (string) into nokogiri obj' do
      site.html_doc = test_html

      expect(site.html_doc).to be_a Nokogiri::HTML::Document
      expect(site.html_doc.to_s).to start_with "<!DOCTYPE html>\n<html>"
    end
  end

  describe '#fetch_html_doc' do
    it 'fetches html doc from remote server' do
    end
  end

  describe '#generate_url_slug' do
    it 'generates url slug and saves it' do
      site.generate_url_slug

      expect(site.url_slug).to eq 'example-com'
    end
  end
end
