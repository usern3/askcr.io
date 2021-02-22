class Admin::Tags::IndexPage < MainLayout
  include FormattingHelpers
  needs tags : TagQuery
  #needs pages : Lucky::Paginator
  quick_def page_title, "All Tags"

  def content
    div class: "container mx-auto mt-2 min-h-screen px-6" do
      div class: "w-full max-w-6xl mx-auto" do
        div class: "grid gap-2 sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-3" do
          div class: "sm:col-span-1 md:col-span-3 align-baseline" do
            h1 "All Tags", class: "text-2xl text-gray-800 font-bold align-baseline"
          end
          tags_list
        end
      end
    end
  end

  private def tags_list
    div class: "md:col-span-2" do
      div class: "px-8 py-4 mb-4 bg-white dark:bg-gray-800 rounded-lg shadow-md" do
        div class: "grid grid-cols-16" do 
          div class: "col-span-1" do 
            span "ID", class: "font-bold text-gray-800"
          end
          div class: "col-span-2" do 
            span "Name", class: "font-bold text-gray-800"
          end
          div class: "col-span-2" do 
            span "Slug", class: "font-bold text-gray-800"
          end
          div class: "col-span-4" do
            span "Description", class: "font-bold text-gray-800"
          end
          div class: "col-span-3" do 
            span "Posts (Counted/Actual)", class: "font-bold text-gray-800"
          end
          div class: "col-span-4" do
            span "Actions", class: "font-bold text-gray-800"
          end
          tags.each do |tag|
            div class: "col-span-1" do 
              span tag.id, class: "text-gray-800"
            end
            div class: "col-span-2" do 
              span tag.name, class: "text-gray-800"
            end
            div class: "col-span-2" do 
              span tag.slug, class: "text-gray-800"
            end
            div class: "col-span-4" do
              span tag.description ? tag.description : "n/a", class: "text-gray-800"
            end
            div class: "col-span-3" do 
              span "#{tag.question_count}/#{tag.questions.size}", class: "text-gray-800"
            end
            div class: "col-span-4" do
              a class: "has-tooltip inline-flex items-center ml-4 py-2 px-4 mt-1 bg-gray-100 text-gray-800 rounded hover:bg-green-100 focus:outline-none", type: "button" do
                span "This is the solution chosen by the question author.", class: "tooltip rounded shadow-lg px-2 py-1 bg-gray-800 text-gray-100 -mt-20"
                tag "svg", class: "inline h-5 w-5 text-green-500", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", d: "M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
              end
              link to: Tags::Delete, class: "has-tooltip inline-flex items-center ml-4 py-2 px-4 mt-1 bg-gray-100 text-red-600 rounded hover:bg-red-200 focus:outline-none", type: "button" do
                span "Unmark this answer as the solution.", class: "tooltip rounded shadow-lg px-2 py-1 bg-gray-800 text-gray-100 -mt-20"
                tag "svg", class: "inline h-5 w-5 text-red-500", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", d: "M15 12H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
              end
            end
          end
        end
      end
      # mount Shared::PaginationLinks, pages: pages, page_type: "tags"
    end
  end

  private def right_sidebar
    div class: "sm:col-span-1" do
      div class: "mx-auto px-4 py-3 bg-white dark:bg-gray-800 shadow-md rounded-md" do
        div class: "flex justify-between items-center" do
          h2 "Tag List", class: "text-lg font-semibold text-gray-800 dark:text-white"
        end
        div class: "mt-2" do
          ul class: "list-inside list-decimal" do
            # tags.each do |tag|
            #   li do 
            #     link "#{tag.name} (#{pluralize("Question", tag.question_count)})", to: Tags::Show.with(tag)
            #   end
            # end
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
