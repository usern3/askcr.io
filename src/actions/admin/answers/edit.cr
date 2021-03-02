class Admin::Answers::Edit < BrowserAction
  get "/admin/answers/:answer_id/edit" do
    answer = AnswerQuery.new.preload_question.find(answer_id)
    question = QuestionQuery.find(question_id)
    html EditPage,
      operation: SaveAnswer.new,
      answer: answer
  end
end
