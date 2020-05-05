class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :shipping_addresses,dependent: :destroy
  has_many :cart_items,dependent: :destroy
  has_many :orders,dependent: :destroy
  # ログインするときに退会済みのユーザーをはじくためのメソッドを作成する
  def active_for_authentication?
  	super && (self.validness == true)
  end
end
