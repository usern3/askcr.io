class Admin::Questions::Answers::Delete < AdminAction
  delete "/admin/answers/:answer_id/delete" do
    answer = AnswerQuery.new.preload_question.find(answer_id)
    question = QuestionQuery.find(answer.question.id)
    answer.soft_delete
    flash.success = "Answer removed successfully."
    redirect Admin::Questions::Answers::Index
  end
end
