class Item < ApplicationRecord
extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  # has_one :order
  
  has_one_attached :image
  
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_date

  with_options presence: true do
    validates :title, :text, :image
    
    with_options numericality: { other_than: 1 } do
      validates :category_id, :status_id, :delivery_fee_id, :prefecture_id, :delivery_date_id
    end

    with_options format: { with: /\A[0-9]+\z/ } do
      validates :price, numericality: { greater_than: 300, less_than: 9999999 } 
    end
  end
end