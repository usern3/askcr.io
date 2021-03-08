class Admin::Users::Update < AdminAction
  post "/admin/users/:user_id/edit" do
    user = UserQuery.new.preload_questions(QuestionQuery.new.preload_tags(TagQuery.new)).find(user_id)
    SaveUser.update(user, params) do |operation, user|
      if operation.saved?
        flash.keep
        flash.success = "Profile successfully updated."
        redirect Admin::Users::Index
      else
        flash.failure = "It looks like the form is not valid"
        html Admin::Users::EditPage, operation: operation, user: current_user
      end
    end
  end
end
