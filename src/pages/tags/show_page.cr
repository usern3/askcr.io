class Tags::ShowPage < MainLayout
  needs tag : Tag
  quick_def page_title, "Tag with id: #{tag.id}"

  def content
    link "Back to all Tags", Tags::Index
    h1 "Tag with id: #{tag.id}"
    render_actions
    render_tag_fields
  end

  def render_actions
    section do
      link "Edit", Tags::Edit.with(tag.id)
      text " | "
      link "Delete",
        Tags::Delete.with(tag.id),
        data_confirm: "Are you sure?"
    end
  end

  def render_tag_fields
    ul do
      li do
        text "name: "
        strong tag.name.to_s
      end
      li do
        text "slug: "
        strong tag.slug.to_s
      end
      li do
        text "description: "
        strong tag.description.to_s
      end
    end
  end
end
