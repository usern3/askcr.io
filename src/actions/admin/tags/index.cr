class Admin::Tags::Index < AdminAction
  get "/admin/tags" do
    pages, tags = paginate(TagQuery.new.id.asc_order, per_page: 30)
    html Admin::Tags::IndexPage, tags: tags, pages: pages
  end
end
