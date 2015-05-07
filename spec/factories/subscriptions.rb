FactoryGirl.define do
  factory :subscription do
    created_at    Time.now
    user          nil
    customer_id   'abc123'
  end
end
