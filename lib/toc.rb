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
    article 'success-at-cloud9-ide', 'Cloud9 - Online IDE Service'
    article 'success-at-getjar', 'Getjar - One of the World’s Largest Mobile App Marketplaces'
    article 'success-at-reevoo', 'Reevoo - Leading Cloud-based Social Commerce'
  end
  category 'faq', 'FAQs' do
    article 'faq', 'Frequently Asked Questions'
  end
  category 'changelog', 'ChangeLog' do
    article 'changelog', 'Treasure Data ChangeLog'
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
  category 'one-time-import', 'One-Time Import' do
    article 'one-time-import', 'One-Time Import'
  end
  category 'td-agent-language', 'Streaming Import' do
    article 'td-agent', 'Streaming Import via HTTP POST',                ['fluentd', 'td-agent']
    article 'java', 'Streaming Import from Java Applications',           ['fluentd', 'td-agent']
    article 'ruby', 'Streaming Import from Ruby Applications',           ['fluentd', 'td-agent']
    article 'rails', 'Streaming Import from Ruby on Rails Applications', ['fluentd', 'td-agent']
    article 'python', 'Streaming Import from Python Applications',       ['fluentd', 'td-agent'] 
    article 'php', 'Streaming Import from PHP Applications',             ['fluentd', 'td-agent']
    article 'perl', 'Streaming Import from Perl Applications',           ['fluentd', 'td-agent']
    article 'nodejs', 'Streaming Import from Node.js Applications',      ['fluentd', 'td-agent']
    article 'scala', 'Streaming Import from Scala Applications',         ['fluentd', 'td-agent']
  end
  category 'td-agent-advanced', 'Streaming Import (Advanced)' do  
    article 'td-agent-high-availability', 'High-Availability td-agent Configurations', ['fluentd', 'td-agent']
    article 'td-agent-monitoring', 'Monitoring td-agent',                              ['fluentd', 'td-agent', 'monitoring']
    article 'td-agent-upgrade', 'Upgrading td-agent',                                  ['fluentd', 'td-agent']
    article 'td-agent-changelog', 'ChangeLog of td-agent',                             ['fluentd', 'td-agent']
    article 'td-agent-tail', 'Tailing the Existing Log Files',                         ['fluentd', 'td-agent']
    article 'td-agent-copy', 'Storing Logs Locally and Remotely',                      ['fluentd', 'td-agent']
    article 'td-agent-http', 'Storing Logs via HTTP protocol',                         ['fluentd', 'td-agent']
    article 'td-agent-scribe', 'Storing Logs via Scribe protocol',                     ['fluentd', 'td-agent']
    article 'fluentd-to-treasure-data', 'Using Fluentd Ruby gem',                      ['fluentd']
  end
  category 'bulk-import-category', 'Bulk Import' do
    article 'bulk-import', 'Bulk Import'
    article 'bulk-import-from-db', 'Import data from MySQL/PostgresSQL/MongoDB'
  end
  category 'mobile-sdk', 'Mobile SDK' do
    article 'android-mobile-sdk', 'Treasure Data Android SDK'
    article 'iphone-mobile-sdk', 'Treasure Data iPhone SDK'
  end
end

section 'query-data', 'Data Processing' do
  category 'data-set-management', 'Data Set Management' do
    article 'database-and-table', 'Database and Table Management'
    article 'schema', 'Schema Management'
  end
  category 'data-processing', 'Data Processing' do
    article 'job', 'Job Management'
    article 'schedule', 'Job Scheduling'
  end
  category 'data-deletion', 'Data Deletion' do
    article 'deletion', 'Data Deletion'
  end
  category 'data-export', 'Data Export' do
    article 'bulk-export', 'Bulk Data Export'
  end
  category 'performance-tuning', 'Performance Tuning' do
    article 'performance-tuning', 'Performance Tuning'
  end
  category 'result', 'Output Query Results' do
    article 'result-into-td', 'Writing Job Result into Treasure Data'
    article 'result-into-mysql', 'Writing Job Result into MySQL'
    article 'result-into-postgresql', 'Writing Job Result into PostgreSQL'
    article 'result-into-google-spreadsheet', 'Writing Job Result into Google SpreadSheet'
    article 'result-into-web', 'Sending Job Result to Web Server'
    article 'result-into-ftp', 'Sending Job Result to FTP Server'
    article 'result-into-s3', 'Writing Job Result to S3'
    article 'result-into-leftronic', 'Sending Job Result to Leftronic'
    # article 'result-into-mongodb', 'Writing the Job Result into your MongoDB'
    # article 'result-into-redis', 'Writing the Job Result into your Redis'
    # article 'result-into-riak', 'Writing the Job Result into your Riak'
    # article 'result-into-dynamodb', 'Writing the Job Result into your DynamoDB'
  end
end

section 'tools-and-apis', 'Tools & APIs' do
  category 'command-line', 'Command-line Interface' do
    # article 'using-the-cli', 'CLI Usage'
    # article 'installing-the-cli', 'Installing the Treasure Data CLI'
    article 'command-line', 'Command-line Interface'
  end
  category 'web-console', 'Web Console' do
    article 'web-console', 'Using the Web Console'
  end
  category 'api', 'REST API' do
    article 'rest-api', 'REST API Specification'
    article 'rest-api-ruby-client', 'Using Ruby Binding of REST API'
    article 'rest-api-java-client', 'Using Java Binding of REST API'
    article 'rest-api-node-client', 'Using Node.js Binding of REST API'
  end
  category 'jdbc', 'JDBC Driver' do
    article 'jdbc-driver', 'JDBC Driver'
  end
  # TODO: coming soon!
  # category 'odbc', 'ODBC Driver' do
  #   article 'odbc-deiver', 'ODBC Driver'
  # end
  category '3rd-party-tools-overview', 'Third Party BI/ETL Tools' do
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
end

section 'Language References', 'Language References' do
  category 'Hive QL Reference', 'Hive QL Reference' do
    article 'hive', 'Hive Query Language (HiveQL) Overview'
    article 'hive-operators', 'Hive Built-in Operators'
    article 'hive-functions', 'Hive Built-in Functions'
    article 'hive-aggregate-functions', 'Hive Built-in Aggregate Functions'
    article 'udfs', 'Hive Treasure Data UDFs'
  end
  category 'Pig Latin Reference', 'Pig Latin Reference' do
    article 'pig', 'Pig Latin Language'
  end
end

section 'accounts-and-billing', 'Accounts & Billing' do
  category 'accounts', 'Accounts' do
    article 'change-password', 'Changing the Password'
    article 'access-control', 'Access Control'
    article 'change-email-address', 'Changing your Email Address'
  #   article 'delete-account', 'Deleting the account'
  end
  category 'support', 'Support' do
    article 'paid-support', 'Paid Support'
    article 'support-channels', 'Support Channels'
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
  category 'engine-yard', 'EngineYard Addon' do
    article 'engine-yard-ruby', 'Ruby Apps on EngineYard'
    article 'engine-yard-rails', 'Rails Apps on EngineYard'
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

