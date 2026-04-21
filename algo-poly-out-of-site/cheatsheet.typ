#import "@local/dobbikov:1.0.0": *
#import "@preview/cetz:0.4.2" as cetz

// ── Page ──────────────────────────────────────────────────────────────────────
#set page(paper: "a4", margin: (x: 0.85cm, y: 0.75cm), columns: 2)
#set text(size: 7.5pt, font: "New Computer Modern")
#set par(spacing: 2.5pt, leading: 4.5pt)

// ── Heading styles ────────────────────────────────────────────────────────────
#show heading.where(level: 1): it => {
  v(5pt)
  block(
    fill: rgb("#1e3a5f"), width: 100%, inset: (x: 5pt, y: 3.5pt), radius: 2pt,
    text(fill: white, weight: "bold", size: 9pt, it.body)
  )
  v(2pt)
}
#show heading.where(level: 2): it => {
  v(4pt)
  block(
    fill: rgb("#dbeafe"), width: 100%, inset: (x: 4pt, y: 2pt), radius: 1.5pt,
    text(fill: rgb("#1e3a5f"), weight: "bold", size: 8pt, it.body)
  )
  v(1.5pt)
}
#show heading.where(level: 3): it => {
  v(3pt)
  text(fill: rgb("#1d4ed8"), weight: "bold", size: 7.5pt, it.body)
  linebreak()
}

// ── Colour helpers ────────────────────────────────────────────────────────────
#let rd(t) = text(fill: rgb("#dc2626"), t)
#let gn(t) = text(fill: rgb("#059669"), t)
#let am(t) = text(fill: rgb("#d97706"), t)
#let bl(t) = text(fill: rgb("#1d4ed8"), t)

// ── Box helpers ───────────────────────────────────────────────────────────────
#let bdef(body) = block(
  fill: rgb("#eff6ff"), stroke: (left: 2pt + rgb("#1d4ed8")),
  inset: (x: 4pt, y: 2.5pt), width: 100%, radius: (right: 2pt),
  below: 3pt, above: 2pt, body)

#let balgo(body) = block(
  fill: rgb("#fefce8"), stroke: (left: 2pt + rgb("#ca8a04")),
  inset: (x: 4pt, y: 2.5pt), width: 100%, radius: (right: 2pt),
  below: 3pt, above: 2pt, body)

#let bthm(body) = block(
  fill: rgb("#f0fdf4"), stroke: (left: 2pt + rgb("#16a34a")),
  inset: (x: 4pt, y: 2.5pt), width: 100%, radius: (right: 2pt),
  below: 3pt, above: 2pt, body)

#let bwarn(body) = block(
  fill: rgb("#fff1f2"), stroke: (left: 2pt + rgb("#dc2626")),
  inset: (x: 4pt, y: 2.5pt), width: 100%, radius: (right: 2pt),
  below: 3pt, above: 2pt, body)

#let binsight(body) = block(
  fill: rgb("#faf5ff"), stroke: (left: 2pt + rgb("#7c3aed")),
  inset: (x: 4pt, y: 2.5pt), width: 100%, radius: (right: 2pt),
  below: 3pt, above: 2pt, body)

// ── Figure helper (scaled inline) ─────────────────────────────────────────────
#let fig(path, cap, sc: 82%) = {
  figure(
    scale(sc, reflow: true, include path),
    caption: text(size: 6.5pt, cap),
    gap: 3pt,
  )
  v(2pt)
}

// ── Small comparison table helper ─────────────────────────────────────────────
#let ctab(body) = block(
  fill: luma(247), stroke: 0.4pt + luma(180),
  inset: (x: 4pt, y: 3pt), radius: 2pt, width: 100%,
  {set text(size: 7pt); body})

// ── Title ─────────────────────────────────────────────────────────────────────
#align(center)[
  #text(weight: "bold", size: 11pt)[Systèmes Distribués — Aide-Mémoire Complet]
  #linebreak()
  #text(size: 6.8pt, fill: luma(80))[Yehor KOROTENKO · 2026 · 9 chapitres · toutes les figures]
]
#v(4pt)

// ══════════════════════════════════════════════════════════════════════════════
= 1. Causalité & Horloges logiques
// ══════════════════════════════════════════════════════════════════════════════

== Modèle de base

#bdef[
  *Système distribué* : $n$ processus $P_1,dots,P_n$ sans mémoire partagée. Communication par messages uniquement. Histoire locale $h_i$ = séquence d'événements : local, send($m$), receive($m$).
]

