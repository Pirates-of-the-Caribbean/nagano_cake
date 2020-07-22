require 'rails_helper'

RSpec.describe Admin, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
	context "データが正しく保存される" do
		before do
			@admin = Admin.new
	  		@admin.email = "test@test.com"
			@admin.password = "password"
			@admin.password_confirmation = "password"
			@admin.save
  		end
		it "すべて入力してあるので保存される" do
  			expect(@admin).to be_valid
		end
	end
end
