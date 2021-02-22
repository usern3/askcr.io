class SignIns::Create < BrowserAction
  include Auth::RedirectSignedInUsers

  post "/sign_in" do
    SignInUser.run(params) do |operation, authenticated_user|
      if authenticated_user
        sign_in(authenticated_user)
        flash.keep
        flash.success = "Welcome back! You're now signed in!"
        redirect_back fallback: Dashboard::Show
      else
        flash.failure = "Sign in failed"
        html NewPage, operation: operation
      end
    end
  end
end
