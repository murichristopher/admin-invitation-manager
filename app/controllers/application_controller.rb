class ApplicationController < ActionController::Base
  before_action :authenticate_administrator!, unless: :devise_controller?

  allow_browser versions: :modern
end
