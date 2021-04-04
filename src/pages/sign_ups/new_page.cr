class SignUps::NewPage < AuthLayout
  needs operation : SignUpUser

  def content
    render_sign_up_form(@operation)
  end

  private def render_sign_up_form(op)
    div class: "container pt-24" do
      div class: "w-full max-w-2xl mx-auto" do
        div class: "max-w-2xl mx-auto bg-white dark:bg-gray-800 rounded-md shadow-lg" do
          div class: "mt-0 p-6 bg-gray-800 w-100 rounded" do
            h2 "Account Registration", class: "text-lg text-white dark:text-white font-semibold capitalize"
          end
          div class: "p-6 w-100 rounded" do
            form_for SignUps::Create, multipart: true do
              div class: "grid grid-cols-1 sm:grid-cols-2 gap-6 mt-4" do
                div do
                  label "Username", class: "text-gray-700 dark:text-gray-200"
                  mount Shared::LabellessField, attribute: op.username, &.text_input(autofocus: true, append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  label "Email Address", class: "text-gray-700 dark:text-gray-200"
                  mount Shared::LabellessField, attribute: op.email, &.email_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  label "Password", class: "text-gray-700 dark:text-gray-200"
                  mount Shared::LabellessField, attribute: op.password, &.password_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  label "Password Confirmation", class: "text-gray-700 dark:text-gray-200"
                  mount Shared::LabellessField, attribute: op.password_confirmation, &.password_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  label "Personal Website", class: "text-gray-700 dark:text-gray-200"
                  mount Shared::LabellessField, attribute: op.website_url, &.text_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  label "Github Username", class: "text-gray-700 dark:text-gray-200"
                  mount Shared::LabellessField, attribute: op.github_username, &.text_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  label "BTC Address", class: "text-gray-700 dark:text-gray-200"
                  mount Shared::LabellessField, attribute: op.btc_address, &.text_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div do
                  label "NIM Address", class: "text-gray-700 dark:text-gray-200"
                  mount Shared::LabellessField, attribute: op.nim_address, &.text_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
                div class: "col-span-2" do
                  mount Shared::LabellessField, op.profile_picture, label_text: "Avatar", &.file_input(append_class: "mt-2 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-600 rounded py-2 px-4 block w-full focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring")
                end
              end
              div class: "flex justify-end mt-6" do
                submit "Sign Up", flow_id: "sign-up-button", class: "bg-gray-700 text-white py-2 px-4 rounded hover:bg-gray-500 hover:text-white focus:outline-none focus:bg-gray-500 focus:text-white"
              end
            end
          end
        end
      end
    end
  end
end
