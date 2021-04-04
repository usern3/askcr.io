class Tags::Show < BrowserAction
  get "/tags/:tag_slug" do
    tags = TagQuery.new.question_count.desc_order(:nulls_last)
    tag = TagQuery.new.preload_questions(QuestionQuery.new).slug(tag_slug).first
    pages, questions = paginate_array(tag.questions, per_page: 15)
    html ShowPage, tag: tag, tags: tags, questions: questions, pages: pages
  end
end
