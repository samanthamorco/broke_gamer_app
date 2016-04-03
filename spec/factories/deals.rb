FactoryGirl.define do
  factory :deal do
    url "www.google.com"
    price 14.99
    product_id 1234
    date Time.now
  end  
end