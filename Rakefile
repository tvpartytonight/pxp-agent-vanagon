begin
  require 'packaging'
  Pkg::Util::RakeUtils.load_packaging_tasks
rescue StandardError => e
  puts "Error loading packaging rake tasks: #{e}"
end

desc 'run static analysis with rubocop'
task(:rubocop) do
  require 'rubocop'
  cli = RuboCop::CLI.new
  exit_code = cli.run(%w[--display-cop-names --format simple])
  raise 'RuboCop detected offenses' if exit_code != 0
end

desc 'verify that commit messages match CONTRIBUTING.md requirements'
task(:commits) do
  commits = ENV['TRAVIS_COMMIT_RANGE']
  if commits.nil?
    puts "TRAVIS_COMMIT_RANGE is undefined, I don't know what to check."
    exit
  end

  `git log --no-merges --pretty=%s #{commits}`.each_line do |commit_summary|
    error_message = <<~HEREDOC
      \n\n\n\tThis commit summary didn't match CONTRIBUTING.md guidelines:\n \
      \n\t\t#{commit_summary}\n \
      \tThe commit summary (i.e. the first line of the commit message) should start with one of:\n  \
      \t\t(docs)\n \
      \t\t(maint)\n \
      \t\t(packaging)\n \
      \t\t(<ANY PUBLIC JIRA TICKET>)\n \
      \n\tThis test for the commit summary is case-insensitive.\n\n\n
    HEREDOC

    next unless /^\((maint|doc|docs|packaging|pa-\d+)\)|revert|bumping|merge|promoting/i.match(commit_summary).nil?

    ticket = commit_summary.match(/^\(([[:alpha:]]+-[[:digit:]]+)\).*/)
    raise error_message if ticket.nil?

    require 'net/http'
    require 'uri'
    uri = URI.parse("https://tickets.puppetlabs.com/browse/#{ticket[1]}")
    response = Net::HTTP.get_response(uri)
    raise error_message if response.code != '200'
  end
end
