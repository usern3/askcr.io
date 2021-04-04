class Users::Delete < BrowserAction
  route do
    user = UserQuery.find(user_id)
    email = user.email
    user.soft_delete
    flash.success = "User #{email} successfully deleted."
    redirect SignIns::New
  end
end
