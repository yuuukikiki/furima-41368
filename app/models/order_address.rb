class OrderAddress
  include ActiveModel::Model
  attr_accessor :product_id, :user_id, :postal_code, :city, :street, :building_name, :phone_number, :order_id, :prefecture_id,
                :token

  with_options presence: true do
    validates :product_id
    validates :user_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :street
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'must be 10 or 11 digits' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'must be select' }
    validates :token
  end

  def save
    order = Order.create(product_id:, user_id:)

    Address.create(postal_code:, city:, street:, building_name:,
                   phone_number:, order_id: order.id, prefecture_id:)
  end
end
