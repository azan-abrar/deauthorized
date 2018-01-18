class Subdomain
  class << self
    def matches?(request)
      request.subdomain.present? && !self.excluded.include?(request.subdomain)
    end

    def excluded
      %w(www)
    end
  end
end
