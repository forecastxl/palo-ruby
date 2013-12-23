PALO engine of gem?

Proberen om PALO API na te bouwen?

Gem: alleen db communicatie
Engine: db communicatie én cube viewer, dimensie editor, etc

Wat moet het kunnen:

- Databases beheren
- Dimensies en elementen beheren
- Cube maken
- Cube gebruiken (lezen/schrijven) area/value/values
- Area/path objecten

# Api Levels

1) Palo API 'kopie' -> is eigenlijk dit ding
2) High level API   -> universeel ding, excel plugin achtig
3) App specific API -> om vanuit je app slim dingen te doen

Status

1) Klaar
2) Welke methodes?

- 

# SQL - PALO sync / ETL

Een gem die werkt als brug tussen active record en palo.
Gegeven een sterschema in sql; dimensies en facttable.
Transfer alle shit naar palo.
Verwerk tussentijdse mutaties in beide db systemen.

- geef bij een gewone active record class op of het een dimensie is,
  wat de kolom is om als element waarde te gebruiken, meer?
- geef bij de fact table op welke dimensies er worden gebruikt.
- maak een sync_sql_to_olap actie
- bij elke insert/update/delete in de sql db volgt er een palo actie
- de dimensies/elementen moeten ook worden gesynced
- hou bij wat de naam van de actuele palo db is, ook de schema versie?

## Configuratie

Palo db host en credentials
Dimensie info bij AR class
  dimension_name
  element_column
  hierarchy_descriptor?
  weight? / weight_method?
Facttable bij AR class
  dimensions (volgorde is belangrijk)
  value_column
  value_type?
Extra dimensies?

## API ideetjes

Ga uit van een database, bewerk dimensies, elementen en feiten.
years = db.dimensions['years']
years.insert('2020', position, children, weights) ??? is wel veel in 1 keer?
db.cell.insert(path, value)


## Problemen

Wat als een dimensie in palo bestaat uit een combi van twee sql dingen?
Zoals grootboeken en kpi's.
Meerdere dimensies uit 1 sql tabel.
Zoals het data_type bij de sql feiten tabel; realisatie of voorspelling. Of periods.
Wat is handiger: een universele AR/Palo sync gem, of een ETL script schrijven.
Voor backup/syncen is een script sneller te maken.
Voor on the fly updaten is een universeel ding strakker.
Voor een goede sync gem moet je je sql tables ook precies spiegelen aan het
hele olap verhaal: duidelijk dimensie tabellen en een genormaliseerde fact table.

Eventuele oplossingen/handvaten:

Insert/update/destroy wordt afgevangen vanuit de normal AR methodes, ga daar van uit.
Feiten invoeren gebeurt altijd met bestaande dimensie elementen.


## DSL ideetjes

class Department < ActiveRecord::Base
  include Palo::ActiveRecord::Dimension
  dimension :department, :name

  belongs_to :company
  has_many :financials
  validates :name, uniqueness: { scope: company_id } presence: true

end

class Periods < ActiveRecord::Base
  include Palo::ActiveRecord::Dimension
  dimension :year, :name, -> ( name[0, 4] )
  dimension :month, :name, -> ( name[5, 2] )

  belongs_to :company
  has_many :financials
  validates :name, uniqueness: { scope: company_id } presence: true

  # overwrite dit soort methods in gekke gevallen?
  def insert

  end
end

module Palo::ActiveRecord::Dimension
  def dimension(name, col, &block)
    Palo::ActiveRecord.dimensions << ??
  end
end

module Palo::ActiveRecord::Cube
  def dimensions(dim_names)

  end
end

module Palo::ActiveRecord
  
  
end