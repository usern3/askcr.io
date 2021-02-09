class SignUps::Create < BrowserAction
  include Auth::RedirectSignedInUsers

  post "/sign_up" do
    SignUpUser.create(params, role: 0) do |operation, user|
      if user
        flash.success = "You're now a registered user! Now, start asking and answering questions!"
        sign_in(user)
        redirect to: Dashboard::Show
      else
        flash.info = "Couldn't sign you up"
        html NewPage, operation: operation
      end
    end
  end
end
