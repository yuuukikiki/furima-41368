require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '商品出品機能' do
    context '出品できるとき' do
      it '全ての必須項目が正しく入力されていれば出品できる' do
        expect(@product).to be_valid
      end
    end

    context '出品できないとき' do
      it '商品画像が空だと出品できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空だと出品できない' do
        @product.name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が空だと出品できない' do
        @product.description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが選択されていないと出品できない' do
        @product.category_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end

      it 'カテゴリーが選択肢（1）のままだと出品できない' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Category please select')
      end

      it '商品の状態が選択されていないと出品できない' do
        @product.condition_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Condition can't be blank")
      end

      it '商品の状態が選択肢（1）のままだと出品できない' do
        @product.condition_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Condition please select')
      end

      it '配送料の負担が選択されていないと出品できない' do
        @product.shipping_fee_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Shipping fee can't be blank")
      end

      it '配送料の負担が選択肢（1）のままだと出品できない' do
        @product.shipping_fee_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Shipping fee please select')
      end

      it '発送元の地域が選択されていないと出品できない' do
        @product.prefecture_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送元の地域が選択肢（1）のままだと出品できない' do
        @product.prefecture_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Prefecture please select')
      end

      it '発送までの日数が選択されていないと出品できない' do
        @product.shipping_time_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Shipping time can't be blank")
      end

      it '発送までの日数が選択肢（1）のままだと出品できない' do
        @product.shipping_time_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Shipping time please select')
      end

      it '価格が空だと出品できない' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が¥300未満だと出品できない' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格が¥9,999,999を超えると出品できない' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '価格が半角数値でないと出品できない' do
        @product.price = '３００'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not a number')
      end

      it 'ユーザーが紐づいていなければ出品できない' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('User must exist')
      end

      it 'productが紐付いていないと保存できないこと' do
        @order_address.product = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Product can't be blank")
      end
    end
  end
end
