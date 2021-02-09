class Shared::AuthHeaderNav < BaseComponent
  def render_links
    a "About", class: "mx-2 mt-2 md:mt-0 px-2 py-1 text-sm text-gray-700 dark:text-gray-200 font-medium rounded-md hover:bg-gray-300 dark:hover:bg-gray-700", href: "#"
    link "Questions", to: Questions::Index, class: "mx-2 mt-2 md:mt-0 px-2 py-1 text-sm text-gray-700 dark:text-gray-200 font-medium rounded-md hover:bg-gray-300 dark:hover:bg-gray-700"
    link "Tags", to: Tags::Index, class: "mx-2 mt-2 md:mt-0 px-2 py-1 text-sm text-gray-700 dark:text-gray-200 font-medium rounded-md hover:bg-gray-300 dark:hover:bg-gray-700"
    a "Contact", class: "mx-2 mt-2 md:mt-0 px-2 py-1 text-sm text-gray-700 dark:text-gray-200 font-medium rounded-md hover:bg-gray-300 dark:hover:bg-gray-700", href: "#"
    a "Crystal Lang", href: "https://crystal-lang.org/", target: "_blank", class: "mx-2 mt-2 md:mt-0 px-2 py-1 text-sm text-gray-700 dark:text-gray-200 font-medium rounded-md hover:bg-gray-300 dark:hover:bg-gray-700"
  end

  def render
    nav class: "bg-white dark:bg-gray-800 shadow" do
      div class: "container mx-auto px-6 py-3" do
        div class: "md:flex md:items-center md:justify-between" do
          div class: "flex justify-between items-center" do
            div class: "text-xl font-semibold text-gray-700" do
              link "Ask.cr", to: Dashboard::Show, class: "text-gray-800 dark:text-white text-xl font-bold md:text-2xl hover:text-gray-700 dark:hover:text-gray-300"
            end
            div class: "flex md:hidden" do
              button aria_label: "toggle menu", class: "text-gray-500 dark:text-gray-200 hover:text-gray-600 dark:hover:text-gray-400 focus:outline-none focus:text-gray-600 dark:focus:text-gray-400", type: "button" do
                tag "svg", class: "h-6 w-6 fill-current", viewBox: "0 0 24 24" do
                  tag "path", d: "M4 5h16a1 1 0 0 1 0 2H4a1 1 0 1 1 0-2zm0 6h16a1 1 0 0 1 0 2H4a1 1 0 0 1 0-2zm0 6h16a1 1 0 0 1 0 2H4a1 1 0 0 1 0-2z", fill_rule: "evenodd"
                end
              end
            end
          end
          div class: "hidden md:flex md:items-center md:justify-between flex-1" do
            div class: "flex flex-col -mx-4 md:flex-row md:items-center md:mx-8" do
              render_links
            end
          end
        end
      end
    end
  end
end
