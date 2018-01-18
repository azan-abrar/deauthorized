class ApplicationController < ActionController::Base
  # fix for authenticity token errors
  protect_from_forgery unless: -> { request.format.json? }

  layout :layout_by_resource
  before_action :subdomain_redirect


  private

  #   # override the devise helper to store the current location so we can
  #   # redirect to it after loggin in or out. This override makes signing in
  #   # and signing up work automatically.

  def layout_by_resource
    if user_signed_in?
      'user'
    else
      'application'
    end
  end

  def subdomain_redirect
    return if self.is_a?(DeviseController)

    if user_signed_in? && (request.subdomain != current_user.subdomain)
      # redirects the user to their own sub-domain / tenant
      host = request.host_with_port.sub! request.subdomain, current_user.subdomain
      redirect_to "http://#{host}#{request.path}"
    end
  end
end
