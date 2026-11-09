# Catalogue des mesures DAX

La table `Metrics` regroupe **204 mesures** rangées en **12 dossiers d'affichage**, un par page ou par thème du rapport. Chaque mesure est écrite pour être lue : variables nommées, `DIVIDE` pour toute division, pas de colonne calculée quand une mesure suffit.

## Sommaire

- [01 Tournoi](#01-tournoi) · 29 mesures
- [02 Équipes](#02-équipes) · 20 mesures
- [03 Groupes](#03-groupes) · 12 mesures
- [04 Tableau final](#04-tableau-final) · 16 mesures
- [05 Centre de match](#05-centre-de-match) · 27 mesures
- [06 Parcours](#06-parcours) · 28 mesures
- [07 Buteurs](#07-buteurs) · 17 mesures
- [08 Stades](#08-stades) · 5 mesures
- [09 Discipline](#09-discipline) · 5 mesures
- [10 Textes et couleurs](#10-textes-et-couleurs) · 4 mesures
- [11 Fil du tournoi](#11-fil-du-tournoi) · 10 mesures
- [12 Duel de nations](#12-duel-de-nations) · 31 mesures

## 01 Tournoi

### Matchs
> Nombre de matchs dans le contexte

```dax
Matchs =
COUNTROWS ( D_Match ) + 0
```

### Buts

```dax
Buts =
COUNTROWS ( F_But ) + 0
```

### Buts par match

```dax
Buts par match =
DIVIDE ( [Buts], [Matchs] )
```

### Nations

```dax
Nations =
COUNTROWS ( D_Equipe )
```

### Stades

```dax
Stades =
DISTINCTCOUNT ( D_Match[StadeCode] )
```

### Villes hôtes
> Abidjan compte une seule fois (Ebimpé et Plateau)

```dax
Villes hôtes =
CALCULATE ( DISTINCTCOUNT ( D_Stade[Ville] ), D_Stade[Ville] <> "Abidjan (Plateau)" )
```

### Spectateurs

```dax
Spectateurs =
SUM ( D_Match[Affluence] )
```

### Affluence moyenne

```dax
Affluence moyenne =
AVERAGE ( D_Match[Affluence] )
```

### Record affluence

```dax
Record affluence =
MAX ( D_Match[Affluence] )
```

### Capacité offerte

```dax
Capacité offerte =
SUMX ( D_Match, RELATED ( D_Stade[Capacité] ) )
```

### Taux de remplissage

```dax
Taux de remplissage =
DIVIDE ( [Spectateurs], [Capacité offerte] )
```

### Réalisations
> Buts hors contre son camp, crédités au buteur

```dax
Réalisations =
CALCULATE ( COUNTROWS ( F_But ), F_But[Type de but] <> "Contre son camp" )
```

### Penalties marqués

```dax
Penalties marqués =
CALCULATE ( COUNTROWS ( F_But ), F_But[Type de but] = "Penalty" ) + 0
```

### Buts contre son camp

```dax
Buts contre son camp =
CALCULATE ( COUNTROWS ( F_But ), F_But[Type de but] = "Contre son camp" ) + 0
```

### Buts en temps additionnel

```dax
Buts en temps additionnel =
CALCULATE ( COUNTROWS ( F_But ), F_But[Temps additionnel] = 1 ) + 0
```

### Part des buts sur passe

```dax
Part des buts sur passe =
DIVIDE ( CALCULATE ( COUNTROWS ( F_But ), F_But[Avec passe décisive] = 1 ), [Buts] )
```

### Matchs nuls

```dax
Matchs nuls =
CALCULATE ( COUNTROWS ( D_Match ), D_Match[Vainqueur] = "Match nul" ) + 0
```

### Séances de tirs au but

```dax
Séances de tirs au but =
CALCULATE ( COUNTROWS ( D_Match ), D_Match[Tirs au but] = 1 ) + 0
```

### Prolongations

```dax
Prolongations =
CALCULATE ( COUNTROWS ( D_Match ), D_Match[Prolongation] = 1 ) + 0
```

### Cartons

```dax
Cartons =
COUNTROWS ( F_Carton ) + 0
```

### Jaunes

```dax
Jaunes =
CALCULATE ( COUNTROWS ( F_Carton ), F_Carton[Carton] = "Jaune" ) + 0
```

### Rouges

```dax
Rouges =
CALCULATE ( COUNTROWS ( F_Carton ), F_Carton[Carton] = "Rouge" ) + 0
```

### Cartons par match

```dax
Cartons par match =
DIVIDE ( [Cartons], [Matchs] )
```

### Interventions VAR

```dax
Interventions VAR =
COUNTROWS ( F_VAR ) + 0
```

### Remplacements

```dax
Remplacements =
COUNTROWS ( F_Remplacement ) + 0
```

### Fautes sifflées

```dax
Fautes sifflées =
SUM ( F_EquipeMatch[Fautes] )
```

### Buteurs différents

```dax
Buteurs différents =
CALCULATE ( DISTINCTCOUNT ( F_But[Buteur] ), F_But[Type de but] <> "Contre son camp" )
```

### Spectateurs (M)

```dax
Spectateurs (M) =
DIVIDE ( [Spectateurs], 1000000 )
```

### Sous-titre buts

```dax
Sous-titre buts =
FORMAT ( [Penalties marqués], "0" ) & " penalties · " & FORMAT ( [Buts contre son camp], "0" ) & " csc"
```


## 02 Équipes

### Matchs joués

```dax
Matchs joués =
COUNTROWS ( F_EquipeMatch ) + 0
```

### Victoires
> Victoires dans le temps de jeu (prolongation comprise) ; une qualification aux tirs au but compte comme un nul

```dax
Victoires =
COUNTROWS ( FILTER ( F_EquipeMatch, F_EquipeMatch[Buts pour] > F_EquipeMatch[Buts contre] ) ) + 0
```

### Nuls

```dax
Nuls =
COUNTROWS ( FILTER ( F_EquipeMatch, F_EquipeMatch[Buts pour] = F_EquipeMatch[Buts contre] ) ) + 0
```

### Défaites

```dax
Défaites =
COUNTROWS ( FILTER ( F_EquipeMatch, F_EquipeMatch[Buts pour] < F_EquipeMatch[Buts contre] ) ) + 0
```

### Buts marqués

```dax
Buts marqués =
SUM ( F_EquipeMatch[Buts pour] ) + 0
```

### Buts encaissés

```dax
Buts encaissés =
SUM ( F_EquipeMatch[Buts contre] ) + 0
```

### Différence de buts

```dax
Différence de buts =
[Buts marqués] - [Buts encaissés]
```

### Points obtenus

```dax
Points obtenus =
SUM ( F_EquipeMatch[Points] ) + 0
```

### Clean sheets

```dax
Clean sheets =
SUM ( F_EquipeMatch[Clean sheet] ) + 0
```

### Possession moyenne

```dax
Possession moyenne =
AVERAGE ( F_EquipeMatch[Possession (%)] )
```

### Tirs par match

```dax
Tirs par match =
AVERAGE ( F_EquipeMatch[Tirs] )
```

### Tirs cadrés par match

```dax
Tirs cadrés par match =
AVERAGE ( F_EquipeMatch[Tirs cadrés] )
```

### Précision des passes

```dax
Précision des passes =
AVERAGE ( F_EquipeMatch[Précision des passes (%)] )
```

### Nation
> Drapeau de la nation en contexte

```dax
Nation =
SELECTEDVALUE ( D_Equipe[Drapeau] )
```

### Position

```dax
Position =
MAX ( D_Equipe[Position dans le groupe] )
```

### Clé de classement

```dax
Clé de classement =
MAX ( D_Equipe[Ordre du parcours] ) * 10000 - ( 3 * [Victoires] + [Nuls] ) * 100 - [Différence de buts]
```

### Rang final

```dax
Rang final =
IF ( HASONEVALUE ( D_Equipe[Team_ID] ), RANKX ( ALL ( D_Equipe ), [Clé de classement], , ASC, Dense ) )
```

### Rang (moitié haute)

```dax
Rang (moitié haute) =
IF ( [Rang final] <= 12, 1 )
```

### Rang (moitié basse)

```dax
Rang (moitié basse) =
IF ( [Rang final] > 12, 1 )
```

### Bilan

```dax
Bilan =
FORMAT ( [Victoires], "0" ) & " - " & FORMAT ( [Nuls], "0" ) & " - " & FORMAT ( [Défaites], "0" )
```


## 03 Groupes

### V (groupes)

```dax
V (groupes) =
CALCULATE ( [Victoires], D_Match[Phase] = "Phase de groupes" )
```

### N (groupes)

```dax
N (groupes) =
CALCULATE ( [Nuls], D_Match[Phase] = "Phase de groupes" )
```

### D (groupes)

```dax
D (groupes) =
CALCULATE ( [Défaites], D_Match[Phase] = "Phase de groupes" )
```

### BP (groupes)

```dax
BP (groupes) =
CALCULATE ( [Buts marqués], D_Match[Phase] = "Phase de groupes" )
```

### BC (groupes)

```dax
BC (groupes) =
CALCULATE ( [Buts encaissés], D_Match[Phase] = "Phase de groupes" )
```

### Pts (groupes)

```dax
Pts (groupes) =
CALCULATE ( [Points obtenus], D_Match[Phase] = "Phase de groupes" )
```

### Diff (groupes)

```dax
Diff (groupes) =
[BP (groupes)] - [BC (groupes)]
```

### Rang des troisièmes

```dax
Rang des troisièmes =
IF ( HASONEVALUE ( D_Equipe[Team_ID] ), RANKX ( ALLSELECTED ( D_Equipe ), [Pts (groupes)] * 10000 + ( [Diff (groupes)] + 50 ) * 100 + [BP (groupes)], , DESC, Dense ) )
```

### Buts phase de groupes

```dax
Buts phase de groupes =
CALCULATE ( [Buts], D_Match[Phase] = "Phase de groupes" )
```

### Moyenne phase de groupes

```dax
Moyenne phase de groupes =
CALCULATE ( [Buts par match], D_Match[Phase] = "Phase de groupes" )
```

### Nuls phase de groupes

```dax
Nuls phase de groupes =
CALCULATE ( [Matchs nuls], D_Match[Phase] = "Phase de groupes" )
```

### Qualifiées

```dax
Qualifiées =
CALCULATE ( COUNTROWS ( D_Equipe ), D_Equipe[Statut] = "Qualifiée" )
```


## 04 Tableau final

### Nation (match)

```dax
Nation (match) =
IF ( NOT ISEMPTY ( F_EquipeMatch ), SELECTEDVALUE ( D_Equipe[Drapeau] ) )
```

### Score (tableau)

```dax
Score (tableau) =
IF ( NOT ISEMPTY ( F_EquipeMatch ), FORMAT ( SUM ( F_EquipeMatch[Buts pour] ), "0" ) & IF ( SUM ( F_EquipeMatch[Nul puis t.a.b.] ) = 1 && SUM ( F_EquipeMatch[Victoire] ) = 1, "*", "" ) )
```

### Couleur vainqueur

```dax
Couleur vainqueur =
IF ( SUM ( F_EquipeMatch[Victoire] ) = 1, "#E8B84A", "#A9C4B8" )
```

### Champion

```dax
Champion =
CALCULATE ( SELECTEDVALUE ( D_Equipe[Équipe] ), D_Equipe[Ordre du parcours] = 1 )
```

### Champion surnom

```dax
Champion surnom =
CALCULATE ( SELECTEDVALUE ( D_Equipe[Surnom] ), D_Equipe[Ordre du parcours] = 1 )
```

### Drapeau du champion

```dax
Drapeau du champion =
CALCULATE ( SELECTEDVALUE ( D_Equipe[Drapeau] ), D_Equipe[Ordre du parcours] = 1 )
```

### Finaliste

```dax
Finaliste =
CALCULATE ( SELECTEDVALUE ( D_Equipe[Équipe] ), D_Equipe[Ordre du parcours] = 2 )
```

### Troisième

```dax
Troisième =
CALCULATE ( SELECTEDVALUE ( D_Equipe[Équipe] ), D_Equipe[Ordre du parcours] = 3 )
```

### Affiche de la finale

```dax
Affiche de la finale =
CALCULATE ( SELECTEDVALUE ( D_Match[Affiche] ), D_Match[Tour] = "Finale" )
```

### Ligne de la finale

```dax
Ligne de la finale =
VAR code = CALCULATE ( SELECTEDVALUE ( D_Match[StadeCode] ), D_Match[Tour] = "Finale" ) RETURN CALCULATE ( SELECTEDVALUE ( D_Match[Date (texte)] ), D_Match[Tour] = "Finale" ) & " · " & LOOKUPVALUE ( D_Stade[Stade], D_Stade[StadeCode], code ) & " · " & FORMAT ( CALCULATE ( SUM ( D_Match[Affluence] ), D_Match[Tour] = "Finale" ), "#,0" ) & " spectateurs"
```

### Titre du champion

```dax
Titre du champion =
"Champion d'Afrique · " & [Champion surnom]
```

### Phase finale buts

```dax
Phase finale buts =
CALCULATE ( [Buts], D_Match[Phase] = "Élimination directe" )
```

### Phase finale matchs

```dax
Phase finale matchs =
CALCULATE ( [Matchs], D_Match[Phase] = "Élimination directe" )
```

### Phase finale moyenne

```dax
Phase finale moyenne =
CALCULATE ( [Buts par match], D_Match[Phase] = "Élimination directe" )
```

### Phase finale tab

```dax
Phase finale tab =
CALCULATE ( [Séances de tirs au but], D_Match[Phase] = "Élimination directe" )
```

### Phase finale prolongations

```dax
Phase finale prolongations =
CALCULATE ( [Prolongations], D_Match[Phase] = "Élimination directe" )
```


## 05 Centre de match

### Match choisi
> Match sélectionné, la finale par défaut

```dax
Match choisi =
SELECTEDVALUE ( D_Match[N° match], 52 )
```

### MC Domicile

```dax
MC Domicile =
VAR sel = [Match choisi] RETURN CALCULATE ( SELECTEDVALUE ( D_Match[Domicile] ), REMOVEFILTERS ( D_Match ), D_Match[N° match] = sel )
```

### MC Extérieur

```dax
MC Extérieur =
VAR sel = [Match choisi] RETURN CALCULATE ( SELECTEDVALUE ( D_Match[Extérieur] ), REMOVEFILTERS ( D_Match ), D_Match[N° match] = sel )
```

### MC Score

```dax
MC Score =
VAR sel = [Match choisi] RETURN CALCULATE ( SELECTEDVALUE ( D_Match[Score] ), REMOVEFILTERS ( D_Match ), D_Match[N° match] = sel )
```

### MC Tour

```dax
MC Tour =
VAR sel = [Match choisi] RETURN CALCULATE ( SELECTEDVALUE ( D_Match[Étiquette] ), REMOVEFILTERS ( D_Match ), D_Match[N° match] = sel )
```

### MC Drapeau domicile

```dax
MC Drapeau domicile =
VAR sel = [Match choisi] VAR t = LOOKUPVALUE ( D_Match[DomID], D_Match[N° match], sel ) RETURN LOOKUPVALUE ( D_Equipe[Drapeau], D_Equipe[Team_ID], t )
```

### MC Drapeau extérieur

```dax
MC Drapeau extérieur =
VAR sel = [Match choisi] VAR t = LOOKUPVALUE ( D_Match[ExtID], D_Match[N° match], sel ) RETURN LOOKUPVALUE ( D_Equipe[Drapeau], D_Equipe[Team_ID], t )
```

### MC Issue

```dax
MC Issue =
VAR sel = [Match choisi] VAR v = LOOKUPVALUE ( D_Match[Vainqueur], D_Match[N° match], sel ) VAR tab = LOOKUPVALUE ( D_Match[Tirs au but], D_Match[N° match], sel ) VAR ap = LOOKUPVALUE ( D_Match[Prolongation], D_Match[N° match], sel ) RETURN IF ( v = "Match nul", "Match nul", v & " l'emporte" & IF ( tab = 1, " aux tirs au but", IF ( ap = 1, " après prolongation", "" ) ) )
```

### MC Infos

```dax
MC Infos =
VAR sel = [Match choisi] VAR code = LOOKUPVALUE ( D_Match[StadeCode], D_Match[N° match], sel ) RETURN LOOKUPVALUE ( D_Match[Date (texte)], D_Match[N° match], sel ) & " · " & LOOKUPVALUE ( D_Stade[Stade (court)], D_Stade[StadeCode], code ) & " · " & LOOKUPVALUE ( D_Stade[Ville], D_Stade[StadeCode], code )
```

### MC Spectateurs

```dax
MC Spectateurs =
VAR sel = [Match choisi] RETURN LOOKUPVALUE ( D_Match[Affluence], D_Match[N° match], sel )
```

### MC Remplissage

```dax
MC Remplissage =
VAR sel = [Match choisi] VAR code = LOOKUPVALUE ( D_Match[StadeCode], D_Match[N° match], sel ) RETURN DIVIDE ( [MC Spectateurs], LOOKUPVALUE ( D_Stade[Capacité], D_Stade[StadeCode], code ) )
```

### MC Arbitre

```dax
MC Arbitre =
VAR sel = [Match choisi] RETURN LOOKUPVALUE ( D_Match[Arbitre], D_Match[N° match], sel ) & " (" & LOOKUPVALUE ( D_Match[Pays de l'arbitre], D_Match[N° match], sel ) & ")"
```

### MC Homme du match

```dax
MC Homme du match =
VAR sel = [Match choisi] RETURN LOOKUPVALUE ( D_Match[Homme du match], D_Match[N° match], sel )
```

### MC Buts

```dax
MC Buts =
VAR sel = [Match choisi] RETURN CALCULATE ( [Buts], REMOVEFILTERS ( D_Match ), D_Match[N° match] = sel )
```

### MC Cartons

```dax
MC Cartons =
VAR sel = [Match choisi] RETURN CALCULATE ( [Cartons], REMOVEFILTERS ( D_Match ), D_Match[N° match] = sel )
```

### MC VAR

```dax
MC VAR =
VAR sel = [Match choisi] RETURN CALCULATE ( [Interventions VAR], REMOVEFILTERS ( D_Match ), D_Match[N° match] = sel )
```

### MC Remplacements

```dax
MC Remplacements =
VAR sel = [Match choisi] RETURN CALCULATE ( [Remplacements], REMOVEFILTERS ( D_Match ), D_Match[N° match] = sel )
```

### Valeur domicile

```dax
Valeur domicile =
CALCULATE ( SUM ( F_Stat[Valeur] ), F_Stat[Côté] = "Domicile" )
```

### Valeur extérieur

```dax
Valeur extérieur =
CALCULATE ( SUM ( F_Stat[Valeur] ), F_Stat[Côté] = "Extérieur" )
```

### Drapeau du but

```dax
Drapeau du but =
VAR t = SELECTEDVALUE ( F_But[Team_ID] ) RETURN IF ( NOT ISBLANK ( t ), LOOKUPVALUE ( D_Equipe[Drapeau], D_Equipe[Team_ID], t ) )
```

### Drapeau du carton

```dax
Drapeau du carton =
VAR t = SELECTEDVALUE ( F_Carton[Team_ID] ) RETURN IF ( NOT ISBLANK ( t ), LOOKUPVALUE ( D_Equipe[Drapeau], D_Equipe[Team_ID], t ) )
```

### Couleur du carton

```dax
Couleur du carton =
IF ( SELECTEDVALUE ( F_Carton[Carton] ) = "Rouge", "#E5484D", "#F5C842" )
```

### Type court

```dax
Type court =
SWITCH ( SELECTEDVALUE ( F_But[Type de but] ), "Penalty", "pen.", "Contre son camp", "csc", "" )
```

### But du match choisi

```dax
But du match choisi =
IF ( MAX ( F_But[Match_ID] ) = [Match choisi], 1 )
```

### Carton du match choisi

```dax
Carton du match choisi =
IF ( MAX ( F_Carton[Match_ID] ) = [Match choisi], 1 )
```

### Duel domicile

```dax
Duel domicile =
VAR sel = [Match choisi] RETURN CALCULATE ( SUM ( F_Stat[Valeur] ), REMOVEFILTERS ( D_Match ), F_Stat[Match_ID] = sel, F_Stat[Côté] = "Domicile" )
```

### Duel extérieur

```dax
Duel extérieur =
VAR sel = [Match choisi] RETURN CALCULATE ( SUM ( F_Stat[Valeur] ), REMOVEFILTERS ( D_Match ), F_Stat[Match_ID] = sel, F_Stat[Côté] = "Extérieur" )
```


## 06 Parcours

### Équipe choisie
> Nation sélectionnée, le champion par défaut

```dax
Équipe choisie =
SELECTEDVALUE ( D_Equipe[Team_ID], 3 )
```

### PC Nom

```dax
PC Nom =
VAR sel = [Équipe choisie] RETURN CALCULATE ( SELECTEDVALUE ( D_Equipe[Équipe] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Surnom

```dax
PC Surnom =
VAR sel = [Équipe choisie] RETURN CALCULATE ( SELECTEDVALUE ( D_Equipe[Surnom] ) & " · " & SELECTEDVALUE ( D_Equipe[Groupe] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Drapeau

```dax
PC Drapeau =
VAR sel = [Équipe choisie] RETURN CALCULATE ( SELECTEDVALUE ( D_Equipe[Drapeau] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Parcours

```dax
PC Parcours =
VAR sel = [Équipe choisie] RETURN CALCULATE ( SELECTEDVALUE ( D_Equipe[Parcours] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Matchs

```dax
PC Matchs =
VAR sel = [Équipe choisie] RETURN CALCULATE ( [Matchs joués], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Bilan

```dax
PC Bilan =
VAR sel = [Équipe choisie] RETURN CALCULATE ( FORMAT ( [Victoires], "0" ) & " V · " & FORMAT ( [Nuls], "0" ) & " N · " & FORMAT ( [Défaites], "0" ) & " D", REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Buts marqués

```dax
PC Buts marqués =
VAR sel = [Équipe choisie] RETURN CALCULATE ( [Buts marqués], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Buts encaissés

```dax
PC Buts encaissés =
VAR sel = [Équipe choisie] RETURN CALCULATE ( [Buts encaissés], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Possession

```dax
PC Possession =
VAR sel = [Équipe choisie] RETURN CALCULATE ( [Possession moyenne], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Spectateurs

```dax
PC Spectateurs =
VAR sel = [Équipe choisie] RETURN CALCULATE ( SUMX ( F_EquipeMatch, RELATED ( D_Match[Affluence] ) ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Cartons

```dax
PC Cartons =
VAR sel = [Équipe choisie] RETURN CALCULATE ( [Cartons], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Réalisations

```dax
PC Réalisations =
VAR sel = [Équipe choisie] RETURN CALCULATE ( [Réalisations], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Match

```dax
PC Match =
VAR sel = [Équipe choisie] RETURN CALCULATE ( SELECTEDVALUE ( F_EquipeMatch[Match_ID] ), REMOVEFILTERS ( D_Equipe ), F_EquipeMatch[Team_ID] = sel )
```

### PC Visible

```dax
PC Visible =
IF ( NOT ISBLANK ( [PC Match] ), 1 )
```

### PC Date

```dax
PC Date =
VAR mt = [PC Match] RETURN IF ( NOT ISBLANK ( mt ), LOOKUPVALUE ( D_Match[Jour], D_Match[N° match], mt ) )
```

### PC Nation adverse

```dax
PC Nation adverse =
VAR sel = [Équipe choisie] VAR a = CALCULATE ( SELECTEDVALUE ( F_EquipeMatch[AdvID] ), REMOVEFILTERS ( D_Equipe ), F_EquipeMatch[Team_ID] = sel ) RETURN IF ( NOT ISBLANK ( a ), LOOKUPVALUE ( D_Equipe[Drapeau], D_Equipe[Team_ID], a ) )
```

### PC Adversaire

```dax
PC Adversaire =
VAR sel = [Équipe choisie] RETURN CALCULATE ( SELECTEDVALUE ( F_EquipeMatch[Adversaire] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Score

```dax
PC Score =
VAR sel = [Équipe choisie] RETURN CALCULATE ( SELECTEDVALUE ( F_EquipeMatch[Score équipe] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Résultat

```dax
PC Résultat =
VAR sel = [Équipe choisie] RETURN CALCULATE ( SELECTEDVALUE ( F_EquipeMatch[Résultat] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### PC Couleur résultat

```dax
PC Couleur résultat =
VAR r = [PC Résultat] RETURN SWITCH ( TRUE (), LEFT ( r, 8 ) = "Victoire", "#2FBF71", LEFT ( r, 7 ) = "Défaite", "#E5484D", "#E8B84A" )
```

### PC Stade

```dax
PC Stade =
VAR mt = [PC Match] VAR code = LOOKUPVALUE ( D_Match[StadeCode], D_Match[N° match], mt ) RETURN IF ( NOT ISBLANK ( mt ), LOOKUPVALUE ( D_Stade[Stade (court)], D_Stade[StadeCode], code ) )
```

### PC Affluence

```dax
PC Affluence =
VAR mt = [PC Match] RETURN IF ( NOT ISBLANK ( mt ), LOOKUPVALUE ( D_Match[Affluence], D_Match[N° match], mt ) )
```

### PC Homme du match

```dax
PC Homme du match =
VAR mt = [PC Match] RETURN IF ( NOT ISBLANK ( mt ), LOOKUPVALUE ( D_Match[Homme du match], D_Match[N° match], mt ) )
```

### PC Moyenne équipe

```dax
PC Moyenne équipe =
VAR sel = [Équipe choisie] RETURN CALCULATE ( AVERAGE ( F_Stat[Valeur] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = sel )
```

### Moyenne CAN

```dax
Moyenne CAN =
CALCULATE ( AVERAGE ( F_Stat[Valeur] ), REMOVEFILTERS ( D_Equipe ) )
```

### PC Écart

```dax
PC Écart =
DIVIDE ( [PC Moyenne équipe] - [Moyenne CAN], [Moyenne CAN] )
```

### PC Couleur écart

```dax
PC Couleur écart =
VAR e = [PC Écart] VAR inv = SELECTEDVALUE ( F_Stat[Statistique] ) IN { "Fautes", "Hors-jeu", "Cartons jaunes", "Cartons rouges" } VAR bon = IF ( inv, e < 0, e > 0 ) RETURN IF ( ABS ( e ) < 0.02, "#A9C4B8", IF ( bon, "#2FBF71", "#E5484D" ) )
```


## 07 Buteurs

### Buteurs (3 buts et plus)

```dax
Buteurs (3 buts et plus) =
IF ( [Réalisations] >= 3, [Réalisations] )
```

### Meilleur buteur

```dax
Meilleur buteur =
VAR t = TOPN ( 1, ADDCOLUMNS ( VALUES ( F_But[Buteur] ), "@b", [Réalisations] ), [@b], DESC ) RETURN MAXX ( t, F_But[Buteur] )
```

### Meilleur buteur ligne

```dax
Meilleur buteur ligne =
VAR nom = [Meilleur buteur] VAR b = MAXX ( VALUES ( F_But[Buteur] ), [Réalisations] ) VAR t = CALCULATE ( MAX ( F_But[Team_ID] ), F_But[Buteur] = nom ) RETURN FORMAT ( b, "0" ) & " buts · " & LOOKUPVALUE ( D_Equipe[Équipe], D_Equipe[Team_ID], t )
```

### But le plus rapide

```dax
But le plus rapide =
VAR t = TOPN ( 1, F_But, F_But[Tri minute], ASC ) RETURN MAXX ( t, F_But[Minute (texte)] )
```

### But le plus rapide ligne

```dax
But le plus rapide ligne =
VAR t = TOPN ( 1, F_But, F_But[Tri minute], ASC ) VAR mt = MAXX ( t, F_But[Match_ID] ) RETURN MAXX ( t, F_But[Buteur] ) & " · " & LOOKUPVALUE ( D_Match[Affiche], D_Match[N° match], mt )
```

### But le plus tardif

```dax
But le plus tardif =
VAR t = TOPN ( 1, F_But, F_But[Tri minute], DESC ) RETURN MAXX ( t, F_But[Minute (texte)] )
```

### But le plus tardif ligne

```dax
But le plus tardif ligne =
VAR t = TOPN ( 1, F_But, F_But[Tri minute], DESC ) VAR mt = MAXX ( t, F_But[Match_ID] ) RETURN MAXX ( t, F_But[Buteur] ) & " · " & LOOKUPVALUE ( D_Match[Affiche], D_Match[N° match], mt )
```

### But le plus rapide buteur

```dax
But le plus rapide buteur =
VAR t = TOPN ( 1, F_But, F_But[Tri minute], ASC ) RETURN MAXX ( t, F_But[Buteur (équipe)] )
```

### But le plus rapide match

```dax
But le plus rapide match =
VAR t = TOPN ( 1, F_But, F_But[Tri minute], ASC ) RETURN LOOKUPVALUE ( D_Match[Affiche (courte)], D_Match[N° match], MAXX ( t, F_But[Match_ID] ) )
```

### But le plus tardif buteur

```dax
But le plus tardif buteur =
VAR t = TOPN ( 1, F_But, F_But[Tri minute], DESC ) RETURN MAXX ( t, F_But[Buteur (équipe)] )
```

### But le plus tardif match

```dax
But le plus tardif match =
VAR t = TOPN ( 1, F_But, F_But[Tri minute], DESC ) RETURN LOOKUPVALUE ( D_Match[Affiche (courte)], D_Match[N° match], MAXX ( t, F_But[Match_ID] ) )
```

### Plus large victoire 1

```dax
Plus large victoire 1 =
VAR mx = MAX ( D_Match[Écart] ) VAR t = TOPN ( 1, FILTER ( D_Match, D_Match[Écart] = mx ), D_Match[N° match], ASC ) RETURN MAXX ( t, D_Match[Affiche (courte)] )
```

### Plus large victoire 2

```dax
Plus large victoire 2 =
VAR mx = MAX ( D_Match[Écart] ) VAR t = TOPN ( 1, FILTER ( D_Match, D_Match[Écart] = mx ), D_Match[N° match], DESC ) VAR a = MAXX ( t, D_Match[Affiche (courte)] ) RETURN IF ( a = [Plus large victoire 1], " ", a )
```

### Plus large écart

```dax
Plus large écart =
MAX ( D_Match[Écart] )
```

### Plus large victoire

```dax
Plus large victoire =
VAR mx = MAX ( D_Match[Écart] ) RETURN "+" & FORMAT ( mx, "0" )
```

### Plus large victoire ligne

```dax
Plus large victoire ligne =
VAR mx = MAX ( D_Match[Écart] ) RETURN CONCATENATEX ( FILTER ( D_Match, D_Match[Écart] = mx ), D_Match[Affiche], " · ", D_Match[N° match], ASC )
```

### Équipes les plus prolifiques

```dax
Équipes les plus prolifiques =
IF ( RANKX ( ALLSELECTED ( D_Equipe[Équipe] ), [Buts marqués], , DESC, Dense ) <= 6, [Buts marqués] )
```


## 08 Stades

### Record affluence ligne

```dax
Record affluence ligne =
VAR mx = MAX ( D_Match[Affluence] ) RETURN MAXX ( FILTER ( D_Match, D_Match[Affluence] = mx ), D_Match[Étiquette] & " · " & D_Match[Affiche] )
```

### Capacité totale

```dax
Capacité totale =
SUM ( D_Stade[Capacité] )
```

### Spectateurs par match (stade)

```dax
Spectateurs par match (stade) =
DIVIDE ( [Spectateurs], [Matchs] )
```

### Stades et villes

```dax
Stades et villes =
FORMAT ( [Stades], "0" ) & " / " & FORMAT ( [Villes hôtes], "0" )
```

### Rang affluence

```dax
Rang affluence =
IF ( HASONEVALUE ( D_Match[N° match] ), RANKX ( ALL ( D_Match ), CALCULATE ( SUM ( D_Match[Affluence] ) ), , DESC ) )
```


## 09 Discipline

### Arbitre à 3 matchs ou plus

```dax
Arbitre à 3 matchs ou plus =
IF ( CALCULATE ( [Matchs], REMOVEFILTERS ( D_Match[Phase] ) ) >= 3 && [Matchs] > 0, 1 )
```

### Cartons par match (arbitre)

```dax
Cartons par match (arbitre) =
DIVIDE ( [Cartons], [Matchs] )
```

### Rang cartons

```dax
Rang cartons =
IF ( HASONEVALUE ( D_Equipe[Team_ID] ), RANKX ( ALL ( D_Equipe ), [Cartons] * 100 + MAX ( D_Equipe[Team_ID] ), , DESC ) )
```

### Jaunes (top 12)

```dax
Jaunes (top 12) =
IF ( [Rang cartons] <= 12, [Jaunes] )
```

### Rouges (top 12)

```dax
Rouges (top 12) =
IF ( [Rang cartons] <= 12, [Rouges] )
```


## 10 Textes et couleurs

### Couleur statut

```dax
Couleur statut =
IF ( SELECTEDVALUE ( D_Equipe[Statut] ) = "Qualifiée", "#F6F1E6", "#7F9E91" )
```

### Couleur qualifiée

```dax
Couleur qualifiée =
IF ( SELECTEDVALUE ( D_Equipe[Statut] ) = "Qualifiée", "#2FBF71", "#7F9E91" )
```

### Couleur parcours

```dax
Couleur parcours =
SWITCH ( MAX ( D_Equipe[Ordre du parcours] ), 1, "#E8B84A", 2, "#F6F1E6", 3, "#F28C1E", 4, "#F28C1E", "#A9C4B8" )
```

### Couleur équipe

```dax
Couleur équipe =
SELECTEDVALUE ( D_Equipe[Couleur], "#F28C1E" )
```


## 11 Fil du tournoi

### Jours de match

```dax
Jours de match =
DISTINCTCOUNT ( D_Match[Date] )
```

### Buts par jour de match

```dax
Buts par jour de match =
DIVIDE ( [Buts], [Jours de match] )
```

### Buts cumulés

```dax
Buts cumulés =
VAR d = MAX ( D_Match[Date] ) RETURN CALCULATE ( [Buts], FILTER ( ALL ( D_Match ), D_Match[Date] <= d ) )
```

### Spectateurs cumulés (M)

```dax
Spectateurs cumulés (M) =
VAR d = MAX ( D_Match[Date] ) RETURN CALCULATE ( DIVIDE ( [Spectateurs], 1000000 ), FILTER ( ALL ( D_Match ), D_Match[Date] <= d ) )
```

### Journée record

```dax
Journée record =
VAR t = TOPN ( 1, ADDCOLUMNS ( VALUES ( D_Match[Date] ), "@b", [Buts] ), [@b], DESC, D_Match[Date], ASC ) RETURN FORMAT ( MAXX ( t, [@b] ), "0" ) & " buts"
```

### Journée record ligne

```dax
Journée record ligne =
VAR t = TOPN ( 1, ADDCOLUMNS ( VALUES ( D_Match[Date] ), "@b", [Buts] ), [@b], DESC, D_Match[Date], ASC ) VAR d = MAXX ( t, D_Match[Date] ) RETURN "le " & FORMAT ( d, "d mmmm" )
```

### Match le plus prolifique

```dax
Match le plus prolifique =
MAX ( D_Match[Buts du match] )
```

### Match le plus prolifique ligne

```dax
Match le plus prolifique ligne =
VAR mx = MAX ( D_Match[Buts du match] ) RETURN MAXX ( TOPN ( 1, FILTER ( D_Match, D_Match[Buts du match] = mx ), D_Match[N° match], ASC ), D_Match[Affiche (courte)] )
```

### Rang prolifique

```dax
Rang prolifique =
IF ( HASONEVALUE ( D_Match[N° match] ), RANKX ( ALL ( D_Match ), CALCULATE ( MAX ( D_Match[Buts du match] ) ) * 100 - CALCULATE ( MAX ( D_Match[N° match] ) ), , DESC ) )
```

### Matchs sans but

```dax
Matchs sans but =
CALCULATE ( COUNTROWS ( D_Match ), D_Match[Buts du match] = 0 ) + 0
```


## 12 Duel de nations

### Choix A
> Nation A du duel, la Côte d'Ivoire par défaut

```dax
Choix A =
SELECTEDVALUE ( DuelA[Id DuelA], 3 )
```

### Choix B
> Nation B du duel, le Nigeria par défaut

```dax
Choix B =
SELECTEDVALUE ( DuelB[Id DuelB], 2 )
```

### DA Nom

```dax
DA Nom =
VAR t = [Choix A] RETURN CALCULATE ( SELECTEDVALUE ( D_Equipe[Équipe] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DA Surnom

```dax
DA Surnom =
VAR t = [Choix A] RETURN CALCULATE ( SELECTEDVALUE ( D_Equipe[Surnom] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DA Drapeau

```dax
DA Drapeau =
VAR t = [Choix A] RETURN CALCULATE ( SELECTEDVALUE ( D_Equipe[Drapeau] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DA Parcours

```dax
DA Parcours =
VAR t = [Choix A] RETURN CALCULATE ( SELECTEDVALUE ( D_Equipe[Parcours] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DA Matchs

```dax
DA Matchs =
VAR t = [Choix A] RETURN CALCULATE ( [Matchs joués], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DA Bilan

```dax
DA Bilan =
VAR t = [Choix A] RETURN CALCULATE ( FORMAT ( [Victoires], "0" ) & " V · " & FORMAT ( [Nuls], "0" ) & " N · " & FORMAT ( [Défaites], "0" ) & " D", REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DA Buts marqués

```dax
DA Buts marqués =
VAR t = [Choix A] RETURN CALCULATE ( [Buts marqués], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DA Buts encaissés

```dax
DA Buts encaissés =
VAR t = [Choix A] RETURN CALCULATE ( [Buts encaissés], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DA Clean sheets

```dax
DA Clean sheets =
VAR t = [Choix A] RETURN CALCULATE ( [Clean sheets], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DA Possession

```dax
DA Possession =
VAR t = [Choix A] RETURN CALCULATE ( [Possession moyenne], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DA Tirs par match

```dax
DA Tirs par match =
VAR t = [Choix A] RETURN CALCULATE ( [Tirs par match], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DA Cartons

```dax
DA Cartons =
VAR t = [Choix A] RETURN CALCULATE ( [Cartons], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DA Spectateurs

```dax
DA Spectateurs =
VAR t = [Choix A] RETURN CALCULATE ( SUMX ( F_EquipeMatch, RELATED ( D_Match[Affluence] ) ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DA Profil

```dax
DA Profil =
VAR t = [Choix A] RETURN CALCULATE ( AVERAGE ( F_Stat[Valeur] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Nom

```dax
DB Nom =
VAR t = [Choix B] RETURN CALCULATE ( SELECTEDVALUE ( D_Equipe[Équipe] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Surnom

```dax
DB Surnom =
VAR t = [Choix B] RETURN CALCULATE ( SELECTEDVALUE ( D_Equipe[Surnom] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Drapeau

```dax
DB Drapeau =
VAR t = [Choix B] RETURN CALCULATE ( SELECTEDVALUE ( D_Equipe[Drapeau] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Parcours

```dax
DB Parcours =
VAR t = [Choix B] RETURN CALCULATE ( SELECTEDVALUE ( D_Equipe[Parcours] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Matchs

```dax
DB Matchs =
VAR t = [Choix B] RETURN CALCULATE ( [Matchs joués], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Bilan

```dax
DB Bilan =
VAR t = [Choix B] RETURN CALCULATE ( FORMAT ( [Victoires], "0" ) & " V · " & FORMAT ( [Nuls], "0" ) & " N · " & FORMAT ( [Défaites], "0" ) & " D", REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Buts marqués

```dax
DB Buts marqués =
VAR t = [Choix B] RETURN CALCULATE ( [Buts marqués], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Buts encaissés

```dax
DB Buts encaissés =
VAR t = [Choix B] RETURN CALCULATE ( [Buts encaissés], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Clean sheets

```dax
DB Clean sheets =
VAR t = [Choix B] RETURN CALCULATE ( [Clean sheets], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Possession

```dax
DB Possession =
VAR t = [Choix B] RETURN CALCULATE ( [Possession moyenne], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Tirs par match

```dax
DB Tirs par match =
VAR t = [Choix B] RETURN CALCULATE ( [Tirs par match], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Cartons

```dax
DB Cartons =
VAR t = [Choix B] RETURN CALCULATE ( [Cartons], REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Spectateurs

```dax
DB Spectateurs =
VAR t = [Choix B] RETURN CALCULATE ( SUMX ( F_EquipeMatch, RELATED ( D_Match[Affluence] ) ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### DB Profil

```dax
DB Profil =
VAR t = [Choix B] RETURN CALCULATE ( AVERAGE ( F_Stat[Valeur] ), REMOVEFILTERS ( D_Equipe ), D_Equipe[Team_ID] = t )
```

### Confrontation directe

```dax
Confrontation directe =
VAR a = [Choix A] VAR b = [Choix B] VAR ms = FILTER ( ALL ( D_Match ), ( D_Match[DomID] = a && D_Match[ExtID] = b ) || ( D_Match[DomID] = b && D_Match[ExtID] = a ) ) RETURN IF ( a = b, "Choisissez deux nations différentes", IF ( COUNTROWS ( ms ) = 0, "Aucune confrontation directe pendant le tournoi", CONCATENATEX ( ms, D_Match[Étiquette] & " : " & D_Match[Affiche], " · ", D_Match[N° match], ASC ) ) )
```
