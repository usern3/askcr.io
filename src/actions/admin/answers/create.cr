class Admin::Questions::Answers::Create < AdminAction
  post "/admin/answers" do
    question = AnswerQuery.new.preload_user.preload_questionfind(answer_id)
    SaveAnswer.create(params, question_id: answer.question.id, author_id: answer.author.id, solution: false) do |operation, answer|
      if answer
        flash.keep
        flash.success = "Your answer has been added!"
        redirect Questions::Show.with(question.id)
      else
        flash.failure = "It looks like the form is not valid"
        redirect Dashboard::Show
      end
    end
  end
end
