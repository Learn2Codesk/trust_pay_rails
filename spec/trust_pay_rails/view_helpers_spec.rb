require 'spec_helper'
require 'trust_pay_rails/view_helpers'

require 'action_view'
require 'active_support'

describe TrustPayRails::ViewHelpers do
  class ActionView::Base
    def protect_against_forgery?
      false
    end
  end
  ActionView::Base.send :include, TrustPayRails::ViewHelpers

  before :each do
    TrustPayRails::Signature.environment = :testing
    TrustPayRails::Signature.key = 'abcd1234'
    TrustPayRails::Signature.aid = "9876543210"
  end

  subject do
    ActionView::Base.new
 end

  it 'generates a signed form' do
    form = subject.trust_pay_form(amt: '123.45',
                          cur: 'EUR',
                          ref: '1234567890')

    expect(form).to match('action="https://test.trustpay.eu/mapi/pay.aspx"')
    expect(form).to match('method="post"')
    expect(form).to match('<input type="hidden" name="aid" id="aid" value="9876543210" />')
    expect(form).to match('<input type="hidden" name="amt" id="amt" value="123.45" />')
    expect(form).to match('<input type="hidden" name="cur" id="cur" value="EUR" />')
    expect(form).to match('<input type="hidden" name="ref" id="ref" value="1234567890" />')
    expect(form).to match('<input type="hidden" name="sig" id="sig" value="DF174E635DABBFF7897A82822521DD739AE8CC2F83D65F6448DD2FF991481EA3" />')
    expect(form).to match('Pay with bank transfer')
  end

  it 'generates a signed card form' do
    form = subject.trust_pay_card_form(amt: '123.45',
                               cur: 'EUR',
                               ref: '1234567890')

    expect(form).to match('action="https://test.trustpay.eu/mapi/cardpayments.aspx"')
    expect(form).to match('method="post"')
    expect(form).to match('<input type="hidden" name="aid" id="aid" value="9876543210" />')
    expect(form).to match('<input type="hidden" name="amt" id="amt" value="123.45" />')
    expect(form).to match('<input type="hidden" name="cur" id="cur" value="EUR" />')
    expect(form).to match('<input type="hidden" name="ref" id="ref" value="1234567890" />')
    expect(form).to match('<input type="hidden" name="sig" id="sig" value="DF174E635DABBFF7897A82822521DD739AE8CC2F83D65F6448DD2FF991481EA3" />')
    expect(form).to match('Pay with card')
  end

end
