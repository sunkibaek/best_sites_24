require 'rails_helper'

RSpec.describe Site, type: :model do
  subject(:site) do
    build :site,
      url: 'https://google.com',
      tags: 'test_tag, sample_tag'
  end

  describe '#tags=' do
    it 'saves input texts as tags array' do
    end
  end

  describe '#html_doc' do
    it 'parses saved html (string) into nokogiri obj' do
    end
  end

  describe '#fetch_html_doc' do
    it 'fetches html doc from remote server' do
    end
  end

  describe '#url_slug' do
    it 'returns stored url_slug or cleans up url to make new one' do
    end
  end
end

