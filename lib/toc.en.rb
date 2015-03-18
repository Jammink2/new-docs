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
    article 'data-deduplication', 'Data De-duplication'
    article 'open-source', 'Open Source'
  end
  category 'videos', 'Education Videos' do
    article 'videos', 'Education Videos'
  end
  category 'releasenotes', 'Release Notes' do
    article 'releasenote-20150310', 'Release Note 20150310'
    article 'releasenote-20150224', 'Release Note 20150224'
    article 'releasenote-20150217', 'Release Note 20150217'
    article 'releasenote-20150211', 'Release Note 20150211'
    article 'releasenote-20150203', 'Release Note 20150203'
    article 'releasenote-20150127', 'Release Note 20150127'
    article 'releasenote-20150120', 'Release Note 20150120'
    article 'releasenote-20150113', 'Release Note 20150113'
    article 'releasenote-20150106', 'Release Note 20150106'
    article 'releasenote-20141223', 'Release Note 20141223'
    article 'releasenote-20141216', 'Release Note 20141216'
    article 'releasenote-20141209', 'Release Note 20141209'
    article 'releasenote-20141202', 'Release Note 20141202'
    article 'releasenote-20141125', 'Release Note 20141125'
    article 'releasenote-20141118', 'Release Note 20141118'
    article 'releasenote-20141111', 'Release Note 20141111'
    article 'releasenote-20141104', 'Release Note 20141104'
    article 'releasenote-20141028', 'Release Note 20141028'
    article 'releasenote-20141021', 'Release Note 20141021'
    article 'releasenote-20141014', 'Release Note 20141014'
    article 'releasenote-20141007', 'Release Note 20141007'
    article 'releasenote-20140930', 'Release Note 20140930'
    article 'releasenote-20140923', 'Release Note 20140923'
    article 'releasenote-20140916', 'Release Note 20140916'
    article 'releasenote-20140909', 'Release Note 20140909'
    article 'releasenote-20140902', 'Release Note 20140902'
    article 'releasenote-20140826', 'Release Note 20140826'
    article 'releasenote-20140819', 'Release Note 20140819'
    article 'releasenote-20140812', 'Release Note 20140812'
    article 'releasenote-20140805', 'Release Note 20140805'
    article 'releasenote-20140729', 'Release Note 20140729'
    article 'releasenote-20140722', 'Release Note 20140722'
    article 'releasenote-20140715', 'Release Note 20140715'
    article 'releasenote-20140708', 'Release Note 20140708'
    article 'releasenote-20140701', 'Release Note 20140701'
    article 'releasenote-20140624', 'Release Note 20140624'
    article 'releasenote-20140617', 'Release Note 20140617'
    article 'releasenote-20140610', 'Release Note 20140610'
    article 'releasenote-20140603', 'Release Note 20140603'
    article 'releasenote-20140527', 'Release Note 20140527'
    article 'releasenote-20140520', 'Release Note 20140520'
    article 'releasenote-20140513', 'Release Note 20140513'
    article 'releasenote-20140506', 'Release Note 20140506'
    article 'releasenote-20140429', 'Release Note 20140429'
    article 'releasenote-20140422', 'Release Note 20140422'
    article 'releasenote-20140415', 'Release Note 20140415'
    article 'releasenote-20140408', 'Release Note 20140408'
    article 'releasenote-20140401', 'Release Note 20140401'
    # NOTE: the releasenotes article is just a placeholder to give the page
    #       a title and heading. The actual content of the page is specified
    #       in the erb template 'view/releasenotes_redirect.erb.
    #       The "get '/articles/:article' do" route redirect to the releasenotes
    #       article that uses the :releasenotes_redirect template.
    article 'legacy-releasenotes', 'Legacy Release Notes'
  end
  category 'faq', 'FAQs' do
    article 'faq', 'Frequently Asked Questions'
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
  category 'file-import', 'Browser File Import' do
    article 'file-import', 'Browser File Import'
  end
  # 2014/05/13 Kazuki Ohta <k@treasure-data.com>
  # Removed, because it confused the people by the distinction between one-time
  # and bulk import.
  # category 'one-time-import', 'One-Time Import' do
  #   article 'one-time-import', 'One-Time Import'
  # end
  category 'javascript-sdk', 'JavaScript SDK' do
    article 'javascript-sdk', 'JavaScript SDK'
  end
  category 'mobile-sdks', 'Mobile SDKs' do
    article 'ios-sdk', 'iOS SDK'
    article 'android-sdk', 'Android SDK'
    article 'unity-sdk', 'Unity SDK'
  end
  category 'app-sdks', 'App SDKs' do
    article 'java-sdk', 'Java SDK'
    article 'ruby-sdk', 'Ruby SDK'
  end
  category 'streaming-import', 'Streaming Import' do
    article 'td-agent', 'Streaming Import Overview',                                           ['fluentd', 'td-agent']
    article 'java', 'Streaming Import from Java Applications',                                 ['fluentd', 'td-agent']
    article 'ruby', 'Streaming Import from Ruby Applications',                                 ['fluentd', 'td-agent']
    article 'rails', 'Streaming Import from Ruby on Rails Applications',                       ['fluentd', 'td-agent']
    article 'python', 'Streaming Import from Python Applications',                             ['fluentd', 'td-agent']
    article 'php', 'Streaming Import from PHP Applications',                                   ['fluentd', 'td-agent']
    article 'perl', 'Streaming Import from Perl Applications',                                 ['fluentd', 'td-agent']
    article 'nodejs', 'Streaming Import from Node.js Applications',                            ['fluentd', 'td-agent']
    article 'scala', 'Streaming Import from Scala Applications',                               ['fluentd', 'td-agent']
    article 'dotnet', 'Streaming Import from .NET Applications',                               ['fluentd', 'td-agent']
    article 'td-agent-tail-apache', 'Tailing Apache Access Logs'
    article 'td-agent-tail-nginx', 'Tailing Nginx Access Logs'
    article 'td-agent-tail-ctltsv', 'Tailing CSV/TSV/LTSV Formatted Logs'
    article 'td-agent-tail-json', 'Tailing from JSON Formatted Logs'
    article 'td-agent-tail-custom', 'Tailing from Custom Formatted Logs'
    article 'td-agent-high-availability', 'Config: High-Availability td-agent Configurations', ['fluentd', 'td-agent']
    article 'td-agent-copy', 'Config: Storing Logs Locally and Remotely',                      ['fluentd', 'td-agent']
    article 'td-agent-http', 'Config: Storing Logs via HTTP protocol',                         ['fluentd', 'td-agent']
    article 'td-agent-scribe', 'Config: Storing Logs via Scribe protocol',                     ['fluentd', 'td-agent']
    article 'fluentd-to-treasure-data', 'Ops: Using Fluentd Ruby gem',                         ['fluentd']
    article 'td-agent-monitoring', 'Ops: Monitoring td-agent',                                 ['fluentd', 'td-agent', 'monitoring']
    article 'td-agent-upgrade', 'Ops: Upgrading td-agent',                                     ['fluentd', 'td-agent']
    article 'treasure-agent-monitoring-service', 'Ops: Monitoring td-agent from the Console',  ['fluentd', 'td-agent', 'monitoring', 'console']
    article 'td-agent-changelog', 'Info: ChangeLog of td-agent',                               ['fluentd', 'td-agent']
  end
  category 'bulk-import', 'Bulk Import' do
    article 'bulk-import', 'Bulk Import Overview'
    article 'bulk-import-from-csv', 'Bulk Import from CSV file'
    article 'bulk-import-from-tsv', 'Bulk Import from TSV file'
    article 'bulk-import-from-json', 'Bulk Import from JSON file'
    article 'bulk-import-from-s3', 'Bulk Import from Amazon S3'
    article 'bulk-import-from-mysql', 'Bulk Import from MySQL'
    article 'bulk-import-from-postgresql', 'Bulk Import from PostgreSQL'
    article 'bulk-import-from-mongodb', 'Bulk Import from MongoDB'
    article 'bulk-import-internal', 'Bulk Import Internals'
    article 'bulk-import-tips-and-tricks', 'Bulk Import Tips and Tricks'
  end
  category 'iot-devices', 'IoT Devices' do
    article 'sensor-data-analytics-with-raspberrypi', 'Raspberry Pi'
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
  category 'data-merging', 'Merging Data' do
    article 'merging', 'Merging Data'
  end
