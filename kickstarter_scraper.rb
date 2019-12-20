require 'nokogiri'
require 'pry'

# projects: kickerstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text.strip
# location: project.css(".location-name").text.strip
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)
  
  project_hash = Hash.new

  kickstarter.css("li.project.grid_4").each do |project|
    attributes = project_hash[project.css("h2.bbcard_name strong a").text] = Hash.new 
    attributes[:image_link] = project.css("div.project-thumbnail a img").attribute("src").value
    attributes[:description] = project.css("p.bbcard_blurb").text.strip
    attributes[:location] = project.css(".location-name").text.strip
    attributes[:percent_funded] = project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i 
    # binding.pry
  end 
  project_hash
end

create_project_hash