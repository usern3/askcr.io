class Admin::Answers::Edit < AdminAction
  get "/admin/answers/:answer_id/edit" do
    answer = AnswerQuery.find(answer_id)
    html Admin::EditPage,
      operation: SaveAnswer.new(answer),
      answer: answer
  end
end
