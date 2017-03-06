require 'rss'
require_relative '../../lib/logging'

class RssFeedReader
  include Logging

  attr_reader :content

  def initialize(url, rss_str, count = 10)
    @url = url
    @rss_str = rss_str
    @count = count
    @content = []
  end

  def process
    rss = RSS::Parser.parse(@url, false)
    count = [rss.items.count, @count].min

    color_array = %w(green blue purple)

    rss.items[0 .. (@count - 1)].reverse.each_with_index do |item, idx|
      str = @rss_str.clone

      extracted_keys = @rss_str.scan(/&{(@\w*)}/).map do |key|
        key[0]
      end

      extracted_keys.each_with_index do |sanitised_key, idx|
        str.gsub!("&{#{sanitised_key}}", colorize(item.instance_variable_get(sanitised_key), color_array[idx]))
      end

      @content << ((count - idx).to_s + ". #{str}")
    end

    @content
  end

  private

  def colorize(text, color = 'default', bg_color = 'default')
    colors = {'default' => '38','black' => '30','red' => '31','green' => '32','brown' => '33', 'blue' => '34', 'purple' => '35',
              'cyan' => '36', 'gray' => '37', 'dark gray' => '1;30', 'light red' => '1;31', 'light green' => '1;32', 'yellow' => '1;33',
              'light blue' => '1;34', 'light purple' => '1;35', 'light cyan' => '1;36', 'white' => '1;37'}
    bgColors = {'default' => '0', 'black' => '40', 'red' => '41', 'green' => '42', 'brown' => '43', 'blue' => '44',
                'purple' => '45', 'cyan' => '46', 'gray' => '47', 'dark gray' => '100', 'light red' => '101', 'light green' => '102',
                'yellow' => '103', 'light blue' => '104', 'light purple' => '105', 'light cyan' => '106', 'white' => '107'}

    color_code = colors[color]
    bg_color_code = bgColors[bg_color]
    "\033[#{bg_color_code};#{color_code}m#{text}\033[0m"
  end

end