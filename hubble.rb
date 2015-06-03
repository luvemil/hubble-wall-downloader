require 'nokogiri'
require 'net/http'

module Hubble
  @gallery_url = URI("http://hubblesite.org/gallery/wallpaper/")

  def self.get_links
    gallery = Net::HTTP.get @gallery_url
    doc = Nokogiri::HTML gallery
    gallery = doc.css "div#ListBlock.wallpaper"
    a_tags = gallery.children.select {|child| child.name == "a"}
    links = a_tags.map {|a_tag| a_tag.attributes["href"].value}
    return links
  end

  def self.get_image_node(path)
    page = Net::HTTP.get_response(@gallery_url.hostname, path+"1024_wallpaper/")
    if page.is_a?(Net::HTTPSuccess)
      doc = Nokogiri::HTML page.body
      imgs = doc.css "img"
      target = imgs[1]
      return target
    end
    return "Error"
  end

  def self.echo_image(node)
    name = node.attributes["alt"].value
    url = node.attributes["src"].value
    puts "#{url},#{name}"
  end
end
