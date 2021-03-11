class Questions::Answers::Edit < BrowserAction
  get "/questions/:question_id/answers/:answer_id/edit" do
    answer = AnswerQuery.new.preload_question.find(answer_id)
    question = QuestionQuery.find(question_id)
    html EditPage,
      operation: SaveAnswer.new,
<<<<<<< HEAD
      answer: answer
=======
      answer: answer,
      question: question
>>>>>>> 906ca1639dc65a14a90cb9021e764fab39f4e13b
  end
end
