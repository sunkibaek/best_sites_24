require 'rails_helper'

RSpec.describe Site, type: :model do
  let(:url) { 'http://example.com' }

  describe 'FAKE_USER_AGENT' do
    it 'is a string of user agent description' do
      expect(RemoteSite::FAKE_USER_AGENT).to be_a String
    end
  end

  describe '#initialize' do
    context 'with a valid url' do
      it 'takes url as an argument' do
        expect(RemoteSite.new(url)).to be_a RemoteSite
      end
    end
  end

  describe '#document' do
    it 'returns remote html' do
      stub_request(:get, url)
        .to_return(:status => 200, :body => '', :headers => {})

      document = RemoteSite.new(url).document

      expect(document).to be_a Nokogiri::HTML::Document
    end
  end
end
