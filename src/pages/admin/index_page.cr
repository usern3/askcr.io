class Admin::IndexPage < AdminLayout
  include FormattingHelpers
  needs questions : QuestionQuery
  needs popular_tags : TagQuery
  needs pages : Lucky::Paginator
  needs users : UserQuery
  needs answers : AnswerQuery
  needs tags : TagQuery
  quick_def page_title, "Dashboard"

  def content
    div class: "container mx-auto mt-2 min-h-screen px-6" do
      div class: "w-full max-w-6xl mx-auto" do
        div class: "grid gap-4 sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-3" do
          div class: "sm:col-span-1 md:col-span-3 lg:col-span-3 align-baseline mt-2" do
            h1 "Admin Dashboard", class: "text-2xl text-gray-800 font-bold align-baseline mt-2"
            small "Overview of the AskCryst.al application."
          end
          user_stats
          question_stats
          answer_stats
          tag_stats
          # latest_questions_list
        end
      end
    end
  end

  private def latest_questions_list
    div class: "md:col-span-2" do
      div class: "mb-2" do
        h1 "Latest Questions", class: "text-2xl text-gray-800 font-bold align-baseline"
        small "Latest questions asked by users."
      end
      questions.each do |question|
        div class: "px-8 py-4 mb-4 bg-white dark:bg-gray-800 rounded-lg shadow-md" do
          div class: "mt-2" do
            link question.title, to: Questions::Show.with(question.id), class: "text-xl text-gray-700 dark:text-white font-bold hover:text-gray-600 dark:hover:text-gray-200 hover:underline"
            link "by #{question.author.username}", to: Questions::Show.with(question.id), class: "float-right text-gray-700 dark:text-white hover:text-gray-600 dark:hover:text-gray-200 hover:underline"
          end
          div class: "flex justify-between items-center" do
            span question.created_at.to_s("%b %-d, %Y"), class: "font-light text-gray-600 dark:text-gray-400 text-sm"
            mount ::Shared::TagSpan, question: question, separated: false
          end
        end
      end
      mount ::Shared::PaginationLinks, pages: pages, page_type: "questions"
    end
  end

  private def user_stats
    div class: "sm:col-span-1" do
      div class: "mx-auto px-4 py-3 bg-white dark:bg-gray-800 shadow-md rounded-md" do
        div class: "flex justify-between items-center" do
          h2 "User Stats", class: "text-lg font-semibold text-gray-800 dark:text-white"
        end
        div class: "mt-2" do
          tag "canvas", id: "users-chart", width: "400", height: "400", total_users: users.size - users.created_at.lt(1.week.ago).size, new_users: users.created_at.lt(1.week.ago).size do
          end
        end
        div class: "mt-2" do
          para class: "text-gray-600 dark:text-gray-300 text-sm mt-1" do
            span "Total: ", class: "font-bold text-gray-600"
            text users.size
          end
          para class: "text-gray-600 dark:text-gray-300 text-sm mt-1" do
            span "New This Week: ", class: "font-bold text-gray-600"
            text users.created_at.lt(1.week.ago).size
          end
        end
        div class: "mt-2" do
          para class: "text-gray-600 dark:text-gray-300 text-sm mt-1 text-right" do
            link "View Users", to: Admin::Users::Index, class: "font-bold text-gray-600 hover:text-gray-800"
          end
        end
      end
    end
  end

  private def question_stats
    div class: "sm:col-span-1" do
      div class: "mx-auto px-4 py-3 bg-white dark:bg-gray-800 shadow-md rounded-md" do
        div class: "flex justify-between items-center" do
          h2 "Question Stats", class: "text-lg font-semibold text-gray-800 dark:text-white"
        end
        div class: "mt-2" do
          tag "canvas", id: "questions-chart", width: "400", height: "400", total_questions: questions.size - questions.created_at.lt(1.week.ago).size, new_questions: questions.created_at.lt(1.week.ago).size do
          end
        end
        div class: "mt-2" do
          para class: "text-gray-600 dark:text-gray-300 text-sm mt-1" do
            span "Total: ", class: "font-bold text-gray-600"
            text questions.size
          end
          para class: "text-gray-600 dark:text-gray-300 text-sm mt-1" do
            span "New This Week: ", class: "font-bold text-gray-600"
            text questions.created_at.lt(1.week.ago).size
          end
        end
        div class: "mt-2" do
          para class: "text-gray-600 dark:text-gray-300 text-sm mt-1 text-right" do
            link "View Questions", to: ::Questions::Index, class: "font-bold text-gray-600 hover:text-gray-800"
          end
        end
      end
    end
  end

  private def answer_stats
    div class: "sm:col-span-1" do
      div class: "mx-auto px-4 py-3 bg-white dark:bg-gray-800 shadow-md rounded-md" do
        div class: "flex justify-between items-center" do
          h2 "Answer Stats", class: "text-lg font-semibold text-gray-800 dark:text-white"
        end
        div class: "mt-2" do
          tag "canvas", id: "answers-chart", width: "400", height: "400", total_answers: answers.size - answers.created_at.lt(1.week.ago).size, new_answers: answers.created_at.lt(1.week.ago).size do
          end
        end
        div class: "mt-2" do
          para class: "text-gray-600 dark:text-gray-300 text-sm mt-1" do
            span "Total: ", class: "font-bold text-gray-600"
            text answers.size
          end
          para class: "text-gray-600 dark:text-gray-300 text-sm mt-1" do
            span "New This Week: ", class: "font-bold text-gray-600"
            text answers.created_at.lt(1.week.ago).size
          end
        end
        div class: "mt-2" do
          para class: "text-gray-600 dark:text-gray-300 text-sm mt-1 text-right" do
            link "View Answers", to: Admin::Users::Index, class: "font-bold text-gray-600 hover:text-gray-800"
          end
        end
      end
    end
  end

  private def tag_stats
    div class: "sm:col-span-1" do
      div class: "mx-auto px-4 py-3 bg-white dark:bg-gray-800 shadow-md rounded-md" do
        div class: "flex justify-between items-center" do
          h2 "Tag Stats", class: "text-lg font-semibold text-gray-800 dark:text-white"
        end
        div class: "mt-2" do
          tag "canvas", id: "tags-chart", width: "400", height: "400", total_tags: tags.size - tags.created_at.lt(1.week.ago).size, new_tags: tags.created_at.lt(1.week.ago).size do
          end
        end
        div class: "mt-2" do
          para class: "text-gray-600 dark:text-gray-300 text-sm mt-1" do
            span "Total: ", class: "font-bold text-gray-600"
            text tags.size
          end
          para class: "text-gray-600 dark:text-gray-300 text-sm mt-1" do
            span "New This Week: ", class: "font-bold text-gray-600"
            text tags.created_at.lt(1.week.ago).size
          end
        end
        div class: "mt-2" do
          para class: "text-gray-600 dark:text-gray-300 text-sm mt-1 text-right" do
            link "View Tags", to: Admin::Tags::Index, class: "font-bold text-gray-600 hover:text-gray-800"
          end
        end
      end
    end
  end
end
