class Admin::Tags::Edit < AdminAction
  route do
    tag = TagQuery.find(tag_id)
    html EditPage,
      operation: SaveTag.new(tag),
      tag: tag
  end
end
