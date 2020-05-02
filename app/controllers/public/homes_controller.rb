class Public::HomesController < Public::Base
  def top
    @genres = Genre.all
  end
end
