module Secrets
  module Secret
    # I haz secrets
    extend ActiveSupport::Concern

    included do
      before_save :obscure_secrets
    end

    def secret_attributes
      # Returns a list with secret attributes
      attribute_names.to_a.keep_if { |attri| attri.starts_with? 'secret_' }
    end

    def secrets
      secret_attributes.map { |attri| attri.gsub('secret_', '') }
    end

    def obscure_secrets
      secrets.each do |secret|
        secret_value = self.send :read_attribute, secret

        # Set the secret value to his secret field
        self.send :write_attribute, "secret_#{secret}", secret_value
        self.send :write_attribute, secret,  nil
      end
    end

    def expose_secrets
      secrets.each do |secret|
        secret_value = self.send :read_attribute, "secret_#{secret}"
        self.send :write_attribute, secret, secret_value
      end
    end
  end
end
