class DashboardController < ApplicationController
  def index
    @books = User.all
  end
end
