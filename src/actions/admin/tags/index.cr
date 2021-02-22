class Admin::Tags::Index < BrowserAction
  get "/admin/tags" do
    tags = TagQuery.new
    html IndexPage, tags: tags
  end
end