end

section 'data-processing', 'Data Processing' do
  category 'data-processing-overview', 'Overview' do
    article 'data-processing-overview', 'Overview'
  end
  category 'job-management', 'Job Management' do
    article 'job', 'Job Management'
  end
  category 'scheduled-job', 'Scheduled Job' do
    article 'schedule', 'Scheduled Job (Web Console)'
    article 'schedule-cli', 'Scheduled Job (CLI)'
  end
  category 'result', 'Job Result Output' do
    article 'result-into-td', 'Job Result Output to Treasure Data'
    article 'result-into-mysql', 'Job Result Output to MySQL'
    article 'result-into-postgresql', 'Job Result Output to PostgreSQL'
    article 'result-into-s3', 'Job Result Output to AWS S3'
    article 'result-into-redshift', 'Job Result Output to AWS Redshift'
    article 'result-into-google-spreadsheet', 'Job Result Output to Google SpreadSheet'
    article 'result-into-salesforce', 'Job Result Output to Salesforce.com (SFDC)'
    article 'result-into-web', 'Job Result Output to Web Server (REST)'
    article 'result-into-ftp', 'Job Result Output to FTP Server'
    article 'result-into-tableau-server', 'Job Result Output to Tableau Server'
    article 'result-into-tableau-online', 'Job Result Output to Tableau Online'
    article 'result-into-leftronic', 'Job Result Output to Leftronic Dashboard'
  end
  category 'hive', 'Hive QL Reference' do
    article 'hive', 'Hive Query Language (HiveQL) Overview'
    article 'hive-query-templates', 'Hive Query Templates'
    article 'hive-operators', 'Hive Built-in Operators'
    article 'hive-functions', 'Hive Built-in Functions'
    article 'hive-aggregate-functions', 'Hive Built-in Aggregate Functions'
    article 'udfs', 'Hive Treasure Data UDFs'
    article 'performance-tuning', 'Hive Performance Tuning'
  end
  category 'pig', 'Pig Latin Reference' do
    article 'pig', 'Pig Latin Language'
  end
  category 'presto', 'Presto Query Reference' do
    article 'presto', 'Presto Query Engine'
    article 'presto-query-templates', 'Presto Query Templates'
    article 'presto-udfs', 'Presto UDFs'
    article 'presto-postgresql-gateway', 'Presto PostgreSQL Gateway'
    article 'presto-performance-tuning', 'Presto Performance Tuning'
    article 'presto-known-limitations', 'Presto Known Limitations'
  end
