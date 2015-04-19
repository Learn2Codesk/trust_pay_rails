module TrustPayRails
  module Generators
    class RoutesGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def generate_routes
        route "get '/trust_pay/notification' => 'trust_pay#notification', as: :trust_pay_notification"
        route "get '/trust_pay/return' => 'trust_pay#return', as: :trust_pay_return"
        route "get '/trust_pay/cancel' => 'trust_pay#cancel', as: :trust_pay_cancel"
        route "get '/trust_pay/error' => 'trust_pay#error', as: :trust_pay_error"
      end

      def generate_controller
        copy_file "trust_pay_controller.rb", "app/controllers/trust_pay_controller.rb"
      end
    end
  end
end

