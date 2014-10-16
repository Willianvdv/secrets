class WithSecret < ActiveRecord::Base
  include Secrets::Secret
end
