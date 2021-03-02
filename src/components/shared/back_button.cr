class Shared::BackButton < BaseComponent
  needs label_text : String = "Back"

  def render
    button href: "javascript:history.back();", class: "inline-flex items-center py-2 px-4 mt-2 bg-gray-700 text-white rounded hover:bg-gray-600 focus:outline-none float-right" do
      tag "svg", class: "inline h-5 w-5 mr-1", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
        tag "path", d: "M12.066 11.2a1 1 0 000 1.6l5.334 4A1 1 0 0019 16V8a1 1 0 00-1.6-.8l-5.333 4zM4.066 11.2a1 1 0 000 1.6l5.334 4A1 1 0 0011 16V8a1 1 0 00-1.6-.8l-5.334 4z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
      end
      text label_text
    end
  end
end