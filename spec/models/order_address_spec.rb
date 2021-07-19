require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep(1)
    end

    context '内容に問題ない場合' do
      it '全ての情報があれば登録できること' do
        expect(@order_address).to be_valid
      end

      it '建物名は空でも保存できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空だと登録できないこと' do
        @order_address.postcode = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode can't be blank")
      end

      it '郵便番号が半角のハイフンを含んだ正しい形でないと保存できないこと' do
        @order_address.postcode = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode はハイフンを入力してください")
      end

      it '都道府県を選択していないと保存できないこと' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture は−−以外を選択してください")
      end

      it '市区町村が空だと保存できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと保存できないこと' do
        @order_address.block = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Block can't be blank")
      end

      it '電話番号が空だと保存できないこと' do
        @order_address.phone = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone can't be blank")
      end

      it '電話番号は12桁の数値では保存できないこと' do
        @order_address.phone = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone は数値を11桁で入力してください")
      end

      it '電話番号は英数混合では保存できないこと' do
        @order_address.phone = '0901234567a'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone は数値を11桁で入力してください")
      end

      it 'user_idが空だと購入できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと購入できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

    end
  end
end
