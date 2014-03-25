require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  fictures :products 

 
test "product attributes must not be empty" do 
 	product = Product.new
 	assert product.invalid?
 	assert product.errors[:title].any?
	assert product.errors[:description].any?
 	assert product.errors[:price].any?
 	assert product.errors[:image_url].any?

 end

test "product is not valid without a unique title" do
  product = Product.new(title: products(:ruby).title,
  	description: "yyyy",
  	price: 1,
  	image_url: "fred.gif")
  assert product.invalid?
  assert_equal ["has alread been taken"], product.errors[:title]

end

test "product price must must be positive" do 
 	product = Product.new(title: "my new book",
 		description: "nice",
 		image_url: "zzz.png"
 		)
 	product.price = -1
 	assert product.invalid?
 	asset_equal ["must be greater than or equal to 0.01"], 
 		product.errors[:price]
 	
 	product.price = 1
    assert product.invalid?
 	asset_equal ["must be greater than or equal to 0.01"], 
 		product.errors[:price]

 	product.price = 0
    assert product.invalid?

 	assert product.errors[:title].any?
	assert product.errors[:description].any?
 	assert product.errors[:price].any?
 	assert product.errors[:image_url].any?

 end

def new_product(image_url)
Product.new(title: "my new book",
 		description: "nice",
 		price: 1,
 		image_url: image_url
 		)
end

test "image_url" do
	ok = %w{ fred.gif fred.jpg fred.png FRED.GIF FRED.JPG FRED.png
			http://a.b.c/x/y/z/fred.gif }
bad = %w{ fred.doc fred.gif/more fred.gif.more}
ok.each do |name|
	assert new_product(name).valid?, "#{name} should be valid"
	end

bad.each do |name|
	assert new_product(name).invalid?, "#{name} shouldn't be valid"
	end

end


end
