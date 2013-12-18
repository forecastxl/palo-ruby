PALO engine of gem?

Proberen om PALO API na te bouwen?

Gem: alleen db communicatie
Engine: db communicatie én cube viewer, dimensie editor, etc

Wat moet het kunnen:

- Databases beheren
- Dimensies en elementen beheren
- Cube maken
- Cube gebruiken (lezen/schrijven) area/value/values


# Voorbeeld code - Database maken

conn = Palo.connect(host, port, user, password)
response = conn.query("/server/databases", params)

res = conn.database_create(new_name, type)

paths = conn.path_for(database, cube)
paths[:department] = [1]
paths[:year] = [2013]
res = conn.cell_values(database, cube, paths)

# Raw queries werken
Maar hoe leg je hier een laagje over om alleen juiste commandos uit te voeren
en het resultaat als een array/hash te retourneren?

conn.server.databases(params)
 => "1;\"Eersteling\";17;24;2;0;535434414;\n"
moet worden:
 => [{database: 1, name_database: "Eersteling", number_dimensions: 17, number_cubes: 24, status: 'changed', type: 'normal', database_token: 535434414}]

 conn.element.rename


 Problemen:

 elke opdracht heeft een ander respons formaat
 plus, je krijgt het als CSV terug
 sommige return fields zijn numerieke status codes, omzetten naar text
 en: bouw een laag boven op de API, zoals de Excel API

 paths = {
  period: ['Juni', 'Juli'],
  year: 2013,
  product: "TOP(10) sellers"

 }
 conn.cell.values(paths)



 = DSL Probeersel

group "server"
  request "databases" do
    param :show_normal, default: 1, values: { 0 => "do not show normal databases", 1 => "show" }
    param :show_system, default: 0, values: { 0 => "do not show normal databases", 1 => "show" }
  end
end