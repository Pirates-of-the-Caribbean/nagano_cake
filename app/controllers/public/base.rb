class Public::Base < ApplicationController
     layout 'public'
     before_action :authenticate_customer!
end