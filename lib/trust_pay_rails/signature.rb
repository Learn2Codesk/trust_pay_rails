require 'openssl'
require 'active_support/core_ext/hash/slice'

module TrustPayRails
  class Signature
    def self.sign(data={})
      new(TrustPayRails.key).sign(data)
    end

    def self.signature_match?(data)
      new(TrustPayRails.key).signature_match?(data)
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

