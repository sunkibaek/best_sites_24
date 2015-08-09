require 'rails_helper'

RSpec.describe UrlSlug, type: :model do
  describe '.initialize' do
    it 'takes url as argument' do
      expect { UrlSlug.new() }.to raise_error ArgumentError
      expect { UrlSlug.new('https://www.test-url.com') }.to_not raise_error
    end
  end

  describe '#slug' do
    context 'starting with https://' do
      it 'removes it' do
        url = 'https://www.secure-url.com'
        slug = UrlSlug.new(url).slug

        expect(slug).to eq 'www-secure-url-com'
      end
    end

    context 'starting with http://' do
      it 'removes it' do
        url = 'http://www.unsecure-url.com'
        slug = UrlSlug.new(url).slug

        expect(slug).to eq 'www-unsecure-url-com'
      end
    end

    context 'ending with / (forward slash)' do
      it 'removes it' do
        url = 'https://www.example-url.com/'
        slug = UrlSlug.new(url).slug

        expect(slug).to eq 'www-example-url-com'
      end
    end

    context 'with spaces front and back' do
      it 'removes them' do
        url = '  https://www.example-url.com  '
        slug = UrlSlug.new(url).slug

        expect(slug).to eq 'www-example-url-com'
      end
    end
  end
end

