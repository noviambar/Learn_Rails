require "awesome_print"

class DashboardController < ApplicationController
 
  layout 'dashboard'
  
  def index
    @time = Time.new
  end
end
