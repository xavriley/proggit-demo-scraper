# This is a template for a Ruby scraper on Morph (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'
# 
agent = Mechanize.new
#
# # Read in a page 
page = agent.get("http://www.reddit.com/r/programming")
#
# # Find somehing on the page using css selectors
table = page.css('div#siteTable > div.thing').each do |row|
  rank = row.at('span.rank').text
  score = row.at('div.unvoted div.score.unvoted').text
  domain = row.at('span.domain').text
  title = row.at('div.entry a.title').text

  # # Write out to the sqlite database using scraperwiki library
  ScraperWiki.save_sqlite(["title"], {
    rank: rank,
    score: score,
    domain: domain,
    title: title
  })
end
#

#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries. You can use whatever gems are installed
# on Morph for Ruby (https://github.com/openaustralia/morph-docker-ruby/blob/master/Gemfile) and all that matters
# is that your final data is written to an Sqlite database called data.sqlite in the current working directory which
# has at least a table called data.
