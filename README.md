conseil_de_presse
=================

Fichiers pour extraction de toutes les décisions du Conseil de Presse du Québec de 1974 à 2014 (en septembre 2014, les plus récentes décisions dataient de juin).

**CdP.rb**

Utilisation de Nokogiri pour extraire les décisions du Conseil de presse en 2 temps:
- d'abord toutes les URL des décisions apparaissant dans la section «Décisions» du site web du Conseil;
- ensuite le contenu complet de chacune des 1886 décisions rendues entre 1974 et 2014.
Création d'un fichier .csv à la fin.

**CdP_json.rb**

Script qui fait essentiellement la même chose que le premier, mais en créant un fichier JSON, mieux adapté à la structure de la base de données des décisions du Conseil de presse.

**CdP.json**

Fichier JSON résultat de l'extraction. Base de données complète des décisions du Conseil de presse. Après nettoyage.  
*15,5 Mo*

**CdP_plaintes_par_categorie.csv**

Fichier CSV des catégories de plaintes.
