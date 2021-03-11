<<<<<<< HEAD
class Admin::Questions::Answers::Create < QuestionAction
=======
class Admin::Answers::Create < AdminAction
>>>>>>> 906ca1639dc65a14a90cb9021e764fab39f4e13b
  post "/admin/questions/:question_id/answers" do
    question = QuestionQuery.find(question_id)
    SaveAnswer.create(params, question_id: question.id, author_id: current_user.id, solution: false) do |operation, answer|
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
