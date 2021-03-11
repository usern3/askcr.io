class SignUps::Create < BrowserAction
  include Auth::RedirectSignedInUsers

  post "/sign_up" do
    SignUpUser.create(params, role: User::Role.new(:member)) do |operation, user|
      if user
        flash.success = "Verify your e-mail and login!"
        AccountConfirmEmail.new(user).deliver
        redirect to: SignIns::New
      else
        flash.info = "Couldn't sign you up"
        html NewPage, operation: operation
      end
    end
  end
end
