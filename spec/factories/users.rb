FactoryGirl.define do
  factory :user do
    email 'test_user@example.com'
    password_digest 'TestPassword'
  end

  factory :user_admin, class: User do
    email 'admin@example.com'
    password_digest 'TestPassword'
  end
end

