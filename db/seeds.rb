include FactoryGirl::Syntax::Methods

DatabaseCleaner.clean_with :truncation

top_chef = create(:pool, title: "Top Chef Charleston - Season 14")

create(:contestant, pool: top_chef, first_name: "Annie", last_name: "Pettry", residence: "Louisville, KY", description: "Exec Chef / Owner, Decca")
create(:contestant, pool: top_chef, first_name: "BJ", last_name: "Smith", residence: "Portland, OR", description: "Exec Chef / Owner, Smokehouse 21")
create(:contestant, pool: top_chef, first_name: "Emily", last_name: "Hahn", residence: "Charleston, SC", description: "Chef, Warehouse Bar + Kitchen")
create(:contestant, pool: top_chef, first_name: "Gerlad", last_name: "Sombright", residence: "Marco Island, FL", description: "Chef de Cuisine, Ario")
create(:contestant, pool: top_chef, first_name: "Jamie", last_name: "Lynch", residence: "Charlotte, NC", description: "Exec Chef / Partner, 5Church Group")
create(:contestant, pool: top_chef, first_name: "Jim", last_name: "Smith", residence: "Montgomery, AL", description: "Exec Chef, State of Alabama")
create(:contestant, pool: top_chef, first_name: "Silvia", last_name: "Barban", residence: "Brooklyn, NY", description: "Chef / Owner, Aita and LaRina")
create(:contestant, pool: top_chef, first_name: "Sylva", last_name: "Senat", residence: "Philadelphia, PA", description: "Exec Chef, Maison208")
create(:contestant, pool: top_chef, first_name: "Amanda", last_name: "Baumgarten", residence: "Chicago, IL", description: "Bartender, The Victor Bar")
create(:contestant, pool: top_chef, first_name: "Brooke", last_name: "Williamson", residence: "Los Angeles, CA", description: "Exec Chef / Owner, Playa Provisions")
create(:contestant, pool: top_chef, first_name: "Casey", last_name: "Thompson", residence: "Napa Valley, CA", description: "Exec Chef, Inn at Rancho Santa Fe")
create(:contestant, pool: top_chef, first_name: "John", last_name: "Tesar", residence: "Dallas, TX", description: "Chef / Partner, Knife at the Highland")
create(:contestant, pool: top_chef, first_name: "Katsuji", last_name: "Tanabe", residence: "Los Angeles, CA", description: "Exec Chef / Owner, Mexikosher")
create(:contestant, pool: top_chef, first_name: "Sam", last_name: "Talbot", residence: "Brooklyn, NY", description: "Exef Chef / Owner, Pretty Southern")
create(:contestant, pool: top_chef, first_name: "Sheldon", last_name: "Simeon", residence: "Lahaina, HI", description: "Exef Chef / Owner, Tin Roof")
create(:contestant, pool: top_chef, first_name: "Shirley", last_name: "Chung", residence: "Orange County, CA", description: "Chef / Partner, Twenty Eight")

%w(Steve Tom Jason Courtney Matt).each do |name|
  create(:entry, pool: top_chef, name: name, points: 0)
end
