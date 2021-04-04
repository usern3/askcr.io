class Questions::Edit < BrowserAction
  route do
    question = QuestionQuery.new.preload_tags.find(question_id)
    html EditPage,
      operation: SaveQuestion.new(question),
      question: question
  end
end
