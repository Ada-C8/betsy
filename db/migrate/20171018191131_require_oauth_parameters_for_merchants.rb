class RequireOauthParametersForMerchants < ActiveRecord::Migration[5.1]
  def change
    change_column_null :merchants, :oauth_uid, false
    change_column_null :merchants, :oauth_provider, false
  end
end
