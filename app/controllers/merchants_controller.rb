class MerchantsController < ApplicationController
  def login
    auth_hash = request.env['omniauth.auth']
  end
end
