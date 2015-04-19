module TrustPayRails
  module ViewHelpers

    def trust_pay_form(attributes={})
      form_tag TrustPayRails.bank_transfer_url do
        form_elements = trust_pay_form_elements(attributes)
        form_elements << submit_tag('Pay with bank transfer')

        form_elements.join.html_safe
      end
    end

    def trust_pay_card_form(attributes={})
      form_tag TrustPayRails.card_transfer_url do
        form_elements = trust_pay_form_elements(attributes)
        form_elements << submit_tag('Pay with card')

        form_elements.join.html_safe
      end
    end

    private

    def trust_pay_form_elements(attributes={})
      form_elements = attributes.merge!(aid: TrustPayRails.aid).map do |name, value|
        hidden_field_tag name, value
      end
      form_elements << hidden_field_tag(:sig, TrustPayRails::Signature.sign(attributes))

      form_elements
    end

  end
end
