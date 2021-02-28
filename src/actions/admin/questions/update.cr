class Admin::Questions::Update < BrowserAction
  post "/admin/questions/:question_id/edit" do
    question = QuestionQuery.find(question_id)
    SaveQuestion.update(question, params) do |operation, question|
      if operation.saved?
        flash.keep
        flash.success = "The record has been updated"
        redirect Show.with(question.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, question: question
      end
    end
  end
end
