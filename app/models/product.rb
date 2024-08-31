class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  validates :name, :description, :category_id, :condition_id,
            :shipping_fee_id, :prefecture_id, :shipping_time_id, presence: true
  validates :image, presence: true
  validates :price,
            presence: true,
            format: { with: /\A[0-9]+\z/ },
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }

  validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_time_id,
            numericality: { other_than: 1, message: 'please select' }

  belongs_to :user

  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_time

  has_one :order
  has_one_attached :image

  def is_sold_out?
    Order.where(product_id: id).exists?
  end
end
