class Admin::Users::Index < AdminAction
  get "/admin/users" do
    pages, users = paginate(UserQuery.new.preload_questions.preload_answers.id.asc_order, per_page: 30)
    html Admin::Users::IndexPage, users: users, pages: pages
  end
end
