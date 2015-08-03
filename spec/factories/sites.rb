FactoryGirl.define do
  factory :site do
    sequence :url do |n|
      "http://www.test-url-#{n}.com"
    end

    sequence :url_slug do |n|
      "www-test-url-#{n}-com"
    end

    title 'Test Title'
    tags 'test_tag, sample_tag'
  end
end
