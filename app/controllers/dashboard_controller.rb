class DashboardController < ApplicationController
  before_action :authenticate_user!

  def Dashboard_create
    Dashboard.new
  end

 
end