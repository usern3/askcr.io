class Users::EditPage < AdminLayout
  include FormattingHelpers
  needs operation : EditUser
  quick_def page_title, "Editing @#{current_user.username}'s profile."

  def content
    div class: "container mx-auto mt-2 min-h-screen" do
      div class: "w-full max-w-6xl mx-auto" do
        div class: "grid gap-2 sm:grid-cols-1 md:grid-cols-3 lg:grid-cols-3" do
          div class: "sm:col-span-1 md:col-span-3 align-baseline" do
            h1 "Editing user: #{current_user.username}(#{current_user.email})", class: "text-2xl text-gray-800 font-bold align-baseline"
          end
          user_details_card(@operation)
        end
      end
    end
  end

  private def user_details_card(op)
    div class: "sm:col-span-3" do
      div class: "my-2" do
        h2 "User Details", class: "text-xl text-gray-800 font-bold align-baseline"
      end
      div class: "mx-auto px-4 py-3 bg-white dark:bg-gray-800 shadow-md rounded-md" do
        div class: "mt-2" do
          div class: "grid grid-flow-row auto-rows-max gap-4" do
            form_for Users::Update.with(current_user.id), multipart: true do
              div class: "grid grid-cols-1 sm:grid-cols-1 gap-6 mt-4" do
                div do
                  mount Shared::Field, attribute: op.username, &.text_input(autofocus: "true", append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring", attrs: [:disabled])
                end
                div do
                  mount Shared::Field, attribute: op.email, &.email_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  mount Shared::Field, attribute: op.password, label_text: "Current Password (Required to update profile or change passwords)", &.password_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  mount Shared::Field, attribute: op.new_password, label_text: "New Password", &.password_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  mount Shared::Field, attribute: op.new_password_confirmation, label_text: "Confirm New Password", &.password_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  mount Shared::Field, attribute: op.github_username, &.text_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  mount Shared::Field, attribute: op.location, &.text_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  mount Shared::Field, attribute: op.btc_address, &.text_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  mount Shared::Field, attribute: op.doge_address, &.text_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  mount Shared::Field, attribute: op.eth_address, &.text_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  mount Shared::Field, attribute: op.bch_address, &.text_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  mount Shared::Field, attribute: op.nim_address, &.text_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  mount Shared::Field, attribute: op.oxen_address, &.text_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  mount Shared::Field, attribute: op.xmr_address, &.text_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  div class: "h-20 w-20 mb-4" do
                    if !current_user.profile_picture_path.nil?
                      img alt: "avatar", class: "h-full w-full object-cover", src: current_user.profile_picture_path.not_nil!
                    else
                      img alt: "avatar", class: "h-full w-full object-cover", src: "https://lh3.googleusercontent.com/a-/AOh14Gi0DgItGDTATTFV6lPiVrqtja6RZ_qrY91zg42o-g"
                    end
                  end
                  mount Shared::Field, op.profile_picture, label_text: "Avatar", &.file_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
              end
              div class: "flex justify-end mt-6" do
                submit "Update", data_disable_with: "Updating...", class: "bg-gray-700 text-white py-2 px-4 rounded hover:bg-gray-500 hover:text-white focus:outline-none focus:bg-gray-500 focus:text-white"
              end
            end
          end
        end
      end
    end
  end
end
