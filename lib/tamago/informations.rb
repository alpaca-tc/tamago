module Tamago
  class Informations < Hash
    def initialize(*)
      super
      @root_path = Dir.pwd
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
      absolute_path = File.expand_path(path)

      self[path] ||= {
        relative_path: absolute_path.sub(/^#{@root_path}\//, ''),
        absolute_path: absolute_path,
        tags: @comment_types,
        issues: Issues.new(@comment_types),
      }
    end
  end
end
