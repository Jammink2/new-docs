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
  category 'faq', 'FAQs' do
    article 'faq', 'Frequently Asked Questions'
  end
  category 'releasenotes', 'Release Notes' do
    # NOTE: the releasenotes article is just a placeholder to give the page
    #       a title and heading. The actual content of the page is specified
    #       in the erb template 'view/releasenotes_redirect.erb.
    #       The 'get '/articles/:article' do' route redirect to the releasenotes
    #       article that uses the :releasenotes_redirect template.
    article 'releasenotes', 'Release Notes'
  end
end

section 'Usecases', 'Usecases' do
  category 'EnterpriseDataWarehouseAugmentation', 'Enterprise Data Warehouse Augumentation' do
    article 'enterprise-data-warehouse-augmentation', 'Enterprise Data Warehouse Augumentation', ['EDW augmentation', 'Enterprise Data Warehouse Augmentation']
  end
  category 'GameKPIReporting', 'Game KPI Reporting' do
    article 'analyzing-game-logs', 'Analyzing Game Logs on the Cloud', ['game log analysis']
  end
  category 'AdNetworkReporting', 'Ad-Network Reporting' do
    article 'analyzing-adnetwork-logs', 'Analyzing Ad-Network Logs on the Cloud', ['ad-network analysis']
  end
  category 'WeblogAnalytics', 'Weblog Analytics' do
    article 'analyzing-apache-logs', 'Analyzing Apache Logs on the Cloud', ['apache logs', 'apache log analysis', 'apache log analyzer']
  end
  category 'TwitterAnalytics', 'Twitter Data Analytics' do
    article 'analyzing-twitter-data', 'Analyzing Twitter Data on the Cloud', ['twitter data', 'twitter data analytics']
    article 'twitter-nodejs', 'Streaming Twitter Data into Treasure Data from Node.js', ['twitter data', 'twitter nodejs']
  end
end

section 'import-data', 'Data Import' do
  category 'import-overview', 'Overview' do
    article 'import-overview', 'Overview'
  end
  category 'td-agent-language', 'Streaming Import' do
    article 'td-agent', 'Streaming Import Overview', ['fluentd', 'td-agent']
    article 'java', 'Streaming Import from Java Applications',           ['fluentd', 'td-agent']
    article 'ruby', 'Streaming Import from Ruby Applications',           ['fluentd', 'td-agent']
    article 'rails', 'Streaming Import from Ruby on Rails Applications', ['fluentd', 'td-agent']
    article 'python', 'Streaming Import from Python Applications',       ['fluentd', 'td-agent']
    article 'php', 'Streaming Import from PHP Applications',             ['fluentd', 'td-agent']
    article 'perl', 'Streaming Import from Perl Applications',           ['fluentd', 'td-agent']
    article 'nodejs', 'Streaming Import from Node.js Applications',      ['fluentd', 'td-agent']
    article 'scala', 'Streaming Import from Scala Applications',         ['fluentd', 'td-agent']
    article 'td-agent-high-availability', 'Config: High-Availability td-agent Configurations', ['fluentd', 'td-agent']
    article 'td-agent-tail', 'Config: Tailing the Existing Log Files',                         ['fluentd', 'td-agent']
    article 'td-agent-copy', 'Config: Storing Logs Locally and Remotely',                      ['fluentd', 'td-agent']
    article 'td-agent-http', 'Config: Storing Logs via HTTP protocol',                         ['fluentd', 'td-agent']
    article 'td-agent-scribe', 'Config: Storing Logs via Scribe protocol',                     ['fluentd', 'td-agent']
    article 'fluentd-to-treasure-data', 'Ops: Using Fluentd Ruby gem',                      ['fluentd']
    article 'td-agent-monitoring', 'Ops: Monitoring td-agent',                              ['fluentd', 'td-agent', 'monitoring']
    article 'td-agent-upgrade', 'Ops: Upgrading td-agent',                                  ['fluentd', 'td-agent']
    article 'td-agent-changelog', 'Info: ChangeLog of td-agent',                             ['fluentd', 'td-agent']
  end
  category 'bulk-import-category', 'Bulk Import' do
    article 'bulk-import', 'Bulk Import Overview'
    article 'bulk-import-from-csv', 'Bulk Import from CSV file'
    article 'bulk-import-from-tsv', 'Bulk Import from TSV file'
    article 'bulk-import-from-json', 'Bulk Import from JSON file'
    article 'bulk-import-from-s3', 'Bulk Import from Amazon S3'
    article 'bulk-import-from-mysql', 'Bulk Import from MySQL'
    article 'bulk-import-from-postgres', 'Bulk Import from PostgreSQL'
    article 'bulk-import-from-mongodb', 'Bulk Import from MongoDB'
    article 'bulk-import-internal', 'Bulk Import Internals'
    article 'bulk-import-tips-and-tricks', 'Bulk Import Tips and Tricks'
  end
  category 'one-time-import', 'One-Time Import' do
    article 'one-time-import', 'One-Time Import'
  end
  category 'iphone-sdk', 'iPhone SDK' do
    article 'iphone-mobile-sdk', 'Treasure Data iPhone SDK'
  end
  category 'android-sdk', 'Android SDK' do
    article 'android-mobile-sdk', 'Treasure Data Android SDK'
  end
end

