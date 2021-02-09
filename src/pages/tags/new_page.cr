class Tags::NewPage < MainLayout
  needs operation : SaveTag
  quick_def page_title, "New Tag"

  def content
    h1 "New Tag"
    render_tag_form(operation)
  end

  def render_tag_form(op)
    form_for Tags::Create do
      # Edit fields in src/components/tags/form_fields.cr
      mount Tags::FormFields, op

      submit "Save", data_disable_with: "Saving..."
    end
  end
end
