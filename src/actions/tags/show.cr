class Tags::Show < BrowserAction
  route do
    html ShowPage, tag: TagQuery.find(tag_id)
  end
end