== Relation happens-before ($arrow.r$)

#bdef[
  Plus petit ordre strict vérifiant :
  + *Ordre local* — $e$ avant $f$ sur le même processus $arrow.r.double e arrow.r f$
  + *Communication* — send($m$) $arrow.r$ receive($m$)
  + *Transitivité* — $e arrow.r f arrow.r g arrow.r.double e arrow.r g$

  *Concurrence* : $e parallel f$ ssi $not(e arrow.r f)$ et $not(f arrow.r e)$.
]

#fig("figures/causality.typ",
  [$e_1 arrow.r e_2 arrow.r e_3$ (chaîne causale) ; $e_4 parallel e_2, e_4 parallel e_3$ (concurrents — pointillé teal)], sc: 88%)

== Horloges de Lamport (scalaires)

#bdef[Chaque $P_i$ maintient un entier $C_i := 0$.]

#balgo[
  - *Événement local ou envoi* : $C_i := C_i + 1$ ; joindre $C_i$ au message.
  - *Réception* de $(m, t_s)$ : $C_i := max(C_i, t_s) + 1$.
]

#bthm[
  $e arrow.r f arrow.r.double L(e) < L(f)$.

  *Limitation* : $L(e) < L(f) arrow.r.not e arrow.r f$ — ne détecte *pas* la concurrence.
]

#fig("figures/lamport-clocks.typ",
  [Lamport 2 processus. Envoi ts=2 ; réception $C := max(0,2)+1=3$. Propriété et limitation en bas.], sc: 90%)

== Horloges vectorielles (Fidge–Mattern 1988)

#bdef[
  Chaque $P_i$ maintient $V_i in NN^n$ initialisé à $bold(0)$.

  *Ordre componentwise* : $V < W$ ssi $forall k: V[k] lt.eq W[k]$ et $exists k: V[k] < W[k]$.
]

#balgo[
  - *Événement local / envoi* : $V_i [i] := V_i [i] + 1$ ; joindre $V_i$.
  - *Réception* de $(m, V_m)$ : $forall k: V_i [k] := max(V_i [k], V_m [k])$, puis $V_i [i]++$.
]

#bthm[
  *Équivalence exacte* : $e arrow.r f arrow.l.r V(e) < V(f)$.

  $e parallel f arrow.l.r V(e)$ et $V(f)$ incomparables.

  Coût : vecteur taille $n$ par message et par processus.
]

#binsight[
  Lamport = extension linéaire de $arrow.r$ (utile pour mutex). Vectoriel = caractérisation exacte (utile pour détection de concurrence, snapshots).
]

#fig("figures/vector-clocks.typ",
  [Vectoriel 3 processus. Rouge = incomparables (concurrent). Vert bas = $lt.eq$ (causal vérifié).], sc: 88%)

// ══════════════════════════════════════════════════════════════════════════════
= 2. Diffusion
// ══════════════════════════════════════════════════════════════════════════════

== Inondation (Flooding)

#balgo[
  *Initiateur* : envoie à tous ses voisins.

  *Nœud, première réception* : retransmettre à tous les voisins sauf l'émetteur.

  *Nœud, réceptions suivantes* : ignorer.

  Messages $: lt.eq 2|E|$ (≤ 2 par arête) — Temps $: O("diam")$
]

#fig("figures/flooding.typ",
  [Flooding 4 nœuds. A informe B,C ; B et C informent D. Doublons ignorés.], sc: 82%)

== Diffusion sur arbre couvrant

#balgo[
  Hypothèse : arbre couvrant connu. Initiateur → fils ; chaque nœud → ses fils.

  Messages : exactement $N-1$ (*optimal*) — Temps : $O("profondeur")$
]

#fig("figures/tree-diffusion.typ",
  [Arbre couvrant. $N-1 = 4$ messages exactement. Optimal en nombre de messages.], sc: 82%)

== Vague d'acquittements

#balgo[
  *Phase 1 (descente)* : diffusion root → feuilles ($N-1$ msgs).

  *Phase 2 (remontée des ACK)* : feuille → ACK immédiatement ; nœud interne → ACK quand *tous* ses fils ont acquitté.

  *Total* : $2(N-1)$ messages. Root sait que tout le monde a reçu.
]

#fig("figures/ack-wave.typ",
  [ACK wave. Bleu = diffusion. Teal = acquittements. Root reçoit le dernier ACK = terminaison confirmée.], sc: 82%)

