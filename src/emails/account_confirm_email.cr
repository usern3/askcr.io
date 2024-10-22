class AccountConfirmEmail < BaseEmail
  TOKEN_EXPIRES_IN = Time::Span.new(days: 10)

  def initialize(@user : User)
    @token = Authentic.generate_password_reset_token(@user, TOKEN_EXPIRES_IN)
  end

  to @user
  subject "Askcr.io - Activate your new account!"
  templates text, html
end
