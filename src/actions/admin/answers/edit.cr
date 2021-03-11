class Admin::Answers::Edit < AdminAction
  get "/admin/questions/:question_id/answers/:answer_id/edit" do
    answer = AnswerQuery.new.preload_question.find(answer_id)
    question = QuestionQuery.find(answer.question.id)
    html Admin::Answers::EditPage,
      operation: SaveAnswer.new(answer),
      answer: answer
  end
end