// ══════════════════════════════════════════════════════════════════════════════
= 3. Arbres couvrants & routage
// ══════════════════════════════════════════════════════════════════════════════

== DFS avec jeton

#balgo[
  Jeton unique circule en DFS. À chaque nœud : voisin non visité → avancer ; tous visités → backtracker.

  Messages : $O(|E|)$ — Temps : $O(|E|)$ — Résultat : *arbre DFS* (séquentiel)
]

#fig("figures/dfs-token.typ",
  [Jeton DFS (T amber). Arêtes de l'arbre DFS en couleur. Backtrack = retour au parent.], sc: 84%)

== Flooding parallèle → BFS

#balgo[
  Chaque nœud se déclare fils du *premier* émetteur reçu. Suivants : rejetés.

  Messages : $O(|E|)$ — Temps : $O("diam")$ — Résultat : *arbre BFS*
]

#fig("figures/flooding-tree.typ",
  [BFS par flooding. B,C,D prennent A comme parent. Croix rouge = message rejeté (nœud déjà revendiqué).], sc: 84%)

== Bellman-Ford distribué

#balgo[
  Init : $d("src") = 0$, $d(v) = infinity$ sinon.

  *Chaque round* : diffuser $d(v)$. Sur réception de $d(u)$ : si $d(u)+w(u,v) < d(v)$ → mettre à jour.

  Convergé si aucune maj depuis 1 round. Rounds $lt.eq N-1$. Msgs $O(N|E|)$.
]

#fig("figures/bellman-ford.typ",
  [Bellman-Ford A–B–C–D avec raccourci A–C. Convergence en 3 rounds. Arbre SP résultant.], sc: 84%)

// ══════════════════════════════════════════════════════════════════════════════
= 4. Exclusion mutuelle distribuée
// ══════════════════════════════════════════════════════════════════════════════

#bdef[
  *Sûreté* : $lt.eq 1$ processus en SC. *Vivacité* : toute demande accordée. *Équité* : FIFO par horodatage.
]

== Solution centralisée

#balgo[
  *$P_i$* : REQ($i$) → GRANT → SC → RELEASE.

  *Coordinateur $P_c$* : sur REQ : libre → GRANT ; sinon → file FIFO. Sur RELEASE : dépiler → GRANT.

  *3 msgs/SC* — #rd[Point unique de défaillance]
]

== Lamport 1978 — entièrement distribué

#balgo[
  *1. Demande* : $C_i{++}$, diffuser DEMANDE$(C_i,i)$, ajouter $(C_i,i)$ à $Q_i$.

  *2. Réception* DEMANDE$(t,j)$ : $C_i := max+1$, ajouter $(t,j)$ à $Q_i$, répondre ACK.

  *3. Entrée SC* : $(C_i,i)$ est $<_"lex"$-min de $Q_i$ *ET* ACK de tous les $P_j$ avec ts $> C_i$.

  *4. Sortie SC* : diffuser SORTIE$(C_i,i)$ → tous retirent $(C_i,i)$ de leurs files.
]

#bthm[
  *$3(N-1)$ msgs/SC* : DEMANDE + ACK + SORTIE, chacun $times (N-1)$.

  *Sûreté* : si $P_i$ et $P_j$ en SC avec $(C_i,i) <_"lex" (C_j,j)$, alors $P_j$ aurait dû attendre l'ACK de $P_i$ — contradiction.
]

#fig("figures/lamport-mutex.typ",
  [Lamport n=3. Jaune=DEMANDE, teal=ACK, bleu=SORTIE. Chaque phase $n-1=2$ msgs. Total $3(n-1)=6$.], sc: 82%)

== Ricart-Agrawala 1981

#balgo[
  Sur réception REQ$(t_j,j)$ par $P_i$ :
  - $(t_j,j) <_"lex" (t_i,i)$ et pas en SC → répondre *immédiatement*
  - En SC ou priorité plus haute → *différer* la réponse

  Sortie SC : envoyer toutes les réponses différées. *$2(N-1)$ msgs/SC.*
]

#fig("figures/ricart-agrawala.typ",
  [RA. P1(ts=3) prioritaire sur P2(ts=5). P2 répond imméd. P1 diffère → envoie en sortant.], sc: 82%)

== RA avec jeton explicite

