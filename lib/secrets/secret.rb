module Secrets
  module Secret
    # I haz secrets
    extend ActiveSupport::Concern

    included do
      before_save :obscure_secrets

      def self.secret_attributes
        self.attribute_names.to_a.keep_if { |attri| attri.starts_with? 'secret_' }
      end

      def self.secrets
        self.secret_attributes.map { |attri| attri.gsub('secret_', '') }
      end

      private

      secret_attributes.each do |secret_attribute|
        # secret_<name> is now a private method
        # TODO: Can we do something with the superclass?
        define_method(secret_attribute) { self[secret_attribute] }
      end
    end

    def obscure_secrets
      self.class.secrets.each do |secret|
        secret_value = self.send :read_attribute, secret

        # Set the secret value to his secret field
        self.send :write_attribute, "secret_#{secret}", secret_value
        self.send :write_attribute, secret,  nil
      end
    end

    def expose_secrets
      self.class.secrets.each do |secret|
        secret_value = self.send :read_attribute, "secret_#{secret}"
        self.send :write_attribute, secret, secret_value
      end
    end
  end
end
