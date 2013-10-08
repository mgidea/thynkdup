# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
categories = ["accounting","finance","admin","architecture",
"engineering","art","media","design","biotech", "science","business","management",
"customer service","education","food","healthcare","construction","government",
"human resources","software engineers","software developers","legal","paralegal",
"manufacturing","marketing","public relations","advertising","medical","nonprofit",
"realestate","retail","wholesale","sales","fitness","security","skilled trade","crafts",
"networking","social network","transport","design","publishing"]

categories.each do |category|
  record = Category.where(name: category).first
  if record.nil?
    record = Category.new(name: category)
  else
    record.assign_attributes(name: category)
  end
  record.save!
end