end
section 'bi-etl-tools', 'BI / ETL / Workflow Tools' do
  category 'overview', 'Overview' do
    article 'tools', 'Overview'
  end
  category 'excel', 'Excel' do
    article 'excel-odbc', 'Excel', ['Excel']
  end
  category 'tableau', 'Tableau' do
    article 'tableau', 'Tableau + Treasure Data Reference Architecture', ['Tableau', 'Treasure Data']
    article 'tableau-server', 'Tableau Server', ['Tableau', 'Tableau Server']
    article 'tableau-online', 'Tableau Online', ['Tableau', 'Tableau Online']
    article 'tableau-desktop-odbc', 'Tableau Desktop', ['Tableau', 'Tableau Desktop']
  end
  category 'metricinsights', 'Metric Insights' do
    article 'metricinsights', 'Metric Insights', ['Metric Insights']
  end
  category 'luigi', 'Luigi Workflow Engine' do
    article 'luigi', 'Luigi Workflow Engine', ['Luigi']
  end
  category 'qlikview', 'QlikView' do
    article 'qlikview', 'QlikView', ['QlikView']
  end
  category 'birst', 'Birst' do
    article 'birst', 'Birst with Treasure Data', ['Birst']
  end
  category 'chartio', 'Chartio' do
    article 'chartio', 'Chartio with Treasure Data', ['Chartio']
  end
  category 'informatica-cloud', 'Informatica Cloud' do
    article 'informatica-cloud', 'Informatica Cloud', ['Informatica Cloud']
  end
  category 'talend', 'Talend' do
    article 'talend', 'Talend Open Studio',             ['Talend Open Studio']
  end
  category 'squirrelsql', 'SQuirreL SQL' do
    article 'squirrelsql', 'SQuirrel SQL with Treasure Data', ['SQuirrelSQL', 'SQuirrel SQL']
  end
  category 'sqlworkbench', 'SQL Workbench/J' do
    article 'sqlworkbench', 'SQL Workbench/J with Treasure Data', ['SQL Workbench/J']
  end
  category 'jaspersoft', 'JasperSoft' do
    article 'jaspersoft-ireport', 'JasperSoft iReport', ['JasperSoft iReport']
    article 'jasperreports-server', 'JasperReports Server', ['JasperReports Server']
  end
  category 'pentaho', 'Pentaho' do
    article 'pentaho-reportdesigner', 'Pentaho Report Designer', ['Pentaho Report Designer']
    article 'pentaho-dataintegration', 'Pentaho Data Integration', ['Pentaho Data Integration']
  end
  category 'r-language', 'R Language' do
    article 'r-language', 'R Language',                 ['R Language']
  end
  # category 'indicee', 'Indicee' do
  #   article 'indicee', 'Indicee Cloud BI Platform',     ['Indicee']
  # end
