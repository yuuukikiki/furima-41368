FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    city { '盛岡市' }
    street { '1-22-34' }
    building_name { 'ビル名' }
    phone_number { '09012345678' }
    prefecture_id { 2 }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
