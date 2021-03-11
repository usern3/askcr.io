class Admin::Questions::Show < AdminAction
  get "/admin/questions/:question_id" do
    question = QuestionQuery.new.find(question_id)
    pages, answers = paginate(AnswerQuery.new.question_id(question.id).preload_author.solution.desc_order(:nulls_last), per_page: 5)
    op = SaveAnswer.new
    html ShowPage, question: question, operation: op, answers: answers, pages: pages
  end
end
