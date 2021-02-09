class Questions::Create < BrowserAction
  route do
    SaveQuestion.create(params, solved: false, author_id: current_user.id) do |operation, question|
      if question
        flash.success = "The record has been saved"
        redirect Show.with(question.id)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation
      end
    end
  end
end
