class Admin::Questions::Edit < BrowserAction
  get "/admin/questions/:question_id/edit" do
    question = QuestionQuery.new.find(question_id)
    html EditPage,
      operation: SaveQuestion.new(question),
      question: question
  end
end
