class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :image

  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_date
  belongs_to :user

  with_options presence: true do
    validates :image
    validates :title
    validates :text
    validates :price
  end

  with_options numericality: { other_than: 0, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :delivery_date_id
  end

  validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters' },
                         inclusion: { in: 300..9_999_999, message: 'is out of setting range' }, format: { with: /\A[0-9]+\z/ }
end
