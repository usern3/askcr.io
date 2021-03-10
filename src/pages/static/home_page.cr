class Static::HomePage < HomeLayout
  needs operation : SignInUser
  needs users : UserQuery
  needs questions : QuestionQuery
  needs answers : AnswerQuery

  def content
    header
    features
    statistics
  end

  private def header
    header class: "pattern bg-gray-900" do
      div class: "container mx-auto px-6" do
        div class: "w-full max-w-6xl mx-auto" do
          nav class: "flex flex-col py-2 sm:flex-row sm:justify-between sm:items-center" do
            div do
              a "Ask.cr", class: "text-2xl font-semibold text-white hover:text-gray-300", href: "#"
            end
            div class: "flex items-center -mx-2 mt-2 sm:mt-0" do
              if current_user
                link "Dashboard", to: Dashboard::Show, class: "px-3 py-1 border-2 font-semibold rounded text-sm text-white hover:bg-gray-700"
                link "Logout", to: SignIns::Delete, flow_id: "sign-out-button", class: "mx-2 px-3 py-2 font-semibold bg-black rounded text-sm text-white hover:bg-gray-800"
              else
                link "Sign In", to: SignIns::New, class: "px-3 py-1 border-2 font-semibold rounded text-sm text-white hover:bg-gray-700"
                link "Sign Up", to: SignUps::New, class: "mx-2 px-3 py-2 font-semibold bg-black rounded text-sm text-white hover:bg-gray-800"
              end
            end
          end
          div class: "flex items-center flex-col py-6 md:h-128 md:flex-row" do
            div class: "md:w-1/2" do
              h2 "Ask.cr", class: "text-4xl font-semibold text-gray-100"
              h3 class: "text-2xl font-semibold text-gray-100" do
                text " Hello "
                span "Friend", class: "text-indigo-400"
              end
              para "Welcome to Ask.cr, a resource for the Crystal programming language. Here you can get help or share your knowledge about Crystal, it's frameworks, shards, and more with others!
                    Our goal is to build a useful resource for new and experienced Crystal users. Join us today!", class: "text-gray-100 mt-3"
            end
            div class: "md:w-1/2 flex md:justify-end mt-8 md:mt-0" do
              div class: "w-3/4 bg-white dark:bg-gray-800 rounded-lg" do
                div class: "p-5 text-center" do
                  if current_user
                    h2 "Welcome back!", class: "text-2xl font-semibold text-gray-700 dark:text-white fo"
                    div class: "mt-4" do
                      para "It appears you are already logged in."
                      para "Click the \"Dashboard\" or \"Logout\" button above."
                    end
                  else
                    h2 "Sign In", class: "text-2xl font-semibold text-gray-700 dark:text-white fo"
                    form_for SignIns::Create do
                      div class: "mt-4" do
                        mount Shared::Field, attribute: operation.email, &.email_input(autofocus: "true", replace_class: "w-full py-2 px-4 bg-white dark:bg-gray-800 text-gray-700 border border-gray-300 dark:border-gray-600 rounded block placeholder-gray-500 dark:placeholder-gray-400 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring", placeholder: "Email address", type: "email")
                        mount Shared::Field, attribute: operation.password, &.password_input(replace_class: "w-full py-2 px-4 bg-white dark:bg-gray-800 text-gray-700 border border-gray-300 dark:border-gray-600 rounded block placeholder-gray-500 dark:placeholder-gray-400 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring", placeholder: "Password", type: "password")
                      end
                      div class: "mt-4 flex items-center justify-between" do
                        a "Forgot Password?", class: "text-gray-600 dark:text-gray-200 text-sm hover:underline", href: "#"
                        submit "Login", flow_id: "sign-in-button", class: "px-4 py-2 font-semibold bg-gray-900 rounded text-white hover:bg-gray-800 dark:hover:bg-gray-700 focus:outline-none focus:bg-gray-800 dark:focus:bg-gray-700"
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  private def features
    section class: "bg-white dark:bg-gray-800 mt-5" do
      div class: "w-full max-w-6xl mx-auto" do
        div class: "container mx-auto px-6 py-8" do
          div class: "grid gap-6 grid-cols-1 md:grid-cols-2 lg:grid-cols-3" do
            div do
              tag "svg", class: "h-8 w-8", fill: "none", viewBox: "0 0 30 30" do
                tag "path", d: "M29.6931 14.2283L22.7556 6.87823C22.3292 6.426 21.6175 6.40538 21.1652 6.83212C20.7137 7.25851 20.6927 7.9706 21.1195 8.42248L27.3284 15L21.1195 21.5783C20.6927 22.0302 20.7137 22.7419 21.1652 23.1687C21.3827 23.3738 21.6606 23.4754 21.9374 23.4754C22.2363 23.4754 22.5348 23.3569 22.7557 23.1233L29.6932 15.7729C30.1022 15.339 30.1023 14.6618 29.6931 14.2283Z", fill: "#2D3748"
                tag "path", d: "M8.88087 21.578L2.67236 15L8.88087 8.42215C9.30726 7.97028 9.28664 7.25812 8.83476 6.83179C8.38323 6.4054 7.67073 6.42603 7.2444 6.87791L0.306858 14.2279C-0.102245 14.6614 -0.102245 15.3391 0.306858 15.7726L7.24475 23.123C7.466 23.3574 7.76413 23.4755 8.06302 23.4755C8.33976 23.4755 8.61767 23.3735 8.83476 23.1684C9.28705 22.742 9.30726 22.0299 8.88087 21.578Z", fill: "#2D3748"
                tag "path", d: "M16.8201 3.08774C16.2062 2.99476 15.6317 3.41622 15.5379 4.03011L12.2379 25.6302C12.1441 26.2445 12.566 26.8186 13.1803 26.9124C13.238 26.921 13.295 26.9252 13.3516 26.9252C13.898 26.9252 14.3773 26.5266 14.4624 25.97L17.7624 4.3699C17.8562 3.7556 17.4343 3.1815 16.8201 3.08774Z", fill: "#4299E1"
              end
              h1 "Share Your Code & Knowledge", class: "mt-4 font-semibold text-xl text-gray-800 dark:text-white"
              para "Ask your Crystal related questions and share your knowledge by answering others. Together we can help spread Crystal!", class: "mt-2 text-gray-500 dark:text-gray-400"
            end
            div do
              tag "svg", class: "h-8 w-8", fill: "none", viewBox: "0 0 30 30" do
                tag "path", d: "M27.3633 7.08984H26.4844V6.21094C26.4844 4.75705 25.3015 3.57422 23.8477 3.57422H4.39453C2.94064 3.57422 1.75781 4.75705 1.75781 6.21094V21.1523H0.878906C0.393516 21.1523 0 21.5459 0 22.0312V23.7891C0 25.2429 1.18283 26.4258 2.63672 26.4258H27.3633C28.8172 26.4258 30 25.2429 30 23.7891V9.72656C30 8.27268 28.8172 7.08984 27.3633 7.08984ZM3.51562 6.21094C3.51562 5.72631 3.9099 5.33203 4.39453 5.33203H23.8477C24.3323 5.33203 24.7266 5.72631 24.7266 6.21094V7.08984H20.332C18.8781 7.08984 17.6953 8.27268 17.6953 9.72656V21.1523H3.51562V6.21094ZM1.75781 23.7891V22.9102H17.6953V23.7891C17.6953 24.0971 17.7489 24.3929 17.8465 24.668H2.63672C2.15209 24.668 1.75781 24.2737 1.75781 23.7891ZM28.2422 23.7891C28.2422 24.2737 27.8479 24.668 27.3633 24.668H20.332C19.8474 24.668 19.4531 24.2737 19.4531 23.7891V9.72656C19.4531 9.24193 19.8474 8.84766 20.332 8.84766H27.3633C27.8479 8.84766 28.2422 9.24193 28.2422 9.72656V23.7891Z", fill: "#2D3748"
                tag "path", d: "M24.7266 21.1523H22.9688C22.4834 21.1523 22.0898 21.5459 22.0898 22.0312C22.0898 22.5166 22.4834 22.9102 22.9688 22.9102H24.7266C25.212 22.9102 25.6055 22.5166 25.6055 22.0312C25.6055 21.5459 25.212 21.1523 24.7266 21.1523Z", fill: "#4299E1"
                tag "path", d: "M23.8477 12.3633C24.3331 12.3633 24.7266 11.9698 24.7266 11.4844C24.7266 10.999 24.3331 10.6055 23.8477 10.6055C23.3622 10.6055 22.9688 10.999 22.9688 11.4844C22.9688 11.9698 23.3622 12.3633 23.8477 12.3633Z", fill: "#4299E1"
              end
              h1 "Fully Responsive Application", class: "mt-4 font-semibold text-xl text-gray-800 dark:text-white"
              para "Our application is fully responsive. So you can ask and answer on any device, anywhere!", class: "mt-2 text-gray-500 dark:text-gray-400"
            end
            div do
              tag "svg", class: "h-8 w-8", fill: "none", viewBox: "0 0 30 30" do
                tag "g", clip_path: "url(#clip0)" do
                  tag "path", d: "M26.599 4.339a1.875 1.875 0 11-3.75 0 1.875 1.875 0 013.75 0zM7.151 25.661a1.875 1.875 0 11-3.75 0 1.875 1.875 0 013.75 0zM23.486 13.163a8.636 8.636 0 00-1.19-2.873l1.123-1.123-2.592-2.59L19.705 7.7a8.636 8.636 0 00-2.873-1.19V4.921h-3.664v1.586a8.634 8.634 0 00-2.873 1.19l-1.122-1.12-2.592 2.589 1.123 1.123a8.636 8.636 0 00-1.19 2.873H4.922l-.002 3.663h1.592A8.626 8.626 0 007.704 19.7l-1.127 1.127 2.59 2.591 1.128-1.127a8.623 8.623 0 002.873 1.19v1.597h3.664v-1.597a8.628 8.628 0 002.873-1.19l1.128 1.128 2.59-2.592-1.127-1.127a8.627 8.627 0 001.19-2.873h1.593v-3.664h-1.593zM15 19.256a4.255 4.255 0 110-8.511 4.255 4.255 0 010 8.51z", fill: "#4299E1"
                  tag "path", d: "M5.276 23.2c-.42 0-.823.105-1.182.302A13.853 13.853 0 011.172 15C1.172 7.375 7.375 1.172 15 1.172c.927 0 1.854.092 2.754.274a.586.586 0 00.232-1.149A15.111 15.111 0 0015 0C10.993 0 7.226 1.56 4.393 4.393A14.902 14.902 0 000 15c0 3.37 1.144 6.66 3.228 9.296-.268.4-.413.872-.413 1.365 0 .657.257 1.275.721 1.74a2.444 2.444 0 001.74.721c.658 0 1.276-.256 1.74-.721.465-.465.721-1.083.721-1.74s-.256-1.276-.72-1.74a2.445 2.445 0 00-1.74-.72zm.912 3.373a1.28 1.28 0 01-.912.377 1.28 1.28 0 01-.911-.377 1.28 1.28 0 01-.378-.912c0-.344.134-.668.378-.912a1.28 1.28 0 01.911-.377c.345 0 .668.134.912.378.243.243.377.567.377.911 0 .344-.134.668-.377.912zM26.772 5.703a2.465 2.465 0 00-.308-3.104 2.446 2.446 0 00-1.74-.721c-.658 0-1.276.256-1.74.72a2.445 2.445 0 00-.721 1.74c0 .658.256 1.276.72 1.741.465.465 1.083.72 1.74.72.42 0 .824-.104 1.183-.3A13.854 13.854 0 0128.828 15c0 7.625-6.203 13.828-13.828 13.828-.918 0-1.836-.09-2.728-.269a.586.586 0 00-.23 1.15c.968.193 1.963.291 2.958.291 4.007 0 7.773-1.56 10.607-4.393A14.902 14.902 0 0030 15c0-3.37-1.145-6.66-3.228-9.297zm-2.96-.452a1.28 1.28 0 01-.377-.912c0-.344.134-.668.377-.911a1.28 1.28 0 01.912-.378 1.29 1.29 0 010 2.578 1.28 1.28 0 01-.912-.377z", fill: "#2D3748"
                  tag "path", d: "M12.582 25.078c0 .324.263.586.586.586h3.664a.586.586 0 00.586-.586v-1.136a9.179 9.179 0 002.199-.911l.802.802a.586.586 0 00.829 0l2.59-2.592a.586.586 0 000-.828l-.802-.802a9.169 9.169 0 00.911-2.199h1.132a.586.586 0 00.586-.585v-3.664a.586.586 0 00-.586-.586h-1.132a9.17 9.17 0 00-.911-2.199l.797-.797a.587.587 0 000-.829l-2.592-2.59a.586.586 0 00-.829 0l-.795.797a9.177 9.177 0 00-2.2-.912V4.922a.586.586 0 00-.585-.586h-3.664a.586.586 0 00-.586.586v1.126a9.169 9.169 0 00-2.199.91l-.796-.795a.586.586 0 00-.828 0l-2.592 2.59a.585.585 0 000 .828l.797.797a9.173 9.173 0 00-.911 2.199h-1.13a.586.586 0 00-.586.585l-.002 3.664a.585.585 0 00.586.586h1.132c.207.77.512 1.507.911 2.2l-.801.8a.586.586 0 000 .83l2.59 2.59a.586.586 0 00.829 0l.801-.801a9.185 9.185 0 002.2.911v1.136zm-1.97-3.28a.586.586 0 00-.732.078l-.713.714-1.761-1.763.712-.713a.586.586 0 00.078-.732 8.02 8.02 0 01-1.11-2.679.586.586 0 00-.572-.462H5.507l.002-2.492h1.005a.586.586 0 00.572-.463 8.022 8.022 0 011.11-2.678.586.586 0 00-.078-.733l-.708-.708 1.763-1.761.707.707c.196.196.5.228.733.078a8.016 8.016 0 012.678-1.11.586.586 0 00.463-.573v-1h2.492v1c0 .277.193.515.463.573a8.024 8.024 0 012.678 1.11c.232.15.537.118.732-.078l.708-.707 1.762 1.761-.708.708a.586.586 0 00-.078.732 8.027 8.027 0 011.11 2.679c.058.27.297.463.573.463h1.007v2.492h-1.007a.586.586 0 00-.573.462 8.02 8.02 0 01-1.11 2.679.586.586 0 00.078.732l.713.713-1.761 1.762-.714-.713a.586.586 0 00-.732-.078 8.027 8.027 0 01-2.678 1.11.586.586 0 00-.463.573v1.011h-2.492v-1.01a.586.586 0 00-.463-.574 8.021 8.021 0 01-2.678-1.11z", fill: "#2D3748"
                  tag "path", d: "M19.841 15A4.847 4.847 0 0015 10.158 4.847 4.847 0 0010.158 15 4.847 4.847 0 0015 19.841 4.847 4.847 0 0019.841 15zm-8.51 0A3.674 3.674 0 0115 11.33 3.674 3.674 0 0118.67 15 3.674 3.674 0 0115 18.67 3.674 3.674 0 0111.33 15z", fill: "#2D3748"
                  tag "path", d: "M20.395 2.216a.59.59 0 00.415-.172.593.593 0 00.171-.415.59.59 0 00-.586-.586.589.589 0 00-.586.586.589.589 0 00.586.587zM9.63 27.794a.59.59 0 00-.586.586.59.59 0 00.586.586.59.59 0 00.586-.586.59.59 0 00-.586-.585z", fill: "#4299E1"
                end
                tag "defs" do
                  tag "clipPath", id: "clip0" do
                    tag "path", d: "M0 0h30v30H0z", fill: "#fff"
                  end
                end
              end
              h1 "Earn Points (coming soon!)", class: "mt-4 font-semibold text-xl text-gray-800 dark:text-white"
              para "Earn points by providing value to the community. These points can be earned various ways. Who will hold the top spots on the leaderboard?", class: "mt-2 text-gray-500 dark:text-gray-400"
            end
          end
        end
      end
    end
  end

  private def statistics
    section class: "text-gray-600 body-font mt-5" do
      div class: "w-full max-w-6xl mx-auto" do
        div class: "container px-5 py-24 mx-auto" do
          div class: "flex flex-col text-center w-full mb-20" do
            h1 "Ask.cr Community Statistics", class: "sm:text-3xl text-2xl font-medium title-font mb-4 text-gray-900"
            para "Our active community members have asked and answered alot! Below is a glimpse into some of Ask.cr's statistics."
          end
          div class: "flex flex-wrap -m-4 text-center" do
            div class: "p-4 md:w-1/4 sm:w-1/2 w-full" do
              div class: "border-2 border-gray-200 px-4 py-6 rounded-lg" do
                tag "svg", class: "text-indigo-500 w-12 h-12 mb-3 inline-block", fill: "none", stroke: "currentColor", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24" do
                  tag "path", d: "M8 17l4 4 4-4m-4-5v9"
                  tag "path", d: "M20.88 18.09A5 5 0 0018 9h-1.26A8 8 0 103 16.29"
                end
                h2 "2.7K", class: "title-font font-medium text-3xl text-gray-900"
                para "Questions", class: "leading-relaxed"
              end
            end
            div class: "p-4 md:w-1/4 sm:w-1/2 w-full" do
              div class: "border-2 border-gray-200 px-4 py-6 rounded-lg" do
                tag "svg", class: "text-indigo-500 w-12 h-12 mb-3 inline-block", fill: "none", stroke: "currentColor", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24" do
                  tag "path", d: "M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"
                  tag "circle", cx: "9", cy: "7", r: "4"
                  tag "path", d: "M23 21v-2a4 4 0 00-3-3.87m-4-12a4 4 0 010 7.75"
                end
                h2 users.size, class: "title-font font-medium text-3xl text-gray-900"
                para "Users", class: "leading-relaxed"
              end
            end
            div class: "p-4 md:w-1/4 sm:w-1/2 w-full" do
              div class: "border-2 border-gray-200 px-4 py-6 rounded-lg" do
                tag "svg", class: "text-indigo-500 w-12 h-12 mb-3 inline-block", fill: "none", stroke: "currentColor", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24" do
                  tag "path", d: "M3 18v-6a9 9 0 0118 0v6"
                  tag "path", d: "M21 19a2 2 0 01-2 2h-1a2 2 0 01-2-2v-3a2 2 0 012-2h3zM3 19a2 2 0 002 2h1a2 2 0 002-2v-3a2 2 0 00-2-2H3z"
                end
                h2 "6.1k Answers", class: "title-font font-medium text-3xl text-gray-900"
                para "Files", class: "leading-relaxed"
              end
            end
            div class: "p-4 md:w-1/4 sm:w-1/2 w-full" do
              div class: "border-2 border-gray-200 px-4 py-6 rounded-lg" do
                tag "svg", class: "text-indigo-500 w-12 h-12 mb-3 inline-block", fill: "none", stroke: "currentColor", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", viewBox: "0 0 24 24" do
                  tag "path", d: "M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"
                end
                h2 "1.5k", class: "title-font font-medium text-3xl text-gray-900"
                para "Questions Solved", class: "leading-relaxed"
              end
            end
          end
        end
      end
    end
  end
end
