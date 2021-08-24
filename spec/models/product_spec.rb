require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'validates a product with all 4 fields will save successfully' do
      @category = Category.create(name: "Food")
      @product = @category.products.create({name: "Burger", quantity: 5, price: 55.55})
      expect(@product.errors.full_messages).to eq []
    end
    it 'validates a name is given' do
      @category = Category.create(name: "Toys")
      @product = @category.products.create({name: "Super Soaker", quantity: 7, price: 24.99})
      expect(@product.name).to be_kind_of(String)
      @product2 = @category.products.create({name: nil, quantity: 7, price: 24.99})
      expect(@product2.errors.full_messages).to include "Name can't be blank"
    end
    it 'validates a price is given' do
      @category = Category.create(name: "Toys")
      @product = @category.products.create({name: "Super Soaker", quantity: 7, price: 24.99})
      expect(@product.price_cents).to be_kind_of(Numeric)
      @product2 = @category.products.create({name: "Super Soaker", quantity: 7, price: nil})
      expect(@product2.errors.full_messages).to include "Price can't be blank"
    end
    it 'validates a quantity is given' do
      @category = Category.create(name: "Toys")
      @product = @category.products.create({name: "Super Soaker", quantity: 7, price: 24.99})
      expect(@product.quantity).to be_kind_of(Numeric)
      @product2 = @category.products.create({name: "Super Soaker", quantity: nil, price: 24.99})
      expect(@product2.errors.full_messages).to include "Quantity can't be blank"
    end
    it 'validates a category is given' do
      @category = Category.create(name: "Books")
      @product = @category.products.create(name: "Harry Potter", quantity: 11, price: 20.20)
      expect(@product.category.name).to eq("Books")
      @product2 = Product.create(name: "Harry Potter", category: nil, quantity: 11, price: 20.20)
      expect(@product2.errors.full_messages).to include "Category can't be blank"
    end
  end
end
