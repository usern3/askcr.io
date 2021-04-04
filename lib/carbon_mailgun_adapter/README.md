# carbon_mailgun_adapter

This is luckyframework/carbon's adapter for Mailgun: https://www.mailgun.com

https://github.com/luckyframework/carbon

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     carbon_mailgun_adapter:
       github: atnos/carbon_mailgun_adapter
   ```

2. Run `shards install`

## Usage

Set your `MAILGUN_API_KEY`, `MAILGUN_BASE_URI` and `MAILGUN_SEND_DOMAIN` variable inside `.env`

```
MAILGUN_API_KEY=key-XXXXXXXXXXXXXXXXXXXXXXXXXX
MAILGUN_BASE_URI=api.mailgun.net
MAILGUN_SEND_DOMAIN=sandboxXXXXXXXXXXXXXXXXXXXXX.mailgun.org
```

and update your `config/email.cr` file with:

```crystal
require "carbon_mailgun_adapter"

BaseEmail.configure do |settings|
  if Lucky::Env.production?
    mailgun_key = mailgun_key_from_env
    mailgun_base_uri = mailgun_base_uri_from_env
    mailgun_send_domain = mailgun_send_domain_from_env
    settings.adapter = Carbon::MailgunAdapter.new(api_key: mailgun_key, base_uri: mailgun_base_uri, send_domain: mailgun_send_domain)
  else
    settings.adapter = Carbon::DevAdapter.new(print_emails: true)
  end
end

private def mailgun_key_from_env
  ENV["MAILGUN_API_KEY"]? || raise_missing_key_message
end

private def mailgun_base_uri_from_env
  ENV["MAILGUN_BASE_URI"]? || raise_missing_base_uri_message
end

private def mailgun_send_domain_from_env
  ENV["MAILGUN_SEND_DOMAIN"]? || raise_missing_send_domain_message
end

private def raise_missing_key_message
  puts "Missing MAILGUN_API_KEY. Set the MAILGUN_API_KEY env variable to '' if not sending emails, or set the MAILGUN_API_KEY ENV var.".colorize.red
  exit(1)
end

private def raise_missing_base_uri_message
  puts "Missing MAILGUN_BASE_URI ENV var.".colorize.red
  exit(1)
end

private def raise_missing_send_domain_message
  puts "Missing MAILGUN_SEND_DOMAIN ENV var.".colorize.red
  exit(1)
end
```

## Contributing

1. Fork it (<https://github.com/your-github-user/carbon_mailgun_adapter/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Bruno Perles](https://github.com/brunto) - creator and maintainer
