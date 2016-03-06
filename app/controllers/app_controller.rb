class AppController < ApplicationController
  # We use this controller to defend all the
  # business logic from not authenticated users
  before_filter :require_login

end
