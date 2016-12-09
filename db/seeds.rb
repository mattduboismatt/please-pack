include FactoryGirl::Syntax::Methods

DatabaseCleaner.clean_with :truncation

top_chef = create(:pool, title: "Top Chef Charleston - Season 14")

annie = create(:contestant, pool: top_chef, first_name: "Annie", last_name: "Pettry", residence: "Louisville, KY", description: "Exec Chef / Owner, Decca")
bj = create(:contestant, pool: top_chef, first_name: "BJ", last_name: "Smith", residence: "Portland, OR", description: "Exec Chef / Owner, Smokehouse 21")
emily = create(:contestant, pool: top_chef, first_name: "Emily", last_name: "Hahn", residence: "Charleston, SC", description: "Chef, Warehouse Bar + Kitchen")
gerald = create(:contestant, pool: top_chef, first_name: "Gerlad", last_name: "Sombright", residence: "Marco Island, FL", description: "Chef de Cuisine, Ario")
jamie = create(:contestant, pool: top_chef, first_name: "Jamie", last_name: "Lynch", residence: "Charlotte, NC", description: "Exec Chef / Partner, 5Church Group")
jim = create(:contestant, pool: top_chef, first_name: "Jim", last_name: "Smith", residence: "Montgomery, AL", description: "Exec Chef, State of Alabama")
silvia = create(:contestant, pool: top_chef, first_name: "Silvia", last_name: "Barban", residence: "Brooklyn, NY", description: "Chef / Owner, Aita and LaRina")
sylva = create(:contestant, pool: top_chef, first_name: "Sylva", last_name: "Senat", residence: "Philadelphia, PA", description: "Exec Chef, Maison208")
amanada = create(:contestant, pool: top_chef, first_name: "Amanda", last_name: "Baumgarten", residence: "Chicago, IL", description: "Bartender, The Victor Bar")
brooke = create(:contestant, pool: top_chef, first_name: "Brooke", last_name: "Williamson", residence: "Los Angeles, CA", description: "Exec Chef / Owner, Playa Provisions")
casey = create(:contestant, pool: top_chef, first_name: "Casey", last_name: "Thompson", residence: "Napa Valley, CA", description: "Exec Chef, Inn at Rancho Santa Fe")
john = create(:contestant, pool: top_chef, first_name: "John", last_name: "Tesar", residence: "Dallas, TX", description: "Chef / Partner, Knife at the Highland")
katsuji = create(:contestant, pool: top_chef, first_name: "Katsuji", last_name: "Tanabe", residence: "Los Angeles, CA", description: "Exec Chef / Owner, Mexikosher")
sam = create(:contestant, pool: top_chef, first_name: "Sam", last_name: "Talbot", residence: "Brooklyn, NY", description: "Exef Chef / Owner, Pretty Southern")
sheldon = create(:contestant, pool: top_chef, first_name: "Sheldon", last_name: "Simeon", residence: "Lahaina, HI", description: "Exef Chef / Owner, Tin Roof")
shirley = create(:contestant, pool: top_chef, first_name: "Shirley", last_name: "Chung", residence: "Orange County, CA", description: "Chef / Partner, Twenty Eight")

matt = create(:entry, pool: top_chef, name: "Matt")
tom = create(:entry, pool: top_chef, name: "Tom")
jason = create(:entry, pool: top_chef, name: "Jason")
courtney = create(:entry, pool: top_chef, name: "Courtney")
steve = create(:entry, pool: top_chef, name: "Steve")

[sheldon, shirley, brooke, emily, john, jamie].each { |contestant| create(:pick, entry: matt, contestant: contestant) }
[sam, silvia, shirley, brooke, sylva, jamie].each { |contestant| create(:pick, entry: steve, contestant: contestant) }
[jamie, sam, sheldon, shirley, silvia, brooke].each { |contestant| create(:pick, entry: tom, contestant: contestant) }
[brooke, casey, jim, jamie, john, annie].each { |contestant| create(:pick, entry: jason, contestant: contestant) }
[silvia, jim, sam, shirley, sylva, brooke].each { |contestant| create(:pick, entry: courtney, contestant: contestant) }
