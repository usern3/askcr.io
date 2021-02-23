class Tags::Delete < BrowserAction
  delete "/tags/:tag_slug" do
    tag = TagQuery.new.slug(tag_slug).first
    name = tag.name
    tag.delete
    flash.success = "Succesfully deleted the tag \"#{name}.\""
    redirect Tags::Index
  end
end
