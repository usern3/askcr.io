class Admin::IndexPage < AdminLayout
  include FormattingHelpers
  needs questions : QuestionQuery
  needs popular_tags : TagQuery
  needs pages : Lucky::Paginator
  needs users : UserQuery
  needs answers : AnswerQuery
  needs tags : TagQuery
  quick_def page_title, "Admin Dashboard"

  def content
    div class: "container mx-auto mt-2 min-h-screen px-6" do
      div class: "w-full max-w-6xl mx-auto" do
        div class: "grid gap-4 grid-cols-6" do
          div class: "col-span-1 mt-2" do
            h1 "Stats", class: "text-2xl text-gray-800 font-bold align-baseline mt-2"
            small "AskCryst.al. quick stats."
          end
          div class: "col-span-5 mt-2" do
            h1 "Latest Questions", class: "text-2xl text-gray-800 font-bold align-baseline mt-2"
            small "Latest questions asked by users."
          end
          div class: "sm:col-span-1" do
            user_stats
            question_stats
            answer_stats
            tag_stats
          end
          div class: "md:col-span-5" do
            latest_questions_list
          end
        end
      end
    end
  end

  private def latest_questions_list
    questions.each do |question|
      div class: "px-4 py-2 mb-4 bg-white dark:bg-gray-800 rounded-lg shadow-md" do
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

  private def user_stats
    mount Admin::Shared::OneSpanBlock, title: "User Stats" do
      div class: "mt-2" do
        tag "canvas", id: "users-chart", width: "300", height: "300", total_users: users.size - users.created_at.lt(1.week.ago).size, new_users: users.created_at.lt(1.week.ago).size do
        end
      end
      div class: "mt-2" do
        para class: "text-gray-600 dark:text-gray-300 text-sm mt-1" do
          span "Total Users: ", class: "font-bold text-gray-600"
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

  private def question_stats
    mount Admin::Shared::OneSpanBlock, title: "Question Stats" do
      div class: "mt-2" do
        tag "canvas", id: "questions-chart", width: "300", height: "300", total_questions: questions.size - questions.created_at.lt(1.week.ago).size, new_questions: questions.created_at.lt(1.week.ago).size do
        end
      end
      div class: "mt-2" do
        para class: "text-gray-600 dark:text-gray-300 text-sm mt-1" do
          span "Total Questions: ", class: "font-bold text-gray-600"
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

  private def answer_stats
    mount Admin::Shared::OneSpanBlock, title: "Answer Stats" do
      div class: "mt-2" do
        tag "canvas", id: "answers-chart", width: "300", height: "300", total_answers: answers.size - answers.created_at.lt(1.week.ago).size, new_answers: answers.created_at.lt(1.week.ago).size do
        end
      end
      div class: "mt-2" do
        para class: "text-gray-600 dark:text-gray-300 text-sm mt-1" do
          span "Total Answers: ", class: "font-bold text-gray-600"
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

  private def tag_stats
    mount Admin::Shared::OneSpanBlock, title: "Tag Stats" do
      div class: "mt-2" do
        tag "canvas", id: "tags-chart", width: "300", height: "300", total_tags: tags.size - tags.created_at.lt(1.week.ago).size, new_tags: tags.created_at.lt(1.week.ago).size do
        end
      end
      div class: "mt-2" do
        para class: "text-gray-600 dark:text-gray-300 text-sm mt-1" do
          span "Total Tags: ", class: "font-bold text-gray-600"
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
