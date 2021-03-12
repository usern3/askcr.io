class Users::EditPage < AdminLayout
  include FormattingHelpers
  needs operation : SaveUser
  quick_def page_title, "Editing @#{current_user.username}'s profile."

  def content
    div class: "container mx-auto mt-2 min-h-screen" do
      div class: "w-full max-w-6xl mx-auto" do
        div class: "grid gap-2 sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-3" do
          div class: "sm:col-span-1 md:col-span-3 align-baseline" do
            h1 "Editing #{current_user.email}", class: "text-2xl text-gray-800 font-bold align-baseline"
          end
          text "Text"
        end
      end
    end
  end
end
 