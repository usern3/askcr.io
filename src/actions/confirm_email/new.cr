class ConfirmEmail::New < BrowserAction

  get "/confirm_email" do
    html NewPage
  end
end