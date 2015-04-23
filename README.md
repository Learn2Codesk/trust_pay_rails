# TrustPayRails 
[![Build Status](https://travis-ci.org/Learn2Codesk/trust_pay_rails.svg?branch=master)](https://travis-ci.org/Learn2Codesk/trust_pay_rails)

A simple implementation of the [Trustpay](http://www.trustpay.eu/)
payment platform to integrate into Rails apps.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'trust_pay_rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trust_pay_rails

## Usage

To configure the gem you can provide the following environment
variables:

``` bash
TRUSTPAY_ENV - [testing|production|fake_bank_url] select an environment
TRUSTPAY_AID - your identifier received after registering with Trustpay
TRUSTPAY_KEY - your key received after registering with TrustPay
```

You can also configure the gem with an initializer:

``` ruby
TrustPayRails.environment = (ENV['TRUSTPAY_ENV'] || :testing).to_sym
TrustPayRails.aid = ENV['TRUSTPAY_AID']
TrustPayRails.key = ENV['TRUSTPAY_KEY']
```

After configuring the gem you can create a TrustPay form using one of
the provided view helpers.

``` erb
<%= trust_pay_form(amt: '123.45',
                   cur: 'EUR',
                   ref: '1234567890',
                   rurl: trust_pay_return_url,
                   curl: trust_pay_cancel_url,
                   eurl: trust_pay_error_url,
                   nurl: trust_pay_notification_url,
                   dsc: 'a description no longer than 200 chars',
                   lng: I18n.locale)
%>


<%= trust_pay_card_form(amt: '123.45',
                        cur: 'EUR',
                        ref: '1234567890',
                        rurl: trust_pay_return_url,
                        curl: trust_pay_cancel_url,
                        eurl: trust_pay_error_url,
                        nurl: trust_pay_notification_url,
                        dsc: 'a description no longer than 200 chars',
                        lng: I18n.locale)
%>
```

To generate the TrustPay notification urls use the provided generator:

``` bash
rails g trust_pay_rails:routes
```

Now go and fill in the generated TrustPayRails controller with your
custom application callback logic.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/trust_pay_rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
