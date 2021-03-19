abstract class HomeLayout
  include Lucky::HTMLPage
  needs current_user : User?

  abstract def content
  abstract def page_title

  def page_title
    "Welcome to AskCryst.al!"
  end

  def render
    html_doctype

    html lang: "en" do
      mount Shared::LayoutHead, page_title: page_title, context: context
      body do
        content
        footer
      end
    end
  end
end
