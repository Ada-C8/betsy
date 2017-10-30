require "test_helper"

describe ProductsController do

  describe "index" do
    it "allows you to see products when products exist" do
      Product.count.must_be :>, 0, "No products"
      get products_path
      must_respond_with :success
    end

    it "still succceeds when there are no products" do
      Product.destroy_all
      get products_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "will allow you to see a form to create a new product" do
      get new_product_path
      must_respond_with :success
    end
  end

  describe "create" do
    let(:tanja) {users(:tanja)}

    it "for logged in user, will create a new product with valid input" do
      start_count = Product.count
      login(tanja)


      product_data = {
        product: {
        name: "Snakeskin pants",
        categories: [categories(:clothing).id, categories(:food).id],
        price: 999.99,
        quantity: 2,
        stock: "In Stock",
        user: tanja
      }
    }

      post products_path, params: product_data
      new_product = Product.last
      # puts new_product.name
      must_redirect_to product_path(new_product.id)
      Product.count.must_equal start_count + 1
    end

    it "will not create a product if user is not logged in" do
      start_count = Product.count

      product_data = {
        product: {
        name: "Snakeskin pants",
        categories: [categories(:clothing).id, categories(:food).id],
        price: 999.99,
        quantity: 2,
        stock: "In Stock",
        user: tanja
      }
    }

      post products_path, params: product_data
      Product.count.must_equal start_count
      flash[:result_text].must_equal "Error: Product was not added"
    end
  end

  describe "show" do
    it "will go to an existing product's page" do
      get product_path(Product.first.id)
      must_respond_with :success
    end

    it "will render 404 if the product does not exist" do
      nonexistant_id = ((Product.last).id) + 1

      get product_path(nonexistant_id)
      must_respond_with :not_found
    end

  end

  describe "edit" do
    it "will get the edit form for an existing product" do
      get edit_product_path(Product.first)

      must_respond_with :success
    end

    it "renders bad_request and does not pull up an edit form for a nonexistant product" do
      last_product_id = Product.last.id
      p last_product_id
      # nonexistant_product = Product.find_by(id: (last_product_id + 1) )
      get edit_product_path((last_product_id + 1))
      must_respond_with :not_found
    end

  end

  describe "update" do

    it "updates with valid data and an existing product " do
      product = products(:chocolate)
      product_data = {
        product: {
          name: product.name + " 2",
          categories: [categories(:food)],
          description: "Chocolate with gold inside",
          price: 15.00,
          quantity: 10,
          user: users(:tanja),
        }
      }

      patch product_path(product), params: product_data
      must_redirect_to product_path(product)

      # Verify the DB was really modified
      Product.find(product.id).name.must_equal product_data[:product][:name]
      Product.find(product.id).price.must_equal product_data[:product][:price]
    end

    it "does not update with bogus data and an existing product " do
      product = products(:soap)
      product_data = {
        product: {
          name: "",
          categories: [categories(:food)],
          description: "Chocolate with gold inside",
          price: 15.00,
          quantity: 10,
          user: users(:tanja),
        }
      }

      patch product_path(product), params: product_data
      must_respond_with :not_found

      # Verify the DB was really modified
      Product.find(product.id).name.must_equal product.name

    end

    it "only allows the product owner to edit" do
      p "Test and functionality must be implemented"

    end

    it "handles bad data" do
      valid_name = products(:yacht).name
      put product_path(products(:yacht).id), params: { product: {name: "",categories: [categories(:food), categories(:transportation)] ,description: "Great yacht!",quantity: 100,price: 12400.00, user: users(:tanja)}}
      yacht = Product.find_by_id(products(:yacht).id)
      new_name = yacht.name
      new_name.must_equal valid_name
    end

  end

  describe "destroy" do
    it "successfully destroys an existing work" do
      product_id = Product.first.id

      delete product_path(product_id)
      must_redirect_to root_path

      # The work should really be gone
      Product.find_by(id: product_id).must_be_nil
    end
  end


  describe "guest" do
    it "allows guest to go to the index page" do
      get products_path

      must_respond_with :success
    end

    it "allows guest to go to a product's show page" do
      product = products(:soap)
      get product_path(product)

      must_respond_with :success

    end

  end
end
