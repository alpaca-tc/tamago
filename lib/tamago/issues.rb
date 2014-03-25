module Tamago
  class Issues < Hash
    attr_reader :length

    def initialize(comment_types)
      super()
      comment_types.map!(&:to_sym)
      new_hash = Hash[comment_types.zip(comment_types.map { |v| [] })]
      self.replace(new_hash)
      @length = 0
    end

    def append_issue(tagname, line, title)
      tagname = tagname.to_sym

      issue = {
        tagname: tagname,
        line: line,
        title: title
      }

      @length += 1
      self[tagname] << issue
    end

    def has_issue?
      0 < @length
    end
  end
end
