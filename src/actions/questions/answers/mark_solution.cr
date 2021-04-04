class Questions::Answers::MarkSolution < QuestionAction
  post "/questions/:question_id/answers/:answer_id/solution" do
    question = QuestionQuery.find(question_id)
    answer = AnswerQuery.find(answer_id)
    if question.solution_id.nil?
      SaveQuestion.update(question, solution_id: answer.id) do |op, question|
        if op.saved?
          SaveAnswer.update(answer, solution: true) do |operation, answer|
            if answer
              flash.keep
              flash.success = "Successfully marked the solution!"
              redirect_back fallback: Questions::Show.with(question.id)
            else
              flash.failure = "It looks like the form is not valid"
              redirect_back fallback: Questions::Show.with(question.id)
            end
          end
        else
          flash.failure = "Something went wrong. Please try again."
          redirect_back fallback: Questions::Show.with(question.id)
        end
      end
    else
      raise "Only one solution per answer!"
    end
  end
end
