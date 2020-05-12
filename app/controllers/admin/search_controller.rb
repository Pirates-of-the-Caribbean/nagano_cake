class Admin::SearchController < Admin::Base

  def search
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @records = search_for(@model, @content)
  end

  private
  def search_for(model, content)
    # 顧客情報はカナでも検索可能にしました。
    if model == 'customer'
        Customer.where('first_name LIKE ? OR last_name LIKE ? OR first_name_kana LIKE ? OR last_name_kana LIKE ?', '%'+content+'%', '%'+content+'%', '%'+content+'%', '%'+content+'%').page(params[:page]).per(10)
    elsif model == 'item'
        Item.where('name LIKE ?', '%'+content+'%').page(params[:page]).per(10)
      end
    end
  end
