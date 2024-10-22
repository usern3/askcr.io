class PasswordResets::Create < BrowserAction
  include Auth::PasswordResets::Base
  include Auth::PasswordResets::TokenFromSession

  post "/password_resets/:user_id" do
    ResetPassword.update(user, params) do |operation, user|
      if operation.saved?
        session.delete(:password_reset_token)
        sign_in user
        flash.success = "Your password has been reset"
        redirect to: Static::Home
      else
        html NewPage, operation: operation, user_id: UUID.new(user_id)
      end
    end
  end
end
