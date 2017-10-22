class AddAttachmentPhotoToMerchants < ActiveRecord::Migration[5.1]
  def self.up
    change_table :merchants do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :merchants, :photo
  end
end
