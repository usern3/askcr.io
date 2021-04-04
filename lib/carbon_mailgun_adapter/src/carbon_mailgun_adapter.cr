require "http"
require "json"

class Carbon::MailgunAdapter < Carbon::Adapter
  private getter api_key : String
  private getter base_uri : String
  private getter send_domain : String

  def initialize(@api_key, @base_uri, @send_domain)
  end

  def deliver_now(email : Carbon::Email)
    Carbon::MailgunAdapter::Email.new(email, api_key, base_uri, send_domain).deliver
  end

  class Email
    private getter email, api_key, base_uri, send_domain

    def initialize(@email : Carbon::Email, @api_key : String, @base_uri : String, @send_domain : String)
    end

    def deliver
      client.post("/v3/#{send_domain}/messages", form: params).tap do |response|
        unless response.success?
          raise JSON.parse(response.body).inspect
        end
      end
    end

    def params
      {
        "to" =>  to_mailgun_address(email.to),
        "cc" =>  to_mailgun_address(email.cc),
        "bcc" => to_mailgun_address(email.bcc),
        "subject" => email.subject,
        "from" => from,
        "html" => email.html_body.to_s,
        "text" => email.text_body.to_s
      }.reject{ |key, value| value.blank? }
    end

    private def to_mailgun_address(addresses : Array(Carbon::Address))
      addresses.map do |carbon_address|
        "#{carbon_address.name} <#{carbon_address.address}>"
      end.join(',')
    end

    private def from
      "#{email.from.name} <#{email.from.address}>"
    end

    @_client : HTTP::Client?

    private def client : HTTP::Client
      @_client ||= HTTP::Client.new(base_uri, port: 443, tls: true).tap do |client|
        client.basic_auth("api", api_key)
      end
    end
  end
end
