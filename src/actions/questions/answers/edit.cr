class Questions::Answers::Edit < BrowserAction
  get "/questions/:question_id/answers/:answer_id/edit" do
    answer = AnswerQuery.new.preload_question.find(answer_id)
    question = QuestionQuery.find(question_id)
    html EditPage,
      operation: SaveAnswer.new,
      answer: answer,
      question: question
  end
end
