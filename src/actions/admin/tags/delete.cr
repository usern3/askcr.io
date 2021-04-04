class Admin::Tags::Delete < AdminAction
  delete "/admin/tags/:tag_id" do
    tag = TagQuery.find(tag_id)
    name = tag.name
    tag.delete
    flash.success = "Succesfully deleted the tag \"#{name}.\""
    redirect Admin::Tags::Index
  end
end
