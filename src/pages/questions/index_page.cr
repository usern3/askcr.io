class Questions::IndexPage < MainLayout
  needs questions : QuestionQuery
  needs pages : Lucky::Paginator
  quick_def page_title, "All Questions"

  def content
    div class: "container mx-auto mt-4 min-h-screen px-6" do 
      div class: "w-full max-w-2xl mx-auto" do
        div class: "grid grid-flow-row auto-rows-max gap-4" do
          div class: "grid grid-cols-8" do
            div class: "col-span-4 align-baseline" do 
              h1 "Latest Questions", class: "text-2xl text-gray-800 font-bold align-baseline mt-2"
              small "Page #{pages.page}"
            end
            div class: "col-span-4 align-baseline" do
              link to: Questions::New, class: "inline-flex items-center py-2 px-4 mt-4 bg-gray-700 text-white rounded hover:bg-gray-600 focus:outline-none float-right", type: "button" do 
                tag "svg", class: "inline mr-2 h-5 w-5", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", d: "M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
                text "New Question"
              end
            end
          end
            render_questions
            mount Shared::PaginationLinks, pages: pages, page_type: "questions"
        end
      end
    end
  end

  def render_questions
    questions.each do |question|
      div do
        div class: "max-w-2xl px-8 py-4 bg-white dark:bg-gray-800 rounded-lg shadow-md" do
          div class: "flex justify-between items-center" do
            span question.created_at.to_s("%b %-d, %Y"), class: "font-light text-gray-600 dark:text-gray-400 text-sm"
            mount Shared::TagSpan, question: question, separated: false
          end
          div class: "mt-2" do
            link question.title, to: Questions::Show.with(question.id), class: "text-2xl text-gray-700 dark:text-white font-bold hover:text-gray-600 dark:hover:text-gray-200 hover:underline"
            para question.body[0, 200], class: "mt-2 text-gray-600 dark:text-gray-300"
          end
          div class: "flex justify-between items-center mt-4" do
            link pluralize_reply(question.answers.size), to: Questions::Show.with(question.id), class: "text-blue-600 dark:text-blue-400 hover:underline"
            div class: "flex items-center" do
              if !question.author.profile_picture_path.nil?
                img alt: "avatar", class: "mx-4 w-10 h-10 object-cover rounded-full hidden sm:block", src: question.author.profile_picture_path.not_nil!
              else
                img alt: "avatar", class: "mx-4 w-10 h-10 object-cover rounded-full hidden sm:block", src: ""
              end
              a question.author.username, class: "text-gray-700 dark:text-gray-200 font-bold cursor-pointer"
            end
          end
        end
      end
    end
  end
  
  def pluralize_reply(size)
    if size > 1 || size == 0
      "#{size} replies"
    else
      "1 reply"
    end
  end
end
