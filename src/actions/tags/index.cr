class Tags::Index < BrowserAction
  route do
    tags = TagQuery.new.question_count.desc_order
    pages, questions = paginate(QuestionQuery.new, per_page: 15)
    html IndexPage, tags: tags, questions: questions, pages: pages
  end
end
