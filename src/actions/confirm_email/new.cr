class ConfirmEmail::New < BrowserAction
  include Auth::AllowSkipEmailConfirmation

  get "/confirm_email" do
    html NewPage
  end
end