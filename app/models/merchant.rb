class Merchant < ApplicationRecord
  has_many :products

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
