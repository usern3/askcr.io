class Tags::Delete < BrowserAction
  route do
    TagQuery.find(tag_id).delete
    flash.success = "Deleted the record"
    redirect Index
  end
end
