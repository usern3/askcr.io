class Questions::Answers::Update < BrowserAction
  post "/questions/:question_id/answers/:answer_id" do
    answer = AnswerQuery.find(answer_id)
    SaveAnswer.update(answer, params) do |operation, answer|
      if operation.saved?
        flash.keep
        flash.success = "Your answer has been updated."
        redirect Questions::Show.with(question_id)
      else
        flash.failure = "It looks like the form is not valid"
        redirect Dashboard::Show
      end
    end
  end
end
