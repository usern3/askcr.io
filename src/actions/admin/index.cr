class Admin::Index < AdminAction
  route do
    pages, latest_questions = paginate(QuestionQuery.new.created_at.desc_order.preload_author.preload_tags.preload_answers, per_page: 12)
    popular_tags = TagQuery.new.question_count.desc_order.limit(5)
    html IndexPage, latest_questions: latest_questions, popular_tags: popular_tags, pages: pages
  end
end
