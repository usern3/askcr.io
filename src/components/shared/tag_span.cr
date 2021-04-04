class Shared::TagSpan < BaseComponent
  needs question : Question
  needs separated : Bool
  needs count : Int32 = 3

  def render
    if separated?
      render_double
    else
      render_single
    end
  end

  def render_single
    span do
      if !question.tags.empty?
        tags = question.tags.first(count)
        tags.each do |tag|
          if tag.name == "Crystal"
            a tag.name, class: "px-3 py-1 mr-4 bg-gray-200 text-gray-700 text-sm font-bold rounded hover:bg-gray-500 hover:text-gray-200"
          elsif tag.name == "Lucky"
            a tag.name, class: "px-3 py-1 mr-4 bg-green-200 text-green-700 text-sm font-bold rounded hover:bg-green-400"
          else
            a tag.name, class: "px-3 py-1 mr-4 bg-gray-600 text-gray-100 text-sm font-bold rounded hover:bg-gray-500 hover:text-gray-200"
          end
        end
      end

      if question.solution_id.nil?
        a "Unsolved", class: "px-3 py-1 bg-red-200 text-red-500 text-sm font-bold rounded hover:bg-red-300"
      else
        a "Solved", class: "px-3 py-1 bg-green-600 text-white text-sm font-bold rounded hover:bg-green-500"
      end
    end
  end

  def render_double
    span do
      if !question.tags.empty?
        tags = question.tags.first(count)
        tags.each do |tag|
          if tag.name == "Crystal" || tag.name == "crystal"
            a tag.name, class: "px-3 py-1 mr-4 bg-gray-200 text-gray-700 text-sm font-bold rounded hover:bg-gray-500 hover:text-gray-200"
          elsif tag.name == "Lucky" || tag.name == "lucky"
            a tag.name, class: "px-3 py-1 mr-4 bg-green-200 text-green-700 text-sm font-bold rounded hover:bg-green-400"
          else
            a tag.name, class: "px-3 py-1 mr-4 bg-gray-600 text-gray-100 text-sm font-bold rounded hover:bg-gray-500 hover:text-gray-200"
          end
        end
      end
    end
    span do
      if question.solution_id.nil?
        a "Unsolved", class: "px-3 py-1 bg-red-200 text-red-500 text-sm font-bold rounded hover:bg-red-300"
      else
        a "Solved", class: "px-3 py-1 bg-green-600 text-green-100 text-sm font-bold rounded hover:bg-green-500"
      end
    end
  end
end
