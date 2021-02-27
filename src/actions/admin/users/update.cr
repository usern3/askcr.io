class Admin::Users::Update < BrowserAction
  route do
    SaveUser.update(current_user, params) do |operation, user|
      if operation.saved?
        flash.keep
        flash.success = "Profile successfully updated."
        redirect Admin::Users::Index
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, user: current_user
      end
    end
  end
end