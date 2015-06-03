require './hubble.rb'

links = Hubble.get_links

links.each do |link|
  res = Hubble.get_image_node link
  Hubble.echo_image(res) unless res == "Error"
end

