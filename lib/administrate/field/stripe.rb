require "administrate/field/base"
require "rails"

module Administrate
  module Field
    class Stripe < Administrate::Field::Base

      def to_s
        raise data.inspect
        return "n/a" if data.nil?
        if data =~ /cus_/
          if test_mode?
            link_to "View in Stripe", "https://dashboard.stripe.com/test/customers/#{data}", target: '_blank'
          else
            link_to "View in Stripe", "https://dashboard.stripe.com/customers/#{data}", target: '_blank'
          end
        elsif data =~ /acct_/
          if test_mode?
            link_to "View in Stripe", "https://dashboard.stripe.com/test/applications/users#{data}", target: '_blank'
          else
            link_to "View in Stripe", "https://dashboard.stripe.com/applications/users#{data}", target: '_blank'
          end
        else
          data
        end
      end

      def test_mode?
        return @test_mode if @test_mode.defined?
        if defined? Stripe
          if Stripe.respond_to?(api_key)
            @test_mode = Stripe.api_key =~ /test/
          end
        end
      end
    end
  end
end
