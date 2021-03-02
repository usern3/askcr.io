class Admin::Answers::Delete < AdminAction
  delete "/admin/answers/:answer_id/delete" do
    answer = AnswerQuery.find(answer_id)
    question_id = answer.question.id
    answer.soft_delete
    flash.success = "Answer removed successfully."
    redirect Questions::Show.with(question_id)
  end
end
