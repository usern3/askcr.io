class Admin::Answers::Index < AdminAction
  get "/admin/answers" do
    pages, query = paginate(AnswerQuery.new.preload_question(QuestionQuery.new), per_page: 35)
    html IndexPage, answers: query, pages: pages
  end
end