#balgo[
  Jeton = $"jeton"[1..n]$ (nb d'entrées passées).

  *Demande* : broadcaster DEMANDE$(k_i)$.

  *Détenteur reçoit* DEMANDE$(k_j)$ : si $k_j > "jeton"[j]$ → transmettre jeton.

  *Sortie* : $"jeton"[i]++$. Libération implicite. *$lt.eq 2(N-1)$ msgs/SC.*
]

== Anneau à jeton

#balgo[
  Jeton circule $P_1 arrow.r dots arrow.r P_n arrow.r P_1$. Détenteur : SC si désiré, puis passer.

  Meilleur : 0 msgs — Pire : $N-1$ msgs — #rd[Vulnérable à la perte du jeton]
]

#fig("figures/token-ring.typ",
  [Token Ring. T amber = jeton. P2 retient pour entrer en SC (bleu ciel). Passage sinon.], sc: 82%)

#ctab[
  #table(
    columns: (1.5fr, 0.9fr, 0.8fr),
    align: (left, center, center),
    stroke: 0.3pt,
    table.header[*Algorithme*][*Msgs/SC*][*Robustesse*],
    [Centralisé], [3], [coord],
    [Lamport], [$3(N-1)$], [—],
    [Ricart-A.], [$2(N-1)$], [—],
    [RA+jeton], [$lt.eq 2(N-1)$], [jeton],
    [Token Ring], [0 à $N-1$], [jeton],
  )
]

// ══════════════════════════════════════════════════════════════════════════════
= 5. Tolérance aux pannes
// ══════════════════════════════════════════════════════════════════════════════

#bdef[
  *Hiérarchie* : Crash $subset$ Omission $subset$ Byzantin
]

#balgo[
  - *Crash* : processus s'arrête définitivement. Détectable par timeout. $gt.eq 2f+1$ nœuds pour $f$ pannes.
  - *Omission* : perd certains msgs (send ou receive). Vivant mais peu fiable.
  - *Byzantin* : arbitraire, peut mentir, envoyer des valeurs contradictoires. $gt.eq 3f+1$ nœuds.
]

#fig("figures/fault-types.typ",
  [Hiérarchie : Crash (💀) $subset$ Omission (📭) $subset$ Byzantin (🎭). Seuils en bas.], sc: 80%)

#bthm[
  *Réplication* : $k$ répliques → masque $k-1$ pannes crash. Resynchronisation à la reprise.
]

// ══════════════════════════════════════════════════════════════════════════════
= 6. Élection de chef
// ══════════════════════════════════════════════════════════════════════════════

#bdef[
  *Propriétés* : Terminaison + Accord (1 seul élu) + Validité (élu = id max des corrects).

  *Hypothèse* : identifiants uniques. Topologie : anneau.
]

== Chang-Roberts (anneau unidirectionnel, 1979)

#bdef[
  *Extinction sélective* : chaque processus envoie son id dans le sens de l'anneau. Seul le max fait le tour complet.
]

#balgo[
  *Sur réception de $v$ par $P_i$* :
  - $v < "mon\_id"$ → #gn[transmettre $v$]
  - $v > "mon\_id"$ → #rd[éliminer (ignorer) $v$]
  - $v = "mon\_id"$ → #am[élu !] — diffuser LEADER$(v)$
]

#bthm[
  *Correction* : le max $M$ n'est jamais éliminé → fait le tour complet → $P_M$ élu.

  *Pire cas* : $O(n^2)$ (IDs décroissants : $sum_{k=1}^{n} k = n(n+1)/2$).

  *Cas moyen* : $O(n log n)$ (permutation aléatoire des IDs).
]

#fig("figures/chang-roberts.typ",
  [Chang-Roberts 5 processus. id=5 (P2) transite partout → retour = élu (♛). Croix = élimination.], sc: 84%)

== Peterson (anneau bidirectionnel, 1982)

#balgo[
  Phases alternant direction. Chaque actif $P_i$ :
  + Envoyer $a_i$ à droite ; recevoir $a_"left"$ de gauche.
  + Relayer $a_"left"$ à droite ; recevoir $a_"ll"$ (voisin du voisin gauche).
  + Si $a_"left" > max(a_i, a_"ll")$ : $a_i <- a_"left"$ (survit). Sinon : éliminé (relaie seulement).

  *Terminaison* : 1 actif → élu, diffuse LEADER.
]

#bthm[
  *Lemme* : deux actifs adjacents ne peuvent pas tous deux survivre → $gt.eq 1/2$ éliminés par phase.

  $O(log n)$ phases $times O(n)$ msgs = *$O(n log n)$* total.
]

