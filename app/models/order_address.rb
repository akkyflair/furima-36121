class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :block, :building, :phone, :token

  with_options presence: true do
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフンを入力してください' }
    validates :prefecture_id, numericality: { other_than: 0, message: 'は−−以外を選択してください' }
    validates :city
    validates :block
    validates :phone, format: { with: /\A[0-9]{10,11}\z/, message: 'は数値を11桁で入力してください' }
    validates :user_id
    validates :item_id
    validates :token
    
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone: phone, order_id: order.id)
  end
end
