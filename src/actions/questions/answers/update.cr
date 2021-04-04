class Questions::Answers::Update < BrowserAction
  post "/admin/questions/:question_isanswers/:answer_id" do
    answer = AnswerQuery.new.preload_question.find(answer_id)
    SaveAnswer.update(answer, params) do |operation, answer|
      if operation.saved?
        flash.keep
        flash.success = "Your answer has been updated."
        redirect ::Questions::Show.with(answer.question.id)
      else
        flash.failure = "It looks like the form is not valid"
        redirect Dashboard::Show
      end
    end
  end
end
