class Tags::Update < BrowserAction
  put "/tags/:tag_slug" do
    tag = TagQuery.new.slug(tag_slug).first
    SaveTag.update(tag, params) do |operation, tag|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(tag.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, tag: tag
      end
    end
  end
end
