class Tags::EditPage < MainLayout
  needs operation : SaveTag
  needs tag : Tag
  quick_def page_title, "Edit Tag with id: #{tag.id}"

  def content
    link "Back to all Tags", Tags::Index
    h1 "Edit Tag with id: #{tag.id}"
    render_tag_form(operation)
  end

  def render_tag_form(op)
    form_for Tags::Update.with(tag.id) do
      # Edit fields in src/components/tags/form_fields.cr
      mount Tags::FormFields, op

      submit "Update", data_disable_with: "Updating..."
    end
  end
end
