class Api::V4::TodosController < ApplicationController
  skip_before_action :authenticate_user!
end
