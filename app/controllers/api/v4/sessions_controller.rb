class Api::V4::SessionsController < ApplicationController
  skip_before_action :authenticate_user!
end
