class Admin::Users::EditPage < AdminLayout
  include FormattingHelpers
  needs operation : SaveUser
  needs user : User
  quick_def page_title, "Editing @#{user.username}'s profile."

  def content
    render_sign_up_form(@operation)
  end

  def content
    div class: "container mx-auto mt-2 min-h-screen" do
      div class: "w-full max-w-6xl mx-auto" do
        div class: "grid gap-2 sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-3" do
          div class: "sm:col-span-1 md:col-span-3 align-baseline" do
            h1 "Editing user: #{user.username}(#{user.email})", class: "text-2xl text-gray-800 font-bold align-baseline"
          end
          render_user_questions
          user_details_card(@operation)
        end
      end
    end
  end

  private def render_user_questions
    div class: "md:col-span-2" do
      div class: "px-4" do
        div class: "my-2" do
          h2 "Latest Questions Asked", class: "text-xl text-gray-800 font-bold align-baseline"
        end
        user.questions.each do |question|
          div class: "px-4 py-3 mb-4 bg-white dark:bg-gray-800 h-full rounded-lg shadow-md" do
            div class: "flex justify-between items-center" do
              mount ::Shared::TagSpan, question: question, separated: true
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
  end

  private def user_details_card(op)
    div class: "sm:col-span-1" do
      div class: "my-2" do
        h2 "User Details", class: "text-xl text-gray-800 font-bold align-baseline"
      end
      div class: "mx-auto px-4 py-3 bg-white dark:bg-gray-800 shadow-md rounded-md" do
        div class: "mt-2" do
          div class: "grid grid-flow-row auto-rows-max gap-4" do
            form_for Admin::Users::Update.with(user.id), multipart: true do
              div class: "grid grid-cols-1 sm:grid-cols-1 gap-6 mt-4" do
                div do
                  mount ::Shared::Field, attribute: op.username, &.text_input(autofocus: "true", append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring", attrs: [:disabled])
                end
                div do
                  mount ::Shared::Field, attribute: op.email, &.email_input(autofocus: "true", append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  mount ::Shared::Field, op.role do |input_html|
                    input_html.select_input(required: true, replace_class: "form-select block w-full pl-3 pr-10 py-2 text-base leading-6 border rounded border-gray-300 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 sm:text-sm sm:leading-5") do
                      options_for_select op.role, User::ROLES
                    end
                  end
                end
                div do
                  div class: "h-20 w-20 mb-4" do
                    if !user.profile_picture_path.nil?
                      img alt: "avatar", class: "h-full w-full object-cover", src: current_user.profile_picture_path.not_nil!
                    else
                      img alt: "avatar", class: "h-full w-full object-cover", src: "https://lh3.googleusercontent.com/a-/AOh14Gi0DgItGDTATTFV6lPiVrqtja6RZ_qrY91zg42o-g"
                    end
                  end
                  mount ::Shared::Field, op.profile_picture, label_text: "Avatar", &.file_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
              end
              div class: "flex justify-end mt-6" do
                submit "Update", class: "bg-gray-700 text-white py-2 px-4 rounded hover:bg-gray-500 hover:text-white focus:outline-none focus:bg-gray-500 focus:text-white"
              end
            end
          end
        end
      end
    end
  end
end
