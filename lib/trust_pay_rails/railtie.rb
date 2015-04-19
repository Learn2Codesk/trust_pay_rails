require 'trust_pay_rails/view_helpers'

module TrustPayRails
  class Railtie < Rails::Railtie
    initializer "trust_pay_rails.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
