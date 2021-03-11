class Static::Home < BrowserAction
  include Auth::AllowGuests

  get "/" do
    users = UserQuery.new
    answers = AnswerQuery.new
    tags = TagQuery.new
    questions = QuestionQuery.new
    html Static::HomePage, operation: SignInUser.new, questions: questions, tags: tags, users: users, answers: answers
  end
end
