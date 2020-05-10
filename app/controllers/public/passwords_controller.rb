# frozen_string_literal: true

class Public::PasswordsController < Devise::PasswordsController
  layout 'public'
  prepend_before_action :require_no_authentication, only: :new
  append_before_action :assert_reset_token_passed, only: :a

# メールリンクなしで:new,:create,:edit,:updateできるようにするため
  def a
  end
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  def update
    if current_customer.reset_password( params[:customer][:password], params[:customer][:password])
      flash[:password] = 'パスワードを変更しました。もう一度ログインしてください'
      redirect_to root_path
    else
      redirect_to edit_customer_password_path
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

end
