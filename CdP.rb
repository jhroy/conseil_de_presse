#!/usr/bin/env ruby

require "csv"
require "nokogiri"
require "open-uri"

# Création d'un fichier pour accueillir les résultats

fichier = "CdP.csv"

decisions = []

for n in 1..189 do # boucle qui ratisse chacune des 189 pages des résultats de recherche du site web du Conseil de presse

	url1 = "http://conseildepresse.qc.ca/decisions/page/"
	url2 = "/?date&media&categorie"

	url = url1 + n.to_s + url2
	puts url # vérification pendant que le script roule.

# Utilisation de la bibliothèque Nokogiri pour extraire les
# URLs menant aux décisions du Conseil de presse.
# Je passe 5 fois parce que je me suis rendu compte que l'affichage
# des résultats de recherche n'était pas toujours constant

	for f in 1..5 do
		
		resultat = Nokogiri::HTML(open(url))	

	# Utilisation de la méthode CSS pour aller chercher les hyperliens
	# dans les pages des résultats de recherche du CdeP.

		page = resultat.css("div.link a").map {|lien| lien["href"]}

	# Ajout des urls trouvées dans la matrice decisions

		page.each do |dec|
			decisions.push dec
		end

	end

end

decisions = decisions.uniq # élimination des doublons

# initialisation de variables

title =[]
content = []
tout = [] # matrice de l'ensemble des décisions du Conseil de Presse

decisions.each { |urlDecision|

	puts "---"
	puts urlDecision # vérification pendant que le script roule.
	decision = Hash.new # initialisation d'un hash dans lequel seront consignées les données de chaque décision

	d = Nokogiri::HTML(open(urlDecision))
	date = d.css("div.date").text.strip
	code = d.css("span.current").text.strip
	puts code # vérification pendant que le script roule.
	puts date # vérification pendant que le script roule.

	decision[:"Numéro de décision"] = code
	decision[:Date] = date
	
	for i in 0..(d.search("div.bloc-content").size - 1) do
		title[i] = d.css("div.bloc-content")[i].css("div.title h3.entry-title").text.strip
		content[i] = d.css("div.bloc-content")[i].css("div.content").text.strip
		titre = title[i]
		decision[titre] = content[i]
	end

# ajout du hash de chaque décision dans une matrice de l'ensemble des décisions

tout.push decision

}

# écriture des résultats dans un fichier CSV

CSV.open(fichier, "wb") do |csv|
  csv << tout.first.keys
  tout.each do |hash|
    csv << hash.values
  end
end
