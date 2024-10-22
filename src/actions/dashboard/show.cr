class Dashboard::Show < BrowserAction
  get "/dashboard" do
    my_pages, my_questions = paginate(QuestionQuery.new.author_id(current_user.id).created_at.desc_order, per_page: 5)
    latest_questions = QuestionQuery.new.author_id.not.eq(current_user.id).created_at.desc_order.limit(3).preload_tags
    popular_tags = TagQuery.new.question_count.desc_order.limit(5)

    html ShowPage, latest_questions: latest_questions, my_questions: my_questions, my_pages: my_pages, popular_tags: popular_tags
  end
end
