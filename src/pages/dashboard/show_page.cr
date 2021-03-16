class Dashboard::ShowPage < MainLayout
  include FormattingHelpers
  needs latest_questions : QuestionQuery
  needs popular_tags : TagQuery
  needs my_questions : QuestionQuery
  needs my_pages : Lucky::Paginator
  quick_def page_title, "Dashboard"

  def content
    div class: "container mx-auto mt-2 min-h-screen px-6" do
      div class: "w-full max-w-6xl mx-auto" do
        div class: "grid gap-2 sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-3" do
          div class: "sm:col-span-1 md:col-span-3 align-baseline" do
            h1 "Latest Unsolved Asks", class: "text-2xl text-gray-800 font-bold align-baseline"
            small "Can you help them?"
          end
          latest_asks
          div class: "sm:col-span-1 md:col-span-3 lg:col-span-3 align-baseline mt-2" do
            h1 "My Latest Asks", class: "text-2xl text-gray-800 font-bold align-baseline mt-2"
            small "Questions you've recently asked."
          end
          my_latest_asks
          right_sidebar
        end
      end
    end
  end

  private def my_latest_asks
    div class: "md:col-span-2" do
      my_questions.each do |question|
        div class: "px-8 py-4 mb-4 bg-white dark:bg-gray-800 rounded-lg shadow-md" do
          div class: "flex justify-between items-center" do
            span question.created_at.to_s("%b %-d, %Y"), class: "font-light text-gray-600 dark:text-gray-400 text-sm"
            mount Shared::TagSpan, question: question, separated: false
          end
          div class: "mt-2" do
            link question.title, to: Questions::Show.with(question.id), class: "text-2xl text-gray-700 dark:text-white font-bold hover:text-gray-600 dark:hover:text-gray-200 hover:underline"
            para question.body[0..200], class: "mt-2 text-gray-600 dark:text-gray-300"
          end
          div class: "flex justify-between items-center mt-4" do
            link "Read more", to: Questions::Show.with(question.id), class: "text-blue-600 dark:text-blue-400 hover:underline"
            div class: "flex items-center" do
              if !current_user.profile_picture_path.nil?
                img alt: "avatar", class: "mx-4 w-10 h-10 object-cover rounded-full hidden sm:block", src: "/uploads/#{current_user.profile_picture_path.not_nil!}"
              end
              a current_user.username, class: "text-gray-700 dark:text-gray-200 font-bold cursor-pointer"
            end
          end
        end
      end
      mount Shared::PaginationLinks, pages: my_pages, page_type: "questions"
    end
  end

  private def latest_asks
    latest_questions.each do |question|
      div class: "col-span-1" do
        div class: "px-4 py-3 bg-white dark:bg-gray-800 shadow-md rounded-md h-full" do
          div class: "flex justify-between items-center" do
            mount Shared::TagSpan, question: question, separated: true
          end
          div class: "mt-2" do
            link minify_title(question.title, 70), to: Questions::Show.with(question.id), class: "text-lg font-semibold text-gray-800 dark:text-white"
            para question.body[0, 180], class: "text-gray-600 dark:text-gray-300 text-sm mt-1"
          end
          div do
            div class: "flex items-center justify-between mt-4 content-end" do
              span do
                link "Read more", to: Questions::Show.with(question.id), class: "text-blue-600 dark:text-blue-400 hover:underline"
              end
              span class: "font-light text-gray-600 dark:text-gray-400 text-sm" do
                text question.created_at.to_s("%b %-d, %Y")
              end
            end
          end
        end
      end
    end
  end

  private def right_sidebar
    div class: "sm:col-span-1" do
      div class: "mx-auto px-4 py-3 bg-white dark:bg-gray-800 shadow-md rounded-md" do
        div class: "flex justify-between items-center" do
          h2 "Top 5 Tags", class: "text-lg font-semibold text-gray-800 dark:text-white"
        end
        div class: "mt-2" do
          ul class: "list-inside list-decimal" do
            popular_tags.each do |tag|
              li class: "my-1" do
                link "#{tag.name} (#{pluralize tag.question_count, "Question"})", to: Tags::Show.with(tag)
              end
            end
          end
          link "", to: Dashboard::Show, class: "text-lg font-semibold text-gray-800 dark:text-white"
          para "", class: "text-gray-600 dark:text-gray-300 text-sm mt-1"
        end
        div do
          div class: "flex items-center justify-between mt-4" do
            span do
              link "Read more", to: Dashboard::Show, class: "text-blue-600 dark:text-blue-400 hover:underline"
            end
            span class: "font-light text-gray-600 dark:text-gray-400 text-sm" do
              text "Blah"
            end
          end
        end
      end
    end
  end
end
