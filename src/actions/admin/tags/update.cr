class Admin::Tags::Update < BrowserAction
  route do
    tag = TagQuery.find(tag_id)
    SaveTag.update(tag, params) do |operation, tag|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Admin::Tags::Index
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, tag: tag
      end
    end
  end
end
