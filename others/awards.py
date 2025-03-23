"""
Script Python générant des diagrammes en camembert pour les awards.

Les réponses sont pondérées selon la deuxième colonne du fichier CSV.
Par exemple, si deux personnes répondent "Mathox" à la première question et une personne répond "Guill",
Mathox aura un poids de 0.5 et Guill un poids de 1.0 pour rééquilibrer.
"""
# Importations
import stouputils as stp
import pandas as pd
from collections import defaultdict
import os
import plotly.express as px

# Constantes
CURRENT_FOLDER: str = stp.get_root_path(__file__)
CSV_FILE: str = f"{CURRENT_FOLDER}/Awards S21 - Gardens Of The East (réponses) - Réponses au formulaire 1.csv"
OUTPUT_FOLDER: str = f"{CURRENT_FOLDER}/output"

# Chargement des données
data: pd.DataFrame = pd.read_csv(CSV_FILE)
colonnes: list[str] = data.columns.tolist()
reponses_total: int = len(data)
stp.info(f"Chargement des données terminé. {reponses_total} réponses trouvées.")
"""
columns = [
	"Horodateur",
	"Ton pseudo ?",
	"1 - Héros de la saison\n\nUn joueur reconnu pour son intégrité et son honneur, bien qu'il soit prêt à quelques mensonges pour gagner. Il veut 
porter la saison vers le haut.",
	"2 - Vilain de la saison\n\nUn joueur prêt à tout pour gagner, même les manigances les plus maléfiques. Mensonges, trahisons et manipulation sont ses mots fétiches.",
	"3 - Best Prémerge\n\nUne personne qui a été éliminé en pre-merge (de 13ème à 20ème) qui vous a particulièrement marquée, que ça soit par son jeu ou juste par simple fait que vous l'appréciez beaucoup !",
	...
]
"""

# Récupération des réponses uniques pour la deuxième colonne (première question)
reponses: list[str] = data[colonnes[1]].unique().tolist()
""" answers = ["Mathox", "Guill", "..."] """

# Calcul des pondérations (1 / nb_occurrences)
poids: dict[str, float] = {}
for reponse in reponses:
	# Calcul du nombre d'occurrences
	nb_occurrences: int = len(data[data[colonnes[1]] == reponse])
	
	# Calcul du diviseur (On force au maximum un ratio de 1/4)
	# En gros, si par exemple Mathox a 100 réponses et Guill 1, le ratio sera de 1/4 au lieu de 1/100.
	diviseur: float = max(1, (nb_occurrences / len(reponses)))
	
	# Calcul du poids
	if "survisland" in reponse.lower():
		poids[reponse] = 1 / diviseur
	else:
		poids[reponse] = 1 / diviseur
""" weights = {"Mathox": 0.4, "Guill": 0.01, "...": 0.8} """

## Génération d'un graphique interactif pour chaque question
def process_question(i: int) -> None:
	""" Traite une question individuelle et génère son graphique.
	
	Args:
		i (int): Index de la colonne/question à traiter dans le DataFrame.
	"""
	question: str = colonnes[i]
	votes: defaultdict[str, float] = defaultdict(float)
	
	# Calcul des votes pondérés
	for pos in range(len(data)):
		poids_individuel: float = poids[data[colonnes[1]].iloc[pos]]
		reponse: str = data[question].iloc[pos]
		votes[reponse] += poids_individuel

	# Filtrage des petites tranches (<3%) et regroupement en "Autre"
	total_votes: float = sum(votes.values())
	
	# Tri des votes par valeur décroissante et sélection des 8 premiers dépassant 3%
	votes_tries: list[tuple[str, float]] = sorted(votes.items(), key=lambda x: x[1], reverse=True)
	votes_filtres: dict[str, float] = {}
	for k, v in votes_tries[:8]:
		if v/total_votes >= 0.03:
			votes_filtres[k] = v
	
	# Regroupement des autres votes dans "Autre"
	votes_autres: float = total_votes - sum(votes_filtres.values())
	if votes_autres > 0:
		votes_filtres["Autre"] = votes_autres

	# Création du diagramme circulaire avec Plotly
	title: str = question.split("\n\n")[0]
	fig = px.pie(
		names=list(votes_filtres.keys()),
		values=list(votes_filtres.values()),
		title=title,
		color_discrete_sequence=px.colors.qualitative.Pastel,
		hole=0.3,
		labels={"label": "Candidat", "value": "Votes"},
	)

	# Personnalisation de l'apparence
	fig.update_traces(
		textposition="inside",
		textinfo="percent+label",
		marker=dict(line=dict(color="#ffffff", width=2)),
		hovertemplate="<b>%{label}</b><br>Part des votes: %{percent}<br>Poids total: %{value}"
	)
	
	fig.update_layout(
		uniformtext_minsize=12,
		uniformtext_mode="hide",
		font_family="Arial",
		title_font_size=20,
		legend=dict(
			orientation="h",
			yanchor="bottom",
			y=-0.3,
			xanchor="center",
			x=0.5
		)
	)

	# Sauvegardes
	path: str = "".join([x for x in title.lower() if x in "abcdefghijklmnopqrstuvwxyz"])

	# Optional: Sauvegarde au format HTML
	fig.write_html(f"{OUTPUT_FOLDER}/q{i-1}_{path}.html")

	# Save static image
	fig.write_image(f"{OUTPUT_FOLDER}/q{i-1}_{path}.jpg", scale=8)


# Création du dossier de sortie si nécessaire
os.makedirs(OUTPUT_FOLDER, exist_ok=True)

# Sauvegarde des poids
with stp.super_open(f"{OUTPUT_FOLDER}/poids.json", "w") as f:
	f.write(stp.super_json_dump(poids))

# Remplacement de la boucle par un traitement parallèle
args: list[int] = list(range(2, len(colonnes)))
stp.multithreading(
	process_question,
	args=args,
	desc="Génération des graphiques",
	max_workers=4,
	verbose=1
)

# Calcul de la moyenne des notes de la saison (avant dernière colonne)
last_column: str = colonnes[-2]
notes: list[str] = data[last_column].tolist()	# ["10/20", "12/20", "14/20", ...]
stp.whatisit(notes)

# Extraction des numérateurs et dénominateurs avec poids
numerators: list[float] = []
for i, note in enumerate(notes):
	if isinstance(note, str):
		poids_individuel: float = poids[data[colonnes[1]].iloc[i]]
		numerator: int = int(note.split("/")[0])
		numerators.append(numerator * poids_individuel)

# Calcul de la moyenne pondérée
total_poids: float = sum(poids[data[colonnes[1]].iloc[i]] for i in range(len(data)) if isinstance(notes[i], str))
moyenne: float = sum(numerators) / total_poids
stp.info(f"Moyenne pondérée des notes de la saison: {moyenne:.2f}")

