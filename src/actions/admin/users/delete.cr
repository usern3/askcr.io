class Admin::Users::Delete < BrowserAction
  delete "/admin/users/:user_id" do
    user = UserQuery.find(user_id)
    email = user.email
    user.soft_delete
    flash.success = "Succesfully deleted the user \"#{email}.\""
    redirect Admin::Users::Index
  end
end
