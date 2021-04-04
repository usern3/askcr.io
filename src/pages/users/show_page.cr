class Users::ShowPage < MainLayout
  needs user : User
  needs answers : AnswerQuery
  needs pages : Lucky::Paginator
  quick_def page_title, "#{user.username}"

  def content
    div class: "container mx-auto mt-4 min-h-screen px-6" do
      div class: "w-full max-w-2xl mx-auto" do
        div class: "grid grid-flow-row auto-rows-max gap-4" do
          div class: "grid grid-cols-6" do
            div class: "col-span-2 align-baseline" do
              h1 "Welcome to #{user.username}'s Profile", class: "text-2xl text-gray-800 font-bold align-baseline mt-2"
            end
          end
        end
      end
    end
  end
end
