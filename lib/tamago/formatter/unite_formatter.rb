require 'json'
require 'tamago/formatter'

module Tamago
  class Formatter::UniteFormatter < Formatter
    private

    def start
      @candidates = []
      selected_issues.each { |_, info| build_candidate(info) }
      File.dump_result @candidates.to_json
    end

    def finish
    end

    def build_candidate(info)
      candidate = {
        word: "[o] #{info[:relative_path]}",
        action__path: info[:absolute_path],
        action__absolute_path: info[:absolute_path],
        action__relative_path: info[:relative_path],
        is_multiline: 1,
        action__has_issue: info[:issues].has_issue? ? 1 : 0,
        action__tags: info[:tags],
      }

      if info[:issues].has_issue?
        info[:tags].each do |tag|
          info[:issues][tag].each do |issue|
            @candidates << candidate.dup.merge(create_issue_candidate(info, issue))
          end
        end
      else
        @candidates << candidate
      end
    end

    def create_issue_candidate(info, issue)
      {
        word: "[x] #{info[:relative_path]}:#{issue[:line]}\n    #{issue[:tagname]} - #{issue[:title]}",
        action__line: issue[:line],
        action__tag: issue[:tagname],
        action__title: issue[:title],
      }
    end
  end
end
