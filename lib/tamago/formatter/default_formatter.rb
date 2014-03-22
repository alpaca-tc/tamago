require 'tamago/formatter'

module Tamago
  class Formatter::DefaultFormatter < Formatter
    RESET     = "\e[00m"
    UNDERLINE = "\e[4m"
    BOLD      = "\e[01m"

    WHITE     = "\e[38;5;7m"
    RED       = "\e[38;5;1m"
    GRAY      = "\e[38;5;0m"
    YELLOW    = "\e[38;5;3m"
    CYAN      = "\e[38;5;6m"
    BLUE      = "\e[38;5;4m"
    GREEN     = "\e[38;5;2m"

    TEMPLATE = "#{RESET}#{BOLD}#{WHITE}[#COLOR#MARK#{WHITE}]#{RESET} #{BOLD}#COLOR#{UNDERLINE}#PATH#{RESET}"
    DEFINITION = {
      green: TEMPLATE.gsub('#COLOR', GREEN).gsub('#MARK', 'o'),
      red: TEMPLATE.gsub('#COLOR', RED).gsub('#MARK', 'x'),
      tag: "  #{RESET}#{BOLD}#{WHITE}[#{BLUE}#TAG#{WHITE}]#{RESET}",
      issue: "    #{RESET}#{WHITE}line #LINE - #{BOLD}#{WHITE}#TITLE#{RESET}",
    }

    def start
      message = []
      selected_issues.each do |path, issues_object|
        message += build_message(path, issues_object)
      end

      puts message.flatten
    end

    private

    def build_message(path, issues_object)
      issues = issues_object[:issues]
      definition = issues.has_issue? ? DEFINITION[:red] : DEFINITION[:green]

      message = []
      message << definition.gsub('#PATH', path)
      message << build_issue_message(issues) if issues.has_issue?

      message
    end

    def build_issue_message(issues)
      issues.each_with_object([]) do |(tagname, issue_list), memo|
        memo << DEFINITION[:tag].gsub('#TAG', tagname.to_s) unless issue_list.empty?
        issue_list.each do |issue|
          memo << DEFINITION[:issue].gsub('#LINE', issue[:line].to_s).gsub('#TITLE', issue[:title])
        end
      end
    end
  end
end
