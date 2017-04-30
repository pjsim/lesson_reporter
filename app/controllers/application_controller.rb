class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found, layout: false
  end
end
