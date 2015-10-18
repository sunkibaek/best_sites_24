require 'rails_helper'

RSpec.describe Site, type: :model do
  subject(:site) do
    build :site,
      url: 'http://example.com',
      tags: 'test_tag, sample_tag'
  end
  let(:test_html) do
    '<!DOCTYPE html><html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><title>Test HTML</title></head>' \
      '<body><h1>Hello, World!</h1></body></html>'
  end

  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_uniqueness_of(:url) }
  it { is_expected.to have_many(:views) }

  describe '.with_tag' do
    it 'returns sites only with a certain tag' do
      site_with_tag_a = create :site, tags: 'tag_a'
      site_with_tag_b = create :site, tags: 'tag_b'

      expect(Site.with_tag('tag_a')).to eq [site_with_tag_a]
    end
  end

  describe '.popular' do
    it 'returns most viewed sites in descending order' do
      more_viewed_site = create :site, views_count: 10
      less_viewed_site = create :site, views_count: 5

      expect(Site.popular).to eq [more_viewed_site, less_viewed_site]
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
end
