require "../src/app"

class CountQuestionsInTags < LuckyCli::Task
  summary "Recounts the amount of questions that belong to each tag."

  switch :single, "Disable an existing user as an admin.", shortcut: "-s"
  positional_arg :tag_name,
    "Tag to be updated."

  def call
    if single?
      current_tag = TagQuery.new.preload_questions.name(tag_name.capitalize).first?
      if current_tag
        SaveTag.update(current_tag, question_count: current_tag.questions.size) do |op, tag|
          if op.saved?
            puts "Tag: #{tag_name.capitalize} question count successful.".colorize(:green)
          else 
            puts "Something went wrong. Please check the information entered and try again.".colorize(:red)
          end
        end
      else
        puts "Invalid tag.".colorize(:red)
      end
    else
      current_tags = TagQuery.new.preload_questions
      current_tags.each do |t|
        SaveTag.update(t, question_count: t.questions.size) do |op, tag|
          if op.saved?
            puts "#{tag.name.capitalize} question count successful.".colorize(:green)
          else 
            puts "{tag.name.capitalize} failed.".colorize(:red)
          end
        end
      end
    end
  end

  def add_to_existing
    # Add counts to existing tags.
    current_tags = TagQuery.new
    current_tags.each {|t| SaveTag.update!(t, question_count: t.questions.size)}
  end
end