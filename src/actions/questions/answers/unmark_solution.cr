class Questions::Answers::UnmarkSolution < QuestionAction
  delete "/questions/:question_id/answers/:answer_id/solution" do
    question = QuestionQuery.find(question_id)
    answer = AnswerQuery.find(answer_id)
    SaveQuestion.update(question, solution_id: nil) do |op, question|
      if op.saved?
        SaveAnswer.update(answer, solution: false) do |operation, answer|
          if answer
            flash.keep
            flash.success = "Successfully removed previous solution!"
            redirect_back fallback: Questions::Show.with(question.id)
          else
            flash.failure = "Something went wrong. Please try again."
            redirect_back fallback: Questions::Show.with(question.id)
          end
        end
      else
        flash.failure = "Something went wrong. Please try again."
        redirect_back fallback: Questions::Show.with(question.id)
      end
    end
  end
end
