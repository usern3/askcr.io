class Questions::ShowPage < MainLayout
  include TextHelpers
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
            a "#{answers.size} Replies #{question.solution_id.nil? ? "" : "- Solved"}", href: "#answers", class: "text-gray-600 dark:text-gray-400"
            if !question.solution_id.nil?
              a href: "#answer-#{question.solution_id}", class: "inline-flex items-center ml-4 py-2 px-4 mt-1 bg-gray-200 text-gray-800 border-gray-500 hover:text-white rounded hover:bg-gray-400 focus:outline-none", type: "button" do
                tag "svg", class: "inline mr-1 h-5 w-5", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", d: "M19 13l-7 7-7-7m14-8l-7 7-7-7", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
                text "Jump to solution"
              end
            end
            div class: "flex items-center" do
              if !question.author.profile_picture_path.nil?
                img alt: "avatar", class: "mx-4 w-10 h-10 object-cover rounded-full hidden sm:block", src: "/uploads/#{question.author.profile_picture_path.not_nil!}"
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

  def render_quick_reply
    div do
      div class: "max-w-2xl bg-white dark:bg-gray-800 rounded-lg shadow-md" do
        div class: "mt-2 px-8 py-4" do
          form_for Questions::Answers::Create.with(question_id: question.id), class: "mt-2 text-gray-600 dark:text-gray-300" do
            div do
              label_for operation.body, "Quick Reply", class: "block text-lg font-bold leading-5 text-gray-700"
              small "Markdown syntax is supported.", class: "mb-4"
              mount Shared::LabellessField, operation.body, label_text: "Quick Reply", &.textarea(rows: "10")
            end
            div class: "place-self-center text-center mt-4" do
              submit "Reply", data_disable_with: "Replying...", class: "py-2 px-4 bg-gray-700 text-white font-medium rounded hover:bg-green-500 hover:text-green-100 focus:outline-none place-self-center"
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
                img alt: "avatar", class: "mx-4 w-10 h-10 object-cover rounded-full hidden sm:block", src: "/uploads/#{current_user.profile_picture_path.not_nil!}"
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
    div id: "answers" do
      div class: "align-baseline" do
        h1 "Responses", class: "text-2xl text-gray-800 font-bold align-baseline mt-2"
      end
      answers.each do |answer|
        div id: "answer-#{answer.id}", class: "max-w-2xl bg-white dark:bg-gray-800 rounded-lg shadow-md" do
          div class: "mt-2 px-8 py-4" do
            div class: "float-right" do
              if question.author.id == current_user.id && question.solution_id.nil?
                link to: Questions::Answers::MarkSolution.with(question.id, answer.id), class: "inline-flex items-center ml-4 py-2 px-4 mt-1 bg-green-600 text-white rounded hover:bg-green-500 focus:outline-none", type: "button" do
                  tag "svg", class: "inline mr-1 h-5 w-5", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                    tag "path", d: "M5 13l4 4L19 7", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                  end
                  text "Mark Solution"
                end
              end
              if question.solution_id == answer.id && answer.solution
                a href: "#answer-#{question.solution_id}", class: "has-tooltip inline-flex items-center ml-4 py-2 px-4 mt-1 bg-gray-100 text-gray-800 rounded hover:bg-green-100 focus:outline-none", type: "button" do
                  span "This is the solution chosen by the question author.", class: "tooltip rounded shadow-lg px-2 py-1 bg-gray-800 text-gray-100 -mt-20"
                  tag "svg", class: "inline h-5 w-5 text-green-500", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                    tag "path", d: "M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                  end
                end
                if current_user.id == question.author.id
                  link to: Questions::Answers::UnmarkSolution.with(question.id, answer.id), class: "has-tooltip inline-flex items-center ml-4 py-2 px-4 mt-1 bg-gray-100 text-red-600 rounded hover:bg-red-200 focus:outline-none", type: "button" do
                    span "Unmark this answer as the solution.", class: "tooltip rounded shadow-lg px-2 py-1 bg-gray-800 text-gray-100 -mt-20"
                    tag "svg", class: "inline h-5 w-5 text-red-500", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                      tag "path", d: "M15 12H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                    end
                  end
                end
              end
            end
            raw(answer.parsed_body)
          end
          if answer.solution
            answer_footer_class = "w-100 bg-green-50 rounded justify-between items-center mt-4"
          else
            answer_footer_class = "w-100 bg-gray-50 rounded justify-between items-center mt-4"
          end
          div class: answer_footer_class do
            div class: "flex justify-between items-center mt-4 px-8 py-4" do
              para class: "font-bold" do
                small "Answered on #{answer.created_at.to_s("%b %-d, %Y")} by #{question.author.username}"
                br
                if answer.solution
                  small "Marked as solution!", class: "font-medium mr-4"
                end
                if current_user == answer.author
                  link "Edit", to: Questions::Answers::Edit.with(question.id, answer.id), class: "text-sm"
                end
              end
              div class: "flex items-center" do
                if image_path = user_profile_image_link(answer.author)
                  img alt: answer.author.username, class: "h-12 w-12 rounded-full", src: image_path
                else
                  img alt: "avatar", class: "h-full w-full object-cover", src: "https://lh3.googleusercontent.com/a-/AOh14Gi0DgItGDTATTFV6lPiVrqtja6RZ_qrY91zg42o-g"
                end
                a answer.author.username, class: "text-gray-700 dark:text-gray-200 font-bold cursor-pointer"
              end
            end
          end
        end
      end
    end
  end
end
