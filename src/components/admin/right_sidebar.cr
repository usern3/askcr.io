class Admin::Shared::RightSidebar < BaseComponent
  def render
    div class: "sm:col-span-1" do
      div class: "mx-auto px-4 py-3 bg-white dark:bg-gray-800 shadow-md rounded-md" do
        div class: "flex justify-between items-center" do
          h2 "Admin Naviation", class: "text-lg font-semibold text-gray-800 dark:text-white"
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
