require 'openssl'
require 'active_support/core_ext/hash/slice'

module TrustPayRails
  class Signature
    @environment = :testing
    class << self
      attr_accessor :environment, :fake_bank_url, :fake_card_url, :aid, :key
    end

    def self.sign(data={})
      new(key).sign(data)
    end

    def self.signature_match?(data)
      new(key).signature_match?(data)
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

    def initialize(key)
      @key = key
    end

    # FIXME: use ruby 2.1 required arguments when we switch
    def sign(data={})
      hmac_sha_256(@key, data.slice(:aid, :typ, :amt, :cur, :ref, :res, :tid, :oid, :tss).values.join).upcase
    end

    def signature_match?(data={})
      sign(data) == data[:sig]
    end

    private

    def hmac_sha_256(key, data)
      unpack_hex_string(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), key, data))
    end

    def unpack_hex_string(data)
      data.unpack("H*").first
    end
  end
end

