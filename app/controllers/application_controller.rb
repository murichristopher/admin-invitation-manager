class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_administrator!, unless: :devise_controller?

  allow_browser versions: :modern
end
