module Tamago
  # file information ごとに、issuesを管理する
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

  class Informations < Hash
    def initialize(*)
      super
      @comment_types = Tamago.configuration.comment_types
    end

    def selected_issues(type)
      self.select do |path, issues|
        case type
        when :all
          true
        when :clean
          0 == issues[:issues].length
        when :dirty
          0 < issues[:issues].length
        end
      end
    end

    def information(path)
      self[path] ||= {
        relative_path: path,
        absolute_path: File.expand_path(path),
        tags: @comment_types,
        issues: Issues.new(@comment_types),
      }
    end
  end
end
