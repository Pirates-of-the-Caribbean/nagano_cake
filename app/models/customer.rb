class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :shipping_addresses,dependent: :destroy
  has_many :cart_items,dependent: :destroy
  has_many :orders,dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :postcode, length: { is:7 }
  validates :address, presence: true
  validates :telephone_number, presence: true


  # ログインするときに退会済みのユーザーをはじくためのメソッドを作成する
  def active_for_authentication?
  	super && (self.validness == true)
  end
end
