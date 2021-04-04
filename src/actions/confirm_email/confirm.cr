class ConfirmEmail::Confirm < BrowserAction
  include Auth::AllowGuests

  param token : String

  get "/confirm_email/:user_id/" do
    user = UserQuery.find(user_id)
    flash.keep

    token_valid = false

    begin
      token_valid = Authentic.valid_password_reset_token?(user, token)
    rescue Lucky::InvalidSignatureError
      Log.warn { "Invalid signature for user_id: #{user_id}" }
    end

    if token_valid
      ConfirmEmail.update(user) do |operation, user|
        if operation.saved?
          flash.success = "Your account is now verified"
        else
          flash.failure = "There was an error validating your email. Please try again."
        end
      end
    else
      flash.failure = "The confirmation link is incorrect or expired. Please try again."
    end

    if current_user?
      redirect to: Dashboard::Show
    else
      redirect to: SignIns::New
    end
  end
end
