class Tags::IndexPage < MainLayout
  needs tags : TagQuery
  quick_def page_title, "All Tags"

  def content
    h1 "All Tags"
    link "New Tag", to: Tags::New
    render_tags
  end

  def render_tags
    ul do
      tags.each do |tag|
        li do
          link tag.name, Tags::Show.with(tag)
        end
      end
    end
  end
end
