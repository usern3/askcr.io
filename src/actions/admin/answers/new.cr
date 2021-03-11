class Admin::Questions::Answers::New < BrowserAction
  get "/admin/questions/:question_id/answers/new" do
    question = QuestionQuery.new.preload_tags.preload_author.find(question_id)
    html Admin::Answers::NewPage, operation: SaveAnswer.new, question: question
  end
end
