module Auth::RequireEmailConfirmation
  include Lucky::UrlHelpers

  abstract def current_user : User

  macro included
    before require_email_confirmation
  end

  private def require_email_confirmation
    user = current_user
    return continue if user.nil? || user.email_confirmed_at

    flash.keep
    flash.info = "Please confirm your email first"
    redirect to: ConfirmEmail::New
  end
end