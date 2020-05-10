class Public::HomesController < Public::Base
	before_action :authenticate_customer!, except: [:top]
  def top
    @genres = Genre.all
  end
end
