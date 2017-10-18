class AddOauthDataToMerchants < ActiveRecord::Migration[5.1]
  def change
    add_column :merchants, :oauth_provider, :string
    add_column :merchants, :oauth_uid, :string
  end
end
