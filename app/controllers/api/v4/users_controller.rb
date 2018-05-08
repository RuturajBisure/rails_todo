class Api::V4::UsersController < ApplicationController
  skip_before_action :authenticate_user!
end
