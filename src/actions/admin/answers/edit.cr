<<<<<<< HEAD
class Admin::Answers::Edit < BrowserAction
  get "/admin/answers/:answer_id/edit" do
    answer = AnswerQuery.new.preload_question.find(answer_id)
    html EditPage,
      operation: SaveAnswer.new(answer),
      answer: answer,
      question_id: question_id
=======
class Admin::Answers::Edit < AdminAction
  get "/admin/questions/:question_id/answers/:answer_id/edit" do
    answer = AnswerQuery.new.preload_question.find(answer_id)
    question = QuestionQuery.find(answer.question.id)
    html Admin::Answers::EditPage,
      operation: SaveAnswer.new(answer),
      answer: answer
>>>>>>> 906ca1639dc65a14a90cb9021e764fab39f4e13b
  end
end
