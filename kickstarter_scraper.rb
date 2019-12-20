require 'nokogiri'
require 'pry'

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
  end 
  project_hash
end