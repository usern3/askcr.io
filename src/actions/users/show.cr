class Users::Show < BrowserAction
  get "/users/:user_id" do
    user = UserQuery.find(user_id)
    pages, answers = paginate(AnswerQuery.new)
    html ShowPage, user: user, answers: answers, pages: pages
  end
end
