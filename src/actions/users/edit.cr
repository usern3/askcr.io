class Users::Edit < BrowserAction
  route do
    html EditPage,
      operation: SaveUser.new(current_user)
  end
end
