class Questions::ShowPage < MainLayout
  needs question : Question
  needs answers : AnswerQuery
  needs operation : SaveAnswer
  needs pages : Lucky::Paginator
  quick_def page_title, question.title

  def content
    div class: "container mx-auto mt-4 min-h-screen px-6" do
      div class: "w-full max-w-2xl mx-auto" do
        div class: "grid grid-flow-row auto-rows-max gap-4" do
          div class: "grid grid-cols-8" do
            div class: "col-span-8 align-baseline items-end text-right my-2" do
              if question.author == current_user
                link to: Questions::Edit.with(question.id), class: "inline-flex items-center ml-4 py-2 px-4 mt-1 bg-gray-700 text-white rounded hover:bg-gray-600 focus:outline-none", type: "button" do
                  tag "svg", class: "inline mr-1 h-5 w-5", fill: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                    tag "path", d: "M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z"
                    tag "path", clip_rule: "evenodd", d: "M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z", fill_rule: "evenodd"
                  end
                  text "Edit"
                end
              end
              link to: Questions::Answers::New.with(question.id), class: "inline-flex items-center py-2 px-4 mt-1 ml-4 bg-gray-700 text-white rounded hover:bg-gray-600 focus:outline-none", type: "button" do
                tag "svg", class: "inline mr-1 h-5 w-5", fill: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", clip_rule: "evenodd", d: "M7.707 3.293a1 1 0 010 1.414L5.414 7H11a7 7 0 017 7v2a1 1 0 11-2 0v-2a5 5 0 00-5-5H5.414l2.293 2.293a1 1 0 11-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z", fill_rule: "evenodd"
                end
                text "Answer This!"
              end
            end
          end
          render_question
          render_quick_reply
          render_answers
          if answers.size >= 1
            mount Shared::PaginationLinks, pages: pages, page_type: "answers"
          end
        end
      end
    end
  end

  def render_question
    div do
      div class: "max-w-2xl bg-white dark:bg-gray-800 rounded-lg shadow-md" do
        div class: "flex justify-between items-center px-8 py-4" do
          mount Shared::TagSpan, question: question, separated: true
        end
        div class: "mt-2 px-8" do
          link to: Questions::Show.with(question.id), class: "text-2xl text-gray-700 dark:text-white font-bold hover:text-gray-600 dark:hover:text-gray-200 hover:underline" do
            text question.title
          end
          para do
            small "Asked on #{question.created_at.to_s("%b %-d, %Y")} by #{question.author.username}."
          end
          raw(question.parsed_body)
        end
        div class: "w-100 bg-gray-100 rounded justify-between items-center mt-4" do
          div class: "flex justify-between items-center mt-4 px-8 py-4" do
            para "#{answers.size} Replies", class: "text-gray-600 dark:text-gray-400"
            div class: "flex items-center" do
              img alt: "avatar", class: "mx-4 w-10 h-10 object-cover rounded-full hidden sm:block", src: "https://images.unsplash.com/photo-1502980426475-b83966705988?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=40&q=80"
              a question.author.username, class: "text-gray-700 dark:text-gray-200 font-bold cursor-pointer"
            end
          end
        end
      end
    end
  end

  def render_quick_reply
    div do
      div class: "max-w-2xl bg-white dark:bg-gray-800 rounded-lg shadow-md" do
        div class: "mt-2 px-8 py-4" do
          form_for Questions::Answers::Create.with(question_id: question.id), class: "mt-2 text-gray-600 dark:text-gray-300" do
            div do
              mount Shared::Field, operation.body, label_text: "Quick Reply", &.textarea(rows: "10")
            end
            div class: "place-self-center text-center mt-4" do
              submit "Post", data_disable_with: "Posting...", class: "py-2 px-4 bg-gray-700 text-white font-medium rounded hover:bg-green-500 hover:text-green-100 focus:outline-none place-self-center"
            end
          end
        end
        div class: "w-100 bg-gray-100 rounded justify-between items-center mt-4" do
          div class: "flex justify-between items-center mt-4 px-8 py-4" do
            para class: "font-bold" do
              small ""
            end
            div class: "flex items-center" do
              if !current_user.profile_picture_path.nil?
                img alt: "avatar", class: "mx-4 w-10 h-10 object-cover rounded-full hidden sm:block", src: current_user.profile_picture_path.not_nil!
              else
                img alt: "avatar", class: "mx-4 w-10 h-10 object-cover rounded-full hidden sm:block", src: "https://images.unsplash.com/photo-1502980426475-b83966705988?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=40&q=80"
              end
              a current_user.username, class: "text-gray-700 dark:text-gray-200 font-bold cursor-pointer"
            end
          end
        end
      end
    end
  end

  def render_answers
    answers.each do |answer|
      div do
        div class: "max-w-2xl bg-white dark:bg-gray-800 rounded-lg shadow-md" do
          div class: "mt-2 px-8 py-4" do
            raw(answer.parsed_body)
          end
          div class: "w-100 bg-gray-100 rounded justify-between items-center mt-4" do
            div class: "flex justify-between items-center mt-4 px-8 py-4" do
              para class: "font-bold" do
                small "Answered on #{answer.created_at.to_s("%b %-d, %Y")} by #{question.author.username}."
                if current_user == answer.author
                  link "Edit", to: Questions::Answers::Edit.with(question.id, answer.id)
                end
              end
              div class: "flex items-center" do
                img alt: "avatar", class: "mx-4 w-10 h-10 object-cover rounded-full hidden sm:block", src: "https://images.unsplash.com/photo-1502980426475-b83966705988?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=40&q=80"
                a answer.author.username, class: "text-gray-700 dark:text-gray-200 font-bold cursor-pointer"
              end
            end
          end
        end
      end
    end
  end
end
