class Admin::Answers::Delete < AdminAction
  delete "/admin/answers/:answer_id/delete" do
    answer = AnswerQuery.new.preload_question.find(answer_id)
    answer.soft_delete
    flash.success = "Answer removed successfully."
    redirect Admin::Answers::Index
  end
end
