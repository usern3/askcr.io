class Static::Banned < BrowserAction
  get "/banned/:user_id" do
    user = UserQuery.find(user_id)
    html Static::BannedUser, user: user
  end
end
