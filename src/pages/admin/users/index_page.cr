class Admin::Users::IndexPage < AdminLayout
  include FormattingHelpers
  needs users : UserQuery
  needs pages : Lucky::Paginator
  quick_def page_title, "All Users"

  def content
    div class: "container mx-auto mt-2 min-h-screen" do
      div class: "w-full max-w-6xl mx-auto" do
        div class: "grid gap-4 sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-3" do
          div class: "sm:col-span-1 md:col-span-3 align-baseline align-middle justify-between items-center" do
            div do
              h1 "All Questions", class: "text-2xl text-gray-800 font-bold align-baseline"
              small "A list of all questions registered in the application."
            end
            div do
              mount ::Shared::BackButton
            end
          end
          users_list
        end
      end
    end
  end

  private def users_list
    div class: "md:col-span-3" do
      div class: "py-4 mb-4 bg-white dark:bg-gray-800 rounded-lg shadow-md" do
        div class: "grid grid-cols-16 border-b-2 border-gray-300" do
          div class: "col-span-1 mb-3 text-center" do
            span "ID", class: "font-bold text-gray-800"
          end
          div class: "col-span-3 mb-3" do
            span "Email", class: "font-bold text-gray-800"
          end
          div class: "col-span-2 mb-3" do
            span "Username", class: "font-bold text-gray-800"
          end
          div class: "col-span-1 mb-3" do
            span "Role", class: "font-bold text-gray-800"
          end
          div class: "has-tooltip inline col-span-2 mb-3 text-center" do
            span "Questions Asked", class: "font-bold text-gray-800"
          end
          div class: "col-span-3 mb-3 text-center" do
            span "Answers/Solutions", class: "font-bold text-gray-800"
          end
          div class: "col-span-3 text-center mb-3 text-center" do
            span "Actions", class: "font-bold text-gray-800"
          end
        end
        users.each_with_index do |user, index|
          div class: index % 2 == 0 ? "grid grid-cols-16 py-2 bg-gray-50 border-b border-gray-200 hover:bg-gray-100" : "grid grid-cols-16 py-2 bg-white border-b border-gray-200 hover:bg-gray-100" do
            div class: "col-span-1 mb-2 self-center text-center" do
              span user.id, class: "text-gray-800"
            end
            div class: "col-span-3 mb-2 self-center" do
              span user.email, class: "text-gray-800"
            end
            div class: "col-span-2 mb-2 self-center" do
              span user.username, class: "text-gray-800"
            end
            div class: "col-span-1 mb-2 self-center" do
              if user.role.superadmin?
                span "Superadmin", class: "text-indigo-600"
              elsif user.role.admin?
                span "Admin", class: "text-red-500"
              elsif user.role.moderator?
                span "Moderator", class: "text-green-600"
              elsif user.role.member?
                span "Member", class: "text-gray-800"
              elsif user.role.banned?
                span "Banned", class: "text-red-500"
              end
            end
            div class: "col-span-2 text-center mb-2 self-center text-center" do
              span "#{user.questions.size}", class: "text-gray-800 self-center"
            end
            div class: "col-span-3 text-center mb-2 self-center text-center" do
              solutions = 0
              user.answers.each do |answer|
                solutions += 1 if answer.solution
              end
              span "#{user.answers.size}/#{solutions}", class: "text-gray-800 self-center"
            end
            div class: "col-span-3 text-center items-center mb-2 self-center text-center" do
              link to: Admin::Users::Edit.with(user.id), class: "has-tooltip inline-flex  py-2 px-4 bg-transparent text-gray-800 rounded hover:bg-green-100 focus:outline-none", type: "button" do
                span "Edit this user.", class: "tooltip rounded shadow-lg px-2 py-1 bg-gray-800 text-gray-100 -mt-10"
                tag "svg", class: "inline h-5 w-5 text-gray-700", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", d: "M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
              end
              link to: Admin::Users::Delete.with(user.id), class: "has-tooltip inline-flex py-2 px-4 bg-transparent text-red-600 rounded hover:bg-red-200 focus:outline-none", type: "button" do
                span "Delete this user.", class: "tooltip rounded shadow-lg px-2 py-1 bg-gray-800 text-gray-100 -mt-8"
                tag "svg", class: "inline h-5 w-5 text-red-500", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", d: "M15 12H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
              end
            end
          end
        end
      end
      mount ::Shared::PaginationLinks, pages: pages, page_type: "users"
    end
  end
end
