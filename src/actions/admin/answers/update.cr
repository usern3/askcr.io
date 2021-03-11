<<<<<<< HEAD
class Admin::Answers::Update < BrowserAction
=======
class Admin::Questions::Answers::Update < AdminAction
>>>>>>> 906ca1639dc65a14a90cb9021e764fab39f4e13b
  post "/admin/answers/:answer_id" do
    answer = AnswerQuery.find(answer_id)
    SaveAnswer.update(answer, params) do |operation, answer|
      if operation.saved?
        flash.keep
        flash.success = "Your answer has been updated."
<<<<<<< HEAD
        redirect Questions::Show.with(question_id)
=======
        redirect Questions::Show.with(answer.question.id)
>>>>>>> 906ca1639dc65a14a90cb9021e764fab39f4e13b
      else
        flash.failure = "It looks like the form is not valid"
        redirect Dashboard::Show
      end
    end
  end
end
