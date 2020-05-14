class Admin::Base < ApplicationController
     layout 'admin'
     before_action :authenticate_admin!
end