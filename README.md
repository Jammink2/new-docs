# TD Docs App

Ultrasimple CMS and content for documentation of the Treasure Data platform.  The production site is [here](http://docs.treasuredata.com/). If you'd like to propose an edit to the TD docs, fork this repo, then send us a pull request.

# Install

    $ gem install bundler
    $ bundle install --path vendor/bundle
    $ bundle exec rake server
    $ open "http://localhost:9393/articles/quickstart"
    
# Generate the PDF Documentation

Prerequisites:

    $ ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" # install brew
    $ brew install pandoc # install pandoc
    => install BasicTex from http://www.tug.org/mactex/morepackages.html
    $ export PATH=${PATH}:/usr/local/texlive/2013basic/bin/x86_64-darwin
    
Execution:

    $ ruby scripts/generate_pdf.rb
    ==> upload updated PDF to https://pi.pardot.com/file/read/id/25362
    
# Acknowledgement

This program is forked from [heroku/heroku-docs](http://github.com/heroku/heroku-docs), and originally written by Ryan Tomayko and Adam Wiggins. Later, modified by Kazuki Ohta and Takahiro Inoue.

Code is released under the MIT License: http://www.opensource.org/licenses/mit-license.php

All rights reserved on the content (text files in the docs subdirectory), although you're welcome to modify these for the purpose of suggesting edits.
