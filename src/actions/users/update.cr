class Users::Update < BrowserAction
  include ErrorFormatters
  post "/users/:user_id/edit" do
    EditUser.update(current_user, params, user: current_user) do |operation, user|
      pp! operation
      if operation.saved?
        if operation.password_changes_success.value
          sign_out
          flash.info = "Password successfully changed. Please login again wih your new password."
          redirect to: SignIns::New
        else
          flash.keep
          flash.success = "Profile successfully updated."
          redirect Dashboard::Show
        end
      else
        flash.failure = "#{join_error_messages(operation.errors)}"
        html EditPage, operation: operation, user: current_user
      end
    end
  end
end
