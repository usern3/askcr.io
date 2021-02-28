class Admin::Users::Edit < BrowserAction
  get "/admin/users/:user_id/edit" do
    user = UserQuery.new.preload_questions(QuestionQuery.new).preload_answers(AnswerQuery.new).find(user_id)
    html EditPage,
      operation: SaveUser.new(user),
      user: user
  end
end