end

section 'tools-and-drivers', 'Tools & Drivers' do
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
  category 'odbc', 'ODBC Driver' do
    article 'odbc-driver-32bit', 'ODBC Driver for 32bit Application)'
  end
end

section 'apis', 'REST API' do
  category 'api-specification', 'REST API Reference' do
    article 'rest-api', 'REST API Specification'
  end
  category 'ruby-client', 'Ruby Client' do
    article 'rest-api-ruby-client', 'Using Ruby Binding of REST API'
  end
  category 'java-client', 'Java Client' do
    article 'rest-api-java-client', 'Using Java Binding of REST API'
  end
  category 'python-client', 'Python Client' do
    article 'rest-api-python-client', 'Using Python Binding of REST API'
  end
  category 'go-client', 'Go Client' do
    article 'rest-api-go-client', 'Using Go Binding of REST API'
  end
  category 'ndoe-client', 'Node.js Client' do
    article 'rest-api-node-client', 'Using Node.js Binding of REST API'
  end
end

section 'support-and-billing', 'Support & Status' do
  category 'accounts', 'Accounts' do
    article 'get-apikey', 'Get API Key'
    article 'change-password', 'Changing the Password'
    article 'access-control', 'Access Control'
    article 'change-email-address', 'Changing your Email Address'
  #   article 'delete-account', 'Deleting the account'
  end
  category 'support', 'Support' do
    article 'support-channels', 'Support Channels'
  end
  category 'service-status', 'Service Status' do
    article 'service-status', 'Service Status'
  end
  category 'setup-consultation', 'Setup Consultation' do
    article 'setup-consultation', "Setup Consultation by Treasure Data Engineers"
  end
  category 'scalability-consultation', 'Scalability Consultation' do
    article 'scalability-consultation', 'Scalability Consultation by Treasure Data Engineers'
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
