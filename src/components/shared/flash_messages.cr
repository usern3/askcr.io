class Shared::FlashMessages < BaseComponent
  needs flash : Lucky::FlashStore

  def render
    flash_index = 0
    flash.each do |flash_type, flash_message|
      color = flash_color flash_type
      flash_id = "flash-#{flash_type}-#{flash_index}"
      #div id: "flash-messages", class: "cornerbox float-right" do
      div id: "flash-messages", class: "boxmessages w-full max-w-sm" do
        div id: flash_id, class: "flex w-full max-w-sm mx-auto overflow-hidden bg-white rounded-lg shadow-md dark:bg-gray-800 mt-6" do
          div class: "flex items-center justify-center w-12 bg-#{color}-500" do
            flash_icon(flash_type)
          end
          div class: "px-4 py-2 -mx-3" do
            div class: "mx-3" do
              span flash_heading(flash_type), class: "font-semibold text-#{color}-500 dark:text-red-400"
              para flash_message, class: "text-sm text-gray-600 dark:text-gray-200"
            end
          end
          div class: "flex-grow text-right self-center" do
            button id: "close", aria_label: "Dismiss", flash_close_target: flash_id, class: "self-end rounded-md p-1 hover:bg-opacity-25 hover:bg-gray-600 focus:outline-none transition ease-in-out duration-150 mr-2" do
              tag "svg", class: "h-5 w-5", fill: "none", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                tag "path", d: "M6 18L18 6M6 6L18 18", stroke: "currentColor", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
              end
            end
          end
        end
      end
      #end
      flash_index += 1
    end
  end

  def flash_color(flash_type)
    case flash_type
    when "failure"
      "red"
    when "success"
      "green"
    when "info"
      "blue"
    else
      "blue"
    end
  end

  def flash_heading(flash_type)
    case flash_type
    when "failure"
      "Error"
    when "success"
      "Success"
    when "info"
      "Information"
    else
      "Information"
    end
  end

  def flash_icon(flash_type)
    color = flash_color flash_type
    case flash_type
    when "failure"
      tag "svg", class: "w-6 h-6 text-white fill-current", viewBox: "0 0 40 40", xmlns: "http://www.w3.org/2000/svg" do
        tag "path", d: "M20 3.36667C10.8167 3.36667 3.3667 10.8167 3.3667 20C3.3667 29.1833 10.8167 36.6333 20 36.6333C29.1834 36.6333 36.6334 29.1833 36.6334 20C36.6334 10.8167 29.1834 3.36667 20 3.36667ZM19.1334 33.3333V22.9H13.3334L21.6667 6.66667V17.1H27.25L19.1334 33.3333Z"
      end
    when "success"
      tag "svg", class: "w-6 h-6 text-white fill-current", viewBox: "0 0 40 40", xmlns: "http://www.w3.org/2000/svg" do
        tag "path", d: "M20 3.33331C10.8 3.33331 3.33337 10.8 3.33337 20C3.33337 29.2 10.8 36.6666 20 36.6666C29.2 36.6666 36.6667 29.2 36.6667 20C36.6667 10.8 29.2 3.33331 20 3.33331ZM16.6667 28.3333L8.33337 20L10.6834 17.65L16.6667 23.6166L29.3167 10.9666L31.6667 13.3333L16.6667 28.3333Z"
      end
    when "info"
      tag "svg", class: "w-6 h-6 text-white fill-current", viewBox: "0 0 40 40", xmlns: "http://www.w3.org/2000/svg" do
        tag "path", d: "M20 3.33331C10.8 3.33331 3.33337 10.8 3.33337 20C3.33337 29.2 10.8 36.6666 20 36.6666C29.2 36.6666 36.6667 29.2 36.6667 20C36.6667 10.8 29.2 3.33331 20 3.33331ZM21.6667 28.3333H18.3334V25H21.6667V28.3333ZM21.6667 21.6666H18.3334V11.6666H21.6667V21.6666Z"
      end
    end
  end
end
