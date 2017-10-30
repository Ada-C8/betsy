class StaticPagesController < ApplicationController
  def home
    @showcase = Product.all.sample(3)
  end
end