section 'query-data', 'Data Set Management' do
  category 'database-and-table', 'Database and Table' do
    article 'database-and-table', 'Database and Table'
  end
  category 'schema', 'Schema' do
    article 'schema', 'Schema Management'
  end
  category 'data-deletion', 'Data Deletion' do
    article 'deletion', 'Data Deletion'
  end
  category 'data-export', 'Data Export' do
    article 'bulk-export', 'Data Export'
  end
end

section 'Data Analysis', 'Data Analysis & Integration' do
  category 'data-analysis-overview', 'Overview' do
    article 'data-analysis-overview', 'Overview'
  end
  category 'job-management', 'Job Management' do
    article 'job', 'Job Management'
  end
  category 'hive', 'Hive QL Reference' do
    article 'hive', 'Hive Query Language (HiveQL) Overview'
    article 'hive-operators', 'Hive Built-in Operators'
    article 'hive-functions', 'Hive Built-in Functions'
    article 'hive-aggregate-functions', 'Hive Built-in Aggregate Functions'
    article 'udfs', 'Hive Treasure Data UDFs'
    article 'performance-tuning', 'Hive Performance Tuning'
  end
  category 'pig', 'Pig Latin Reference' do
    article 'pig', 'Pig Latin Language'
  end
  category 'scheduled-job', 'Scheduled Job' do
    article 'schedule', 'Scheduled Job'
  end
  category 'result', 'Query Result Output' do
    article 'result-into-td', 'Query Result Output to Treasure Data'
    article 'result-into-mysql', 'Query Result Output to MySQL'
    article 'result-into-postgresql', 'Query Result Output to PostgreSQL'
    article 'result-into-s3', 'Query Result Output to AWS S3'
    article 'result-into-redshift', 'Query Result Output to AWS Redshift'
    article 'result-into-google-spreadsheet', 'Query Result Output to Google SpreadSheet'
    article 'result-into-web', 'Query Result Output to Web Server (REST)'
    article 'result-into-ftp', 'Query Result Output to FTP Server'
    article 'result-into-leftronic', 'Query Result Output to Leftronic Dashboard'
  end
  category '3rd-party-tools-overview', 'Third Party BI/ETL Tools' do
    article 'tools', 'Overview'
    article 'tableau', 'Tableau Software', ['Tableau', 'Tableau Software']
    article 'metricinsights', 'Metric Insights',        ['Metric Insights']
    article 'jaspersoft-ireport', 'JasperSoft iReport', ['JasperSoft iReport']
    article 'jasperreports-server', 'JasperReports Server', ['JasperReports Server']
    article 'pentaho-reportdesigner', 'Pentaho Report Designer',    ['Pentaho Report Designer']
    article 'pentaho-dataintegration', 'Pentaho Data Integration'    ['Pentaho Data Integration']
    article 'r-language', 'R Language',                 ['R Language']
    article 'talend', 'Talend Open Studio',             ['Talend Open Studio']
    article 'indicee', 'Indicee Cloud BI Platform',     ['Indicee']
  end
end

section 'tools-and-apis', 'Tools & APIs' do
  category 'web-console', 'Web Console' do
    article 'web-console', 'Using the Web Console'
  end
  category 'command-line', 'Command-Line Interface' do
    # article 'using-the-cli', 'CLI Usage'
    # article 'installing-the-cli', 'Installing the Treasure Data CLI'
    article 'command-line', 'Command-Line Interface'
  end
  category 'jdbc', 'JDBC Driver' do
    article 'jdbc-driver', 'JDBC Driver'
  end
  # TODO: coming soon!
  # category 'odbc', 'ODBC Driver' do
  #   article 'odbc-deiver', 'ODBC Driver'
  # end
  category 'api', 'REST API' do
    article 'rest-api', 'REST API Specification'
    article 'rest-api-ruby-client', 'Using Ruby Binding of REST API'
    article 'rest-api-java-client', 'Using Java Binding of REST API'
    article 'rest-api-node-client', 'Using Node.js Binding of REST API'
  end
end

section 'support-and-billing', 'Support & Status' do
  category 'support', 'Support' do
    article 'support-channels', 'Support Channels'
  end
  category 'service-status', 'Service Status' do
    article 'service-status', 'Service Status'
  end
  category 'accounts', 'Accounts' do
    article 'change-password', 'Changing the Password'
    article 'access-control', 'Access Control'
    article 'change-email-address', 'Changing your Email Address'
  #   article 'delete-account', 'Deleting the account'
  end
end

section 'paas', 'PaaS' do
  category 'heroku', 'Heroku Addon' do
    article 'heroku-data-analytics', 'Data Analytics Solutions for Heroku'
    article 'heroku-data-import', 'Data Import from Heroku Apps'
    article 'heroku-ruby', 'Ruby Apps on Heroku'
    article 'heroku-rails', 'Rails Apps on Heroku'
    article 'heroku-java', 'Java Apps on Heroku'
    article 'heroku-rest', 'Data Import from REST API on Heroku'
    article 'heroku-share-apikey', 'Sharing API key from Multiple Heroku Apps'
    article 'heroku-notes', 'Heroku Addon Notes'
  end
  category 'beanstalk', 'Amazon Beanstalk' do
    article 'beanstalk', 'Apps on Amazon Beanstalk'
  end
end

section 'consulting', 'Consulting' do
  category 'setup-consultation', 'Setup Consultation' do
    article 'setup-consultation', "Setup Consultation by Treasure Data Engineers"
  end
  category 'scalability-consultation', 'Scalability Consultation' do
    article 'scalability-consultation', 'Scalability Consultation by Treasure Data Engineers'
  end
end

