# -*- coding: utf-8 -*-
section 'overview', 'Overview' do
  category 'getting-started', 'Getting Started' do
    article 'quickstart', 'Getting Started'
  end
  category 'platform-basics', 'Platform Basics' do
    article 'architecture-overview', 'Architecture Overview'
    article 'data-partitioning', 'Data Partitioning'
    article 'no-spof', 'No Single-Point-Of-Failure (SPOF)'
    article 'constraints', 'Constraints'
    article 'status', 'Platform Status'
    article 'open-source', 'Open Source'
  end
  category 'success-stories', 'Success Stories' do
    article 'success-at-mobfox', "MobFox - Europe's Largest Mobile Network"
    article 'success-at-contextlogic', 'ContextLogic - Top 150 Facebook App'
    article 'success-at-cookpad', 'Cookpad - Japan’s No.1 Recipe Sharing Site'
    article 'success-at-splurgy', 'Splurgy - Social Marketing Platform'
    article 'success-at-viki', 'Viki - Global Online Video Service'
  end
  category 'faq', 'FAQs' do
    article 'faq', 'Frequently Asked Questions'
  end
  category 'changelog', 'ChangeLog' do
    article 'changelog', 'Treasure Data ChangeLog'
  end
end

section 'interacting', 'Interacting with Treasure Data' do
  category 'command-line', 'Command Line Interface' do
    article 'using-the-cli', 'CLI Usage'
    article 'installing-the-cli', 'Installing the Treasure Data CLI'
  end
  category 'api', 'REST API' do
    article 'rest-api', 'REST API Specification'
    article 'rest-api-ruby-client', 'Using Ruby Binding of REST API'
    article 'rest-api-java-client', 'Using Java Binding of REST API'
    article 'rest-api-node-client', 'Using Node.js Binding of REST API'
  end
  category '3rd-party-tools-overview', 'Third Party Tools' do
    article 'tools', 'Overview'
    article 'jaspersoft-ireport', 'JasperSoft iReport', ['JasperSoft iReport']
    article 'jasperreports-server', 'JasperReports Server', ['JasperReports Server']
    article 'pentaho-reportdesigner', 'Pentaho Report Designer',    ['Pentaho Report Designer']
    article 'pentaho-dataintegration', 'Pentaho Data Integration'    ['Pentaho Data Integration']
    article 'r-language', 'R Language',                 ['R Language']
    article 'talend', 'Talend Open Studio',             ['Talend Open Studio']
    article 'metricinsights', 'Metric Insights',        ['Metric Insights']
    article 'indicee', 'Indicee Cloud BI Platform',     ['Indicee']
  end
  category 'driver', 'JDBC Driver' do
    article 'jdbc-driver', 'JDBC Driver'
  end
end

section 'import-data', 'Importing Data' do
  category 'td-agent-basic', 'Continuous Data Import with td-agent' do
    article 'td-agent', 'Using td-agent package',                                      ['fluentd', 'td-agent']
    article 'td-agent-high-availability', 'High-Availability td-agent Configurations', ['fluentd', 'td-agent']
    article 'td-agent-monitoring', 'Monitoring td-agent',                              ['fluentd', 'td-agent', 'monitoring']
  end
  category 'td-agent-advanced', 'Examples of using td-agent' do  
    article 'td-agent-tail', 'Tailing the Existing Log Files',                         ['fluentd', 'td-agent']
    article 'td-agent-copy', 'Storing Logs Locally and Remotely',                      ['fluentd', 'td-agent']
    article 'td-agent-http', 'Storing Logs via HTTP protocol',                         ['fluentd', 'td-agent']
    article 'td-agent-scribe', 'Storing Logs via Scribe protocol',                     ['fluentd', 'td-agent']
    article 'td-agent-changelog', 'ChangeLog of td-agent',                             ['fluentd', 'td-agent']
    article 'fluentd-to-treasure-data', 'Using Fluentd Ruby gem',                      ['fluentd']
  end
  category 'bulk-operations', 'Bulk Import Operations' do
    article 'one-time-import', 'Quick Import'
    article 'bulk-import', 'Bulk Import - Reliable Transactional Import'
    article 'bulk-export', 'Bulk Export'
  end
end

section 'query-data', 'Data Management and Querying' do
  category 'data-processing', 'Data Processing' do
    article 'job', 'Job Management'
    article 'schedule', 'Job Scheduling'
    article 'hive', 'Hive (SQL-style) Query Language', ['hive query language', 'hive sql', 'hive tutorial', 'hive manual']
    article 'udfs', 'Supported UDFs (User Defined Functions)'
    # article 'pig', 'Pig Latin Language'
  end
  category 'data-management', 'Data Management' do
    article 'database-and-table', 'Database and Table Management'
    article 'schema', 'Schema Management'
  end
  category 'performance-tuning', 'Performance Tuning' do
    article 'performance-tuning', 'Performance Tuning'
  end
  category 'data-deletion', 'Data Deletion' do
    article 'deletion', 'Data Deletion'
  end
  category 'result', 'Output Query Results' do
    article 'result-into-td', 'Writing the Job Result into Treasure Data'
    article 'result-into-mysql', 'Writing the Job Result into your MySQL'
    article 'result-into-postgresql', 'Writing the Job Result into your PostgreSQL'
    article 'result-into-google-spreadsheet', 'Writing the Job Result into Google SpreadSheet'
    article 'result-into-web', 'Sending the Job Result to Web Server'
    # article 'result-into-mongodb', 'Writing the Job Result into your MongoDB'
    # article 'result-into-redis', 'Writing the Job Result into your Redis'
    # article 'result-into-riak', 'Writing the Job Result into your Riak'
    # article 'result-into-dynamodb', 'Writing the Job Result into your DynamoDB'
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
    article 'analyzing-apache-logs', 'Analyzing Apache Logs on the Cloud', ['apache logs', 'apache log analysis', 'apache log analyzer']
  end
  category 'TwitterAnalytics', 'Twitter Data Analytics' do
    article 'analyzing-twitter-data', 'Analyzing Twitter Data on the Cloud', ['twitter data', 'twitter data analytics']
    article 'twitter-nodejs', 'Streaming Twitter Data into Treasure Data from Node.js', ['twitter data', 'twitter nodejs']
  end
end

section 'ab', 'Accounts & Billing' do
  category 'accounts', 'Accounts' do
    article 'change-password', 'Changing the Password'
    article 'access-control', 'Access Control'
  #   article 'change-email-address', 'Changing your email address'
  #   article 'delete-account', 'Deleting the account'
  end
  category 'support', 'Support' do
    article 'paid-support', 'Paid Support'
    article 'support-channels', 'Support Channels'
  end
end

section 'paas', 'PaaS' do
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
