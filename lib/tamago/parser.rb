require 'comment_extractor'
require 'parallel'
require 'tamago/issues'

module Tamago
  class Parser
    def initialize
      @comment_types = Tamago.configuration.comment_types
      comment_type_regexp = "(?<tagname>#{@comment_types.join('|')})"
      @comment_regexp = /^\s*\[#{comment_type_regexp}\]\s*(?<title>.*)$/
      @informations = Informations.new
    end

    def parse(file_list)
      in_threads = Tamago.configuration.in_threads
      Parallel.each(file_list, in_threads: in_threads) do |path|
      # file_list.each do |path|
        parse_file(path)
      end

      @informations
    end

    def parse_file(path)
      info = @informations.information(path)

      return info unless parser = CommentExtractor::Parser.for(path)

      comments = parser.extract_comments
      comments.each_with_object(info) do |comment, info|
        if /^(\[(?<tagname>todo|review)\])\s*-\s*(?<title>.*)$/ =~ comment.value
          info[:issues].append_issue(tagname, comment.line, title)
        end
      end
    end
  end
end
