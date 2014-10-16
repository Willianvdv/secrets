module Secrets
  module Secret
    # I haz secrets

    def secret_attributes
      # Returns a list with secret attributes
      attribute_names.to_a.keep_if { |attri| attri.starts_with? 'secret_' }
    end

    def secrets
      secret_attributes.map { |attri| attri.gsub('secret_', '') }
    end

    def secretalize
      # Makes the secrets secret

    end

    def unsecretalize
      # Makes the secrets not secret anymore
    end
  end
end
