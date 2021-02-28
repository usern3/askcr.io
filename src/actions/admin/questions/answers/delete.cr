class Admin::Questions::Answers::Delete < BrowserAction
  route do
    answer = AnswerQuery.new.preload_question.find(answer_id)
    question_id = answer.question.id
    answer.soft_delete
    flash.success = "Answer removed successfully."
    redirect Questions::Show.with(question_id)
  end
end
