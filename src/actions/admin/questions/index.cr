class Admin::Questions::Index < AdminAction
  get "/admin/questions" do
    pages, query = paginate(QuestionQuery.new.created_at.desc_order.preload_author.preload_tags.preload_answers, per_page: 12)
    html IndexPage, questions: query, pages: pages
  end
end
