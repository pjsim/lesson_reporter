class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Rather than crash if a record isn't found, use the default 404 page instead
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found, layout: false
  end
end
