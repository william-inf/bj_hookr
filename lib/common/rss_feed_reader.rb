require 'rss'
require_relative '../../lib/logging'

class RssFeedReader
  include Logging

  def initialize(url, count = 10)
    @url = url
    @rss_str = "&{@title} \nURL: &{@link} \nComments: &{@comments}\n\n"
    @count = count
    @content = []
  end

  def process
    rss = RSS::Parser.parse(@url, false)
    count = [rss.items.count, @count].min
    rss.items[0 .. (@count - 1)].reverse.each_with_index do |item, idx|
      str = @rss_str.clone

      extracted_keys = @rss_str.scan(/&{(@\w*)}/).map do |key|
        key[0]
      end

      extracted_keys.each do |sanitised_key|
        str.gsub!("&{#{sanitised_key}}", item.instance_variable_get(sanitised_key))
      end

      puts ((count - idx).to_s + ". #{str}")

    end
  end

end


RssFeedReader.new('https://news.ycombinator.com/rss', 10).process