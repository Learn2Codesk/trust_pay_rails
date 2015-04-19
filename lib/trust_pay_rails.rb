require "trust_pay_rails/version"
require "trust_pay_rails/signature"

require 'trust_pay_rails/railtie' if defined?(Rails)

module TrustPayRails
  @environment = (ENV['TRUSTPAY_ENV'] || :testing).to_sym
  @aid = ENV['TRUSTPAY_AID']
  @key = ENV['TRUSTPAY_KEY']
  class << self
    attr_accessor :environment, :fake_bank_url, :fake_card_url, :aid, :key
  end

  def self.bank_transfer_url
    case @environment
    when :testing
      'https://test.trustpay.eu/mapi/pay.aspx'
    when :production
      'https://ib.trustpay.eu/mapi/pay.aspx'
    when :fake
      @fake_bank_url
    end
  end

  def self.card_transfer_url
    case @environment
    when :testing
      # this won't actually work because trustpay does not offec car payment
      # testing.
      'https://test.trustpay.eu/mapi/cardpayments.aspx'
    when :production
      'https://ib.trustpay.eu/mapi/cardpayments.aspx'
    when :fake
      @fake_card_url
    end
  end
end