#ctab[
  #table(
    columns: (1.3fr, 0.9fr, 0.9fr, 0.7fr),
    align: (left, center, center, center),
    stroke: 0.3pt,
    table.header[*Algo*][*Topologie*][*Pire cas*][*Élu*],
    [Chang-Roberts], [Unidirectionnel], [$O(n^2)$], [id max],
    [Peterson], [Bidirectionnel], [$O(n log n)$], [id max],
  )
]

// ══════════════════════════════════════════════════════════════════════════════
= 7. Détection de terminaison
// ══════════════════════════════════════════════════════════════════════════════

#bwarn[
  *Piège* : "tous les processus sont passifs" $arrow.r.not$ terminaison. Des messages en transit peuvent réactiver un passif.
]

#fig("figures/termination-problem.typ",
  [Manager voit P1,P2 passifs, mais $m$ en transit → faux positif. P2 se réactive.], sc: 82%)

== Dijkstra-Safra — anneau synchrone

#bdef[
  Jeton blanc/noir circule sur l'anneau.
]

#balgo[
  *$P_i$ reçoit le jeton* :
  - A envoyé un msg depuis le dernier passage : #rd[noircir le jeton].
  - Sinon : transmettre inchangé.

  *Initiateur reçoit jeton blanc* et est lui-même passif → *terminaison*.

  *Jeton noir* → réinitialiser blanc, recommencer.
]

#bthm[
  Tour blanc = aucun msg envoyé "vers l'avant" → pas de réactivation possible.
]

#fig("figures/dijkstra-safra.typ",
  [D-S. Gauche vert = tour blanc = terminaison. Droite rouge = jeton noirci = recommencer.], sc: 80%)

== Safra avec compteurs (asynchrone)

#balgo[
  $"me"_i = "msgs\_envoyés"_i - "msgs\_reçus"_i$. $sum_i "me"_i = 0$ ssi aucun msg en transit.

  Jeton = (couleur, $q$). Sur réception : si noir → teinter jeton ; transmettre $(c, q + "me"_i)$.

  Terminaison ssi jeton blanc ET $P_0$ blanc/passif ET $q + "me"_0 = 0$.
]

== Mattern — crédit (topologie quelconque)

#balgo[
  Invariant : $sum "crédits" = 1$.

  Leader part avec crédit=1. Envoi : piggybacker crédit/2, garder crédit/2. Récepteur : crédit += reçu. Passif : retourner crédit au leader. Leader : $"ret"=1$ → terminaison.
]

#binsight[
  D-S = anneau synchrone. Safra compteurs = anneau asynchrone. Mattern = toute topologie.
]

// ══════════════════════════════════════════════════════════════════════════════
= 8. Snapshot global (Cliché)
// ══════════════════════════════════════════════════════════════════════════════

== Coupe cohérente

#bdef[
  *Coupe* $C$ : préfixe $h_i^c$ de l'histoire de chaque $P_i$ (photo locale $s_i^star$).

  *Cohérente* : $e in C$ et $e' arrow.r e$ $arrow.r.double e' in C$ (pas de "message du futur").

  *État de canal* $c_(i j)^star$ = msgs envoyés par $P_i$ dans le passé de $C$ mais non encore reçus par $P_j$.
]

#fig("figures/consistent-cut.typ",
  [Coupe (pointillé rouge). Bleu = pre-shot, gris = post-shot. Amber = en transit (état canal). Rouge = interdit.], sc: 82%)

== Chandy-Lamport — canaux FIFO

#balgo[
  *Initiateur $P_i$* : enregistrer $s_i^star$ ; envoyer MARKER sur chaque canal sortant.

  *$P_j$ reçoit MARKER, 1ère fois* ($"taken" = F$) : enregistrer $s_j^star$, $c_(i j)^star := nothing$ (FIFO garantit), envoyer MARKER sur tous sortants.

  *$P_j$ reçoit MARKER, déjà taken* : $c_(i j)^star :=$ msgs reçus depuis $s_j^star$ jusqu'à ce MARKER.
]

#bthm[
  $(s_i^star, c_(i j)^star)$ = coupe cohérente + significative. Sans horloge globale.
]

#fig("figures/chandy-lamport.typ",
  [CL 3 processus. ⚑ = MARKER. Vert = $s^star$ enregistré. Canal 1→2 = $nothing$ (FIFO).], sc: 82%)

== Lai-Yang — canaux non-FIFO

