require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  describe '配送先住所とカード情報の検証' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end

      it '建物名が空でも保存できること' do
        @order_address.building_name = nil
        expect(@order_address).to be_valid
      end

      context '内容に問題がある場合' do
        it '郵便番号が空だと保存できないこと' do
          @order_address.postal_code = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
        end

        it '郵便番号が「123-4567」の形式でないと保存できないこと' do
          @order_address.postal_code = '1234567'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
        end

        it '都道府県が選択されていないと保存できないこと' do
          @order_address.prefecture_id = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Prefecture must be select')
        end

        it '市区町村が空だと保存できないこと' do
          @order_address.city = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("City can't be blank")
        end

        it '番地が空だと保存できないこと' do
          @order_address.street = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Street can't be blank")
        end

        it '電話番号が空だと保存できないこと' do
          @order_address.phone_number = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
        end

        it '電話番号が10桁未満だと保存できないこと' do
          @order_address.phone_number = '090123456'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Phone number must be 10 or 11 digits')
        end

        it '電話番号が11桁を超えると保存できないこと' do
          @order_address.phone_number = '090123456789'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Phone number must be 10 or 11 digits')
        end

        it '電話番号にハイフンが含まれていると保存できないこと' do
          @order_address.phone_number = '090-1234-5678'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Phone number must be 10 or 11 digits')
        end

        it 'userが紐付いていないと保存できないこと' do
          @order_address.user_id = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("User can't be blank")
        end

        it 'tokenが空では登録できないこと' do
          @order_address.token = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Token can't be blank")
        end
      end
    end
  end
end
