class Admin::Questions::Edit < AdminAction
  get "/admin/questions/:question_id/edit" do
    question = QuestionQuery.new.preload_tags.find(question_id)
    html EditPage,
      operation: SaveQuestion.new(question),
      question: question
  end
end
