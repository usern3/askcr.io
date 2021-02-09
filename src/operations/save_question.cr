class SaveQuestion < Question::SaveOperation
  include Markdown
  # To save user provided params to the database, you must permit them
  # https://luckyframework.org/guides/database/validating-saving#perma-permitting-columns
  attribute tags : String
  permit_columns title, body, parsed_body, solved, author_id

  before_save do 
    generate_parsed_body
    format_tags
  end

  private def generate_parsed_body
    self.parsed_body.value = Markdown.parse(self.body.value.not_nil!)
  end

  private def format_tags
    tags.value.try do |t|
      submitted_tags = t.split(",").compact.reject! { |x| x == "" || x == " " }.map! {|x| x.strip.titleize }
      if !id.value.nil?
        question = QuestionQuery.new.preload_tags.find(id.value.not_nil!)
        existing = question.tags.map{|x| x.name }
        removed_tags = existing - submitted_tags
      end   
    
      submitted_tags.each do |tag|
        tag = SaveTag.find_or_create(name: tag)
        SaveTagging.find_or_create(question_id: id.value, tag_id: tag.id)
      end
      
      if !removed_tags.nil?
        removed_tags.each do |tag|
          tag = TagQuery.new.name(tag).first
          tagging = TaggingQuery.new.question_id(id.value.not_nil!).tag_id(tag.id.not_nil!)
          tagging.delete
        end
      end
    end
    
    if tags.value.nil?
      tagging = TaggingQuery.new.question_id(id.value.not_nil!)
      tagging.each{|x| x.delete }
    end
  end
end