#balgo[
  1 bit tag par message. $P_i$ se prend en photo : $"taken"_i := T$, msgs futurs tag $= T$.

  $P_j$ reçoit msg tag $= T$ et $"taken"_j = F$ : enregistrer $s_j^star$, $"taken"_j := T$.

  $c_(i j)^star$ = msgs tag $= F$ reçus par $P_j$ après $"taken"_j := T$.

  Coût : 1 bit/msg, 0 message de contrôle.
]

#ctab[
  #table(
    columns: (1fr, 1fr, 1fr),
    align: center,
    stroke: 0.3pt,
    table.header[*Critère*][*Chandy-Lamport*][*Lai-Yang*],
    [Canaux], [FIFO], [Quelconques],
    [Overhead], [1 MARKER/canal], [1 bit/msg],
    [Msgs ctrl], [$n(n-1)$], [0],
  )
]

// ══════════════════════════════════════════════════════════════════════════════
= 9. Consensus
// ══════════════════════════════════════════════════════════════════════════════

#bdef[
  *Accord* : deux corrects ne décident pas des valeurs différentes.
  *Validité* : valeur décidée = valeur initiale d'un correct.
  *Terminaison* : tout correct décide en temps fini.
]

== Impossibilité FLP (1985)

#bwarn[
  *Théorème FLP* : en système *asynchrone* avec $gt.eq 1$ panne crash possible, aucun algorithme déterministe ne garantit Accord + Validité + Terminaison simultanément.

  *Preuve (sketch)* : argument de configuration bivalente. On ne peut pas distinguer "processus lent" de "processus crashé". L'adversaire retarde les messages pour maintenir l'ambivalence indéfiniment.

  *Contournement* : Paxos/Raft = synchronie partielle + leader. PBFT = $3f+1$ répliques. Randomisation = termination en probabilité 1.
]

== Généraux byzantins (LSP)

#bwarn[*Borne inférieure* : avec $f$ byzantins, consensus impossible si $n < 3f+1$.]

#balgo[
  *Exemple* $n=4, f=1$ : byzantin $C$ envoie 1 à $A,B$ mais 0 à $D$.
  - $A$ : vote 1. $B$ : vote 1. $D$ : vote 0. #rd[Désaccord.]

  *Solution* : avec $n gt.eq 3f+1$, algo LSP en $f+1$ tours d'échanges de vecteurs.
]

#fig("figures/byzantine.typ",
  [Byzantin C envoie 1 à A/B mais 0 à D. Désaccord banner rouge. $n gt.eq 3f+1$ nécessaire.], sc: 84%)

== Flood-Set — synchrone, pannes crash

#bdef[
  $omega_i$ = ensemble de valeurs connues, init $= {"propre valeur"}$.
]

#balgo[
  *Répéter $f+1$ fois* :
  + Broadcaster $omega_i$ à tous.
  + $omega_i := omega_i union "toutes valeurs reçues"$.

  *Décision* : si $|omega_i| = 1$ → décider $omega_i$ ; sinon → décider $min(omega_i)$.
]

#bthm[
  *Pourquoi $f+1$ phases ?* Parmi $f+1$ phases, au moins une est *sans panne*. Durant cette phase, tous les $omega_i$ s'égalisent (chaque correct reçoit les mêmes valeurs).

  *Lemme clé* : une fois $omega_i$ égaux, ils restent égaux (union d'ensembles identiques = même ensemble).

  *Optimalité* : $f+1$ phases nécessaires (l'adversaire crashe 1 processus par phase sur $f$ phases).

  *Complexité* : $O((f+1) dot n^2)$ msgs, $f+1$ rounds.
]

#binsight[
  FLP = impossibilité en asynchrone même avec 1 crash. Flood-Set = possible en synchrone avec $f+1$ rounds. La synchronie est le facteur déterminant. Avec des byzantins, LSP avec $n gt.eq 3f+1$ nœuds.
]

// ── Légende ───────────────────────────────────────────────────────────────────
#v(1fr)
#line(length: 100%, stroke: 0.4pt + luma(180))
#text(size: 6pt, fill: luma(130))[
  *Abréviations* : SC = section critique · FIFO = First In First Out · $|E|$ = arêtes · $N/n$ = processus · $f$ = pannes tolérées · diam = diamètre · SP = plus court chemin · LSP = Lamport-Shostak-Pease · RA = Ricart-Agrawala · FLP = Fischer-Lynch-Paterson · CL = Chandy-Lamport · LY = Lai-Yang · D-S = Dijkstra-Safra
]
