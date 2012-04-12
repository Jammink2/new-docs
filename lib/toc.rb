section 'overview', 'Overview' do
  category 'getting-started', 'Getting Started' do
    article 'quickstart', 'Getting Started with Treasure Data'
  end
  category 'platform-basics', 'Platform Basics' do
    article 'architecture-overview', 'Architecture Overview'
  end
end

section 'languages-and-middlewares', 'Langueges / Middlewares' do
  category 'java', 'Java' do
    article 'java', 'Data Import from Java Applications'
  end
  category 'ruby', 'Ruby' do
    article 'ruby', 'Data Import from Ruby Applications'
    article 'rails', 'Data Import from Ruby on Rails Applications'
  end
  category 'python', 'Python' do
    article 'python', 'Data Import from Python Applications'
  end
  category 'php', 'PHP' do
    article 'php', 'Data Import from PHP Applications'
  end
end

# section 'tutorials', 'Tutorials' do
#   category 'usecases', 'Use Cases' do
#     article 'apache-logs', 'Calculating UU from Apache Logs'
#     article 'game', 'Calculating ARPU from Gaming Logs'
#     article 'ecommerce', 'Calculating Top-Ranked Items from EC Search Logs'
#   end
#   category 'performance', 'Performance' do
#     article 'avoid-nested-json', 'Avoiding Nested JSON Records'
#   end
# end

section 'reference', 'Reference' do
  category 'command-line', 'Command Line' do
    article 'using-the-cli', 'CLI Usage'
    article 'installing-the-cli', 'Installing the Treasure Data CLI'
  end
  category 'data-management', 'Data Management' do
    article 'database-and-table', 'Database and Table Management'
    article 'schema', 'Schema Management'
  end
  category 'data-import', 'Data Import' do
    article 'td-agent', 'Using td-agent'
    article 'td-agent-high-availability', "High-Availability 'td-agent' Configurations"
    article 'copy-plugin', 'Storing Logs into Treasure Data, and Storage X'
  end
  category 'data-processing', 'Data Processing' do
    article 'job', 'Job Management'
    article 'hive', 'Hive (SQL-like) Query Language'
    article 'pig', 'Pig Latin Language'
  end
  category 'bulk-operations', 'Bulk Operations' do
    article 'bulk-import', 'Bulk Import'
    article 'bulk-export', 'Bulk Export'
  end
  category 'api', 'REST API' do
    article 'rest-api', 'REST API Specification'
  end
end

section 'ab', 'Accounts & Billing' do
  # category 'accounts', 'Accounts' do
  #   article 'change-email-address', 'Changing your email address'
  #   article 'delete-account', 'Deleting the account'
  # end
  category 'support', 'Support' do
    article 'paid-support', 'Paid Support'
    article 'support-channels', 'Support Channels'
  end
end
