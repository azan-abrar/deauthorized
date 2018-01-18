module RescuableApartmentMiddleware
  def call(*args)
    begin
      super
    rescue Apartment::TenantNotFound
      host = Rails.application.config.action_mailer.default_url_options.map(&:last).join(':')
      redirect_url = Rails.application.routes.url_helpers.root_url(host: host)
      return [ 301, { 'Location' => redirect_url }, [ 'redirect' ] ]
    end
  end
end
