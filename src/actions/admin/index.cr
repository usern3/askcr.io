class Admin::Index < AdminAction
  route do
    pages, questions = paginate(QuestionQuery.new.created_at.desc_order.preload_author.preload_tags.preload_answers, per_page: 12)
    popular_tags = TagQuery.new.question_count.desc_order.limit(5)
    users = UserQuery.new
    answers = AnswerQuery.new
    tags = TagQuery.new
    html IndexPage, questions: questions, popular_tags: popular_tags, answers: answers, users: users, tags: tags, pages: pages
  end
end
