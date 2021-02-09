class Static::Home < BrowserAction
  include Auth::AllowGuests

  get "/" do
    html Static::HomePage, operation: SignInUser.new()
  end
end
