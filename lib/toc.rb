section 'overview', 'Overview' do
  category 'getting-started', 'Getting Started' do
    article 'quickstart', 'Getting Started with Treasure Data'
  end
  category 'platform-basics', 'Platform Basics' do
    article 'architecture-overview', 'Architecture Overview'
    article 'data-partitioning', 'Data Partitioning'
    article 'no-spof', 'No Single-Point-Of-Failure (SPOF)'
    article 'constraints', 'Constraints'
  end
  category 'success-stories', 'Success Stories' do
    article 'success-at-contextlogic', 'ContextLogic - Top 150 Facebook App'
    article 'success-at-cookpad', 'Cookpad - Japan’s No.1 recipe website'
  end
  category 'changelog', 'ChangeLog' do
    article 'changelog', 'Treasure Data ChangeLog'
  end
  category 'faq', 'FAQs' do
    article 'faq', 'Frequently Asked Questions'
  end
end

section 'languages-and-middlewares', 'Languages' do
  category 'java', 'Java' do
    article 'java', 'Data Import from Java Applications',           ['fluentd', 'td-agent']
  end
  category 'ruby', 'Ruby' do
    article 'ruby', 'Data Import from Ruby Applications',           ['fluentd', 'td-agent']
    article 'rails', 'Data Import from Ruby on Rails Applications', ['fluentd', 'td-agent']
  end
  category 'python', 'Python' do
    article 'python', 'Data Import from Python Applications',       ['fluentd', 'td-agent'] 
  end
  category 'php', 'PHP' do
    article 'php', 'Data Import from PHP Applications',             ['fluentd', 'td-agent']
  end
  category 'perl', 'Perl' do
    article 'perl', 'Data Import from Perl Applications',           ['fluentd', 'td-agent']
  end
  category 'nodejs', 'Node.js' do
    article 'nodejs', 'Data Import from Node.js Applications',      ['fluentd', 'td-agent']
  end
  category 'scala', 'Scala' do
    article 'scala', 'Data Import from Scala Applications',         ['fluentd', 'td-agent']
  end
end

section 'Usecases', 'Usecases' do
  category 'WeblogAnalytics', 'Weblog Analytics' do
    article 'apache', 'Analyzing Apache Logs on the Cloud', ['apache logs', 'apache log analysis', 'apache log analyzer']
#     article 'game', 'Analyzing Social Gaming Logs'
#     article 'ec', 'Analyzing E-Commerce Logs'
#     article 'adtech', 'Analyzing Ad-Server Logs'
#     article 'ranking', 'Calculating Daily Rankings'
  end
end

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
    article 'td-agent', 'Using td-agent package',                                      ['fluentd', 'td-agent']
    article 'td-agent-high-availability', 'High-Availability td-agent Configurations', ['fluentd', 'td-agent']
    article 'td-agent-tail', 'Tailing the Existing Log Files',                         ['fluentd', 'td-agent']
    article 'td-agent-copy', 'Storing Logs Locally and Remotely',                      ['fluentd', 'td-agent']
    article 'td-agent-http', 'Storing Logs via HTTP protocol',                         ['fluentd', 'td-agent']
    article 'td-agent-scribe', 'Storing Logs via Scribe protocol',                     ['fluentd', 'td-agent']
    article 'td-agent-changelog', 'ChangeLog of td-agent',                             ['fluentd', 'td-agent']
    article 'fluentd-to-treasure-data', 'Using Fluentd Ruby gem',                      ['fluentd']
  end
  category 'data-processing', 'Data Processing' do
    article 'job', 'Job Management'
    article 'schedule', 'Scheduled Job'
    article 'hive', 'Hive (SQL-style) Query Language', ['hive query language', 'hive sql', 'hive tutorial', 'hive manual']
    # article 'pig', 'Pig Latin Language'
  end
  category 'data-deletion', 'Data Deletion' do
    article 'deletion', 'Data Deletion'
  end
  category 'result', 'Result Output' do
    article 'result-into-td', 'Writing the Job Result into Treasure Data'
    article 'result-into-mysql', 'Writing the Job Result into your MySQL'
    article 'result-into-postgresql', 'Writing the Job Result into your PostgreSQL'
    article 'result-into-google-spreadsheet', 'Writing the Job Result into Google SpreadSheet'
    # article 'result-into-mongodb', 'Writing the Job Result into your MongoDB'
    # article 'result-into-redis', 'Writing the Job Result into your Redis'
    # article 'result-into-riak', 'Writing the Job Result into your Riak'
    # article 'result-into-dynamodb', 'Writing the Job Result into your DynamoDB'
  end
  category 'bulk-operations', 'Bulk Operations' do
    article 'one-time-import', 'One-Time Import'
    article 'bulk-import', 'Bulk Import'
    article 'bulk-export', 'Bulk Export'
  end
  category 'heroku', 'Heroku Addon' do
    article 'heroku-ruby', 'Ruby Apps on Heroku'
    article 'heroku-rails', 'Rails Apps on Heroku'
    article 'heroku-java', 'Java Apps on Heroku'
    article 'heroku-rest', 'Data Import from REST API on Heroku'
    article 'heroku-notes', 'Heroku Addon Notes'
  end
  category 'engine-yard', 'EngineYard Addon' do
    article 'engine-yard-ruby', 'Ruby Apps on EngineYard'
    article 'engine-yard-rails', 'Rails Apps on EngineYard'
  end
end

section 'ab', 'Accounts & Billing' do
  category 'accounts', 'Accounts' do
    article 'change-password', 'Changing the Password'
  #   article 'change-email-address', 'Changing your email address'
  #   article 'delete-account', 'Deleting the account'
  end
  category 'support', 'Support' do
    article 'paid-support', 'Paid Support'
    article 'support-channels', 'Support Channels'
  end
end

section 'tools', 'Tools & Specs' do
  category '3rd-party-tools-overview', 'Overview' do
    article 'tools', 'Tools'
  end
  category 'api', 'REST API' do
    article 'rest-api', 'REST API Specification'
    article 'rest-api-ruby-client', 'Using Ruby Binding of REST API'
    article 'rest-api-java-client', 'Using Java Binding of REST API'
  end
  category 'driver', 'JDBC Driver' do
    article 'jdbc-driver', 'JDBC Driver'
  end
  category 'bi-etl-tools', 'BI / ETL Tools' do
    article 'jaspersoft-ireport', 'JasperSoft iReport', ['JasperSoft iReport']
    article 'pentaho', 'Pentaho Business Analytics',    ['Pentaho Business Analytics']
    article 'r-language', 'R Language',                 ['R Language']
    article 'talend', 'Talend Open Studio',             ['Talend Open Studio']
    article 'metricinsights', 'Metric Insights',        ['Metric Insights']
    article 'indicee', 'Indicee Cloud BI Platform',     ['Indicee']
  end
end
