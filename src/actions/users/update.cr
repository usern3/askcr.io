class Users::Update < BrowserAction
  post "/users/:user_id/edit" do
    SaveUser.update(current_user, params) do |operation, user|
      pp! operation
      if operation.saved?
        flash.keep
        flash.success = "Profile successfully updated."
        redirect Dashboard::Show
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, user: current_user
      end
    end
  end
end
