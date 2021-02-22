class Tags::Show < BrowserAction
  route do
    tags = TagQuery.new.question_count.desc_order(:nulls_last)
    tag = TagQuery.new.preload_questions(QuestionQuery.new).find(tag_id)
    pages, questions = paginate_array(tag.questions, per_page: 15)
    html ShowPage, tag: tag, tags: tags, questions: questions, pages: pages
  end
end
