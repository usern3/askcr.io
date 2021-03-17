class Users::Edit < BrowserAction
  route do
    html EditPage,
      operation: EditUser.new(current_user, user: current_user)
  end
end
