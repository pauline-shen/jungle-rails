require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "all four fields valid" do
      @product = Product.new
      @category = Category.new
      @category.name = 'Example'
      @product.name = 'Test1'
      @product.price_cents = 111
      @product.quantity = 1
      @product.category = @category
      expect(@product.valid?).to be true
    end

    it "name presence" do
      @product = Product.new
      @category = Category.new
      @category.name = 'Example'
      @product.name = nil
      @product.price_cents = 111
      @product.quantity = 1
      @product.category = @category
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "price_cents presence" do
      @product = Product.new
      @category = Category.new
      @category.name = 'Example'
      @product.name = "Test3"
      @product.price_cents = nil
      @product.quantity = 1
      @product.category = @category
      @product.valid?
      expect(@product.errors.full_messages).to include("Price cents is not a number")
    end
  
    it "quantity presence" do
      @product = Product.new
      @category = Category.new
      @category.name = 'Example'
      @product.name = 'Test1'
      @product.price_cents = 111
      @product.quantity = nil
      @product.category = @category
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
  
    it "category presence" do
      @product = Product.new
      @product.name = 'Test1'
      @product.price_cents = 111
      @product.quantity = 1
      @product.category = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end