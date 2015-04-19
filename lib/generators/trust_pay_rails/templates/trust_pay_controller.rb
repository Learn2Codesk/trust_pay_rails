class TrustPayController < ApplicationController

  def notification
    if TrustPayRails::Signature.signature_match?(trust_pay_params)
      # TODO: store payment
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def return
    # TODO: process user return

    redirect_to root_url, notice: [t('.flash_message')]
  end

  def cancel
    redirect_to root_url, notice: [t('.flash_message')]
  end

  def error
    # TODO: process error

    redirect_to root_url, notice: [t('.flash_message')]
  end

  private

  def trust_pay_params
    @trust_pay_params ||= Hash[params.map{|k, v| [k.downcase.to_sym, v]}]
  end
end
