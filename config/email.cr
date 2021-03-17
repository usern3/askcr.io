require "carbon_mailgun_adapter"

BaseEmail.configure do |settings|
  if Lucky::Env.production?
    mailgun_key = mailgun_key_from_env
    if mailgun_key == ""
      # disable email if there's no key
      settings.adapter = Carbon::DevAdapter.new
    else
      mailgun_base_uri = mailgun_base_uri_from_env
      mailgun_send_domain = mailgun_send_domain_from_env
      settings.adapter = Carbon::MailgunAdapter.new(api_key: mailgun_key, base_uri: mailgun_base_uri, send_domain: mailgun_send_domain)
    end
  elsif Lucky::Env.development?
    settings.adapter = Carbon::DevAdapter.new(print_emails: true)
  else
    settings.adapter = Carbon::DevAdapter.new
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