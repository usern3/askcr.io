class Users::Edit < BrowserAction
  get "/users/:user_id/edit" do
    html EditPage,
      operation: EditUser.new(current_user, user: current_user)
  end
end
