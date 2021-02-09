class Shared::PaginationLinks < BaseComponent
  needs pages : Lucky::Paginator
  needs page_type : String

  def render
    div class: "bg-white shadow-md rounded-md px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6" do
      div class: "flex-1 flex justify-between sm:hidden" do
        previous_link
        next_link
      end
      div class: "hidden sm:flex-1 sm:flex sm:items-center sm:justify-between" do
        div do
          para class: "text-sm leading-5 text-gray-700" do
            text " Showing "
            span @pages.item_range.begin, class: "font-medium"
            text " to "
            span @pages.item_range.end, class: "font-medium"
            text " of "
            span @pages.item_count, class: "font-medium"
            text " #{page_type}."
          end
        end
        div do
          nav class: "relative z-0 inline-flex shadow-sm" do
            previous_icon_link
            page_links
            next_icon_link
          end
        end
      end
    end
  end

  def page_links
    @pages.series(begin: 1, left_of_current: 1, right_of_current: 1, end: 1).each do |item|
      render_page_item(item)
    end
  end

  def render_page_item(page : Lucky::Paginator::Page)
    a page.number, href: page.path, class: "hidden md:inline-flex -ml-px relative items-center px-4 py-2 border border-gray-300 bg-white text-sm leading-5 font-medium text-gray-700 hover:text-gray-500 focus:z-10 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:bg-gray-100 active:text-gray-700 transition ease-in-out duration-150"
  end

  def render_page_item(page : Lucky::Paginator::CurrentPage)
    a page.number, href: page.path, class: "hidden md:inline-flex -ml-px relative items-center px-4 py-2 border border-gray-600 bg-gray-600 text-sm leading-5 font-medium text-white hover:bg-gray-700 focus:z-10 focus:outline-none focus:border-gray-300 focus:shadow-outline-blue active:bg-gray-700 transition ease-in-out duration-150"
  end

  def render_page_item(gap : Lucky::Paginator::Gap)
    span "...", class: "-ml-px relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm leading-5 font-medium text-gray-700"
  end

  def previous_icon_link
    if prev_path = @pages.path_to_previous
      a href: prev_path, aria_label: "Previous", class: "relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm leading-5 font-medium text-gray-500 hover:text-gray-400 focus:z-10 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:bg-gray-100 active:text-gray-500 transition ease-in-out duration-150" do
        tag "svg", class: "h-5 w-5", fill: "currentColor", viewBox: "0 0 20 20", xmlns: "http://www.w3.org/2000/svg" do
          tag "path", clip_rule: "evenodd", d: "M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z", fill_rule: "evenodd"
        end
      end
    else
      span class: "relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm leading-5 font-medium text-gray-300" do
        tag "svg", class: "h-5 w-5", fill: "currentColor", viewBox: "0 0 20 20", xmlns: "http://www.w3.org/2000/svg" do
          tag "path", clip_rule: "evenodd", d: "M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z", fill_rule: "evenodd"
        end
      end
    end
  end

  def next_icon_link
    if path_to_next = @pages.path_to_next
      a href: path_to_next, aria_label: "Next", class: "-ml-px relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm leading-5 font-medium text-gray-500 hover:text-gray-400 focus:z-10 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:bg-gray-100 active:text-gray-500 transition ease-in-out duration-150" do
        tag "svg", class: "h-5 w-5", fill: "currentColor", viewBox: "0 0 20 20", xmlns: "http://www.w3.org/2000/svg" do
          tag "path", clip_rule: "evenodd", d: "M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z", fill_rule: "evenodd"
        end
      end
    else
      span class: "-ml-px relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm leading-5 font-medium text-gray-300" do
        tag "svg", class: "h-5 w-5", fill: "currentColor", viewBox: "0 0 20 20", xmlns: "http://www.w3.org/2000/svg" do
          tag "path", clip_rule: "evenodd", d: "M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z", fill_rule: "evenodd"
        end
      end
    end
  end

  def previous_link
    if prev_path = @pages.path_to_previous
      a "Previous", href: prev_path, class: "relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 active:bg-gray-100 active:text-gray-700 transition ease-in-out duration-150"
    end
  end

  def next_link
    if path_to_next = @pages.path_to_next
      a "Next", href: path_to_next, class: "ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 active:bg-gray-100 active:text-gray-700 transition ease-in-out duration-150"
    end
  end
end