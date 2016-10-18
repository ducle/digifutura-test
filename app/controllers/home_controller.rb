class HomeController < ApplicationController
  before_action :authenticate_user!
  layout 'landing'

end
