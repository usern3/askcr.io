class Questions::NewPage < MainLayout
  needs operation : SaveQuestion
  quick_def page_title, "New Question"

  def content
    div class: "container mx-auto mt-4 min-h-screen px-6" do 
      div class: "w-full max-w-2xl mx-auto" do
        div class: "grid grid-flow-row auto-rows-max gap-4" do
          div class: "grid grid-cols-6" do
            div class: "col-span-2 align-baseline" do 
              h1 "New Question", class: "text-2xl text-gray-800 font-bold align-baseline mt-2"
            end
            div class: "col-span-4" do
              link "Cancel", to: Questions::Index, class: "py-2 px-4 bg-gray-200 text-red-500 rounded hover:bg-red-400 focus:outline-none float-right"
            end
          end
          form_for Questions::Create do
            div do
              mount Shared::Field, operation.title, &.text_input(autofocus: "true")
            end
            div do
              mount Shared::Field, operation.body, &.textarea(rows: "10")
            end
            div do 
              mount Shared::Field, operation.tags, &.text_input
            end
            div class: "place-self-center text-center mt-4" do
              button type: "submit", data_disable_with: "Saving...", class: "inline-flex items-center py-2 px-4 bg-gray-700 text-white border-gray-800 rounded hover:bg-green-500 hover:text-green-100 focus:outline-none place-self-center" do
                tag "svg", class: "inline mr-1 h-5 w-5", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", d: "M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
                text "Ask"
              end
              link to: Questions::Index, class: "inline-flex items-center py-2 px-4 ml-4 bg-gray-700 text-white rounded hover:bg-red-500 hover:text-white focus:outline-none", type: "button" do
                tag "svg", class: "inline mr-1 h-5 w-5", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                  tag "path", d: "M6 18L18 6M6 6l12 12", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
                text "Cancel"
              end
            end
          end
        end
      end
    end
  end

  def render_question_form(op)
    form_for Questions::Create do
      div do 
        mount Questions::FormFields, op
      end
      div class: "place-self-center text-center mt-4" do
        submit "Save", data_disable_with: "Saving...", class: "py-2 px-4 bg-gray-700 text-green-300 border-gray-800 rounded hover:bg-green-400 focus:outline-none place-self-center"
      end
    end
  end
end
