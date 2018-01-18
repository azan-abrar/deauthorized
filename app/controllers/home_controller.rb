class HomeController < ApplicationController
  # redirection not needed on public pages
  skip_before_action :subdomain_redirect

  def index
    # code
  end

  def about_us
    # code
  end

  def contact
    # code
  end

  def consumers

  end

  def enterprises

  end

  def pricing
    # code
  end

  def privacy_policy
    # code
  end

  def terms_of_service
    # code
  end
end
