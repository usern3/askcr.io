class Admin::Tags::Edit < BrowserAction
  route do
    tag = TagQuery.find(tag_id)
    html EditPage,
      operation: SaveTag.new(tag),
      tag: tag
  end
end
