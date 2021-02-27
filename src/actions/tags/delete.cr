class Tags::Delete < BrowserAction
  delete "/tags/:tag_id" do
    tag = TagQuery.find(tag_id)
    name = tag.name
    tag.delete
    flash.success = "Succesfully deleted the tag \"#{name}.\""
    redirect Tags::Index
  end
end
