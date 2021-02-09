class Tags::Index < BrowserAction
  route do
    html IndexPage, tags: TagQuery.new
  end
end
