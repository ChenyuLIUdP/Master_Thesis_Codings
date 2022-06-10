# mémoire m2 script 2a: extractions des données à tester : /au/
# sexe, locuteur, durée, contextes, pow, ton
# f1,f2, avec la normalisation temporelle

# chemin d'accès du dossier

form Information

   comment Chemin d'accès du dossier:
   text chemin ../1300Extraits/
   text diphtongue au
   text ton 0
   comment i.g: ai1
endform

# str list of file names

Create Strings as file list: "fileList", chemin$ + diphtongue$ + ton$ + "/" + "*" + ".wav"

selectObject: "Strings fileList"
nSon = Get number of strings

fichierResultats$ = chemin$ + "tables/" + diphtongue$ + ton$ + ".txt"

writeFileLine: fichierResultats$, "numero", tab$, "sexe", tab$, "locuteur", tab$, "diphtongue", tab$, "ton", tab$, "pow", tab$, "contexte G", tab$, "contexte D", tab$, "duree(ms)", tab$, "measurement.no", tab$, "f1", tab$, "f2", tab$, "f3", tab$, "f0"

for iSon from 1 to nSon
	
	selectObject: "Strings fileList"

	fichierSonNom$ = Get string: iSon

    indexExtension = rindex (fichierSonNom$, ".wav")
    nomFichierBase$ = left$ (fichierSonNom$, indexExtension - 1)

    sexe$ = mid$ (fichierSonNom$, 1,1)
    locuteur$ = mid$ (fichierSonNom$, 1,4)
    numero$ = right$ (nomFichierBase$, 7)

    fichierSon$ = chemin$ + diphtongue$ + ton$ + "/" + fichierSonNom$
   	fichierGrilles$ = chemin$ + diphtongue$ + ton$ + "/" + nomFichierBase$ + ".TextGrid"

   	# Champ de sons
   	champ1 = 1
   	# Champ de diphtongue
   	champ2 = 2
   	# Champ de mots (syllabes)
   	champ3 = 3
   	# Champ de caractères 
   	champ4 = 4
   	# Champ d'information
   	champ5 = 5

   	# Lecture du fichier WAV comme objet Sound
   	son = Read from file: fichierSon$

   	# Lecture de la grille d'étiquetage comme objet TextGrid
   	grille = Read from file: fichierGrilles$

   	selectObject: grille
   	nIntervalles = Get number of intervals: champ2

   	for iIntervalle from 1 to nIntervalles

   		selectObject: grille
      	label$ = Get label of interval: champ2, iIntervalle 

      	if label$ = "aw" or label$ = "áw" or label$ = "âw" or label$ = "àw"

            if label$ = "aw"
               tone$ = "1" 
            elsif label$ = "áw" 
               tone$ = "2"
            elsif label$ = "âw" 
               tone$ = "3"
            elsif label$ = "àw"
               tone$ = "4"
            endif

      		contexte1 = iIntervalle - 1
      		contexte2 = iIntervalle + 1

      		selectObject: grille
            labelC1$ = Get label of interval: champ2, contexte1
            labelC2$ = Get label of interval: champ2, contexte2

            selectObject: grille 
            tDeb = Get start point: champ2, iIntervalle
            tFin = Get end point: champ2, iIntervalle

            duree = tFin - tDeb

            dureeMs = duree * 1000

            selectObject: grille 
            mot = Get interval at time: champ3, tDeb
            mot$ = Get label of interval: champ3, mot
            pow$ = Get label of interval: champ5, 1

            dt = duree/10
            t1 = tDeb
            t2 = tDeb + dt 
            t3 = tDeb + dt * 2 
            t4 = tDeb + dt * 3
            t5 = tDeb + dt * 4
            t6 = tDeb + dt * 5 
            t7 = tDeb + dt * 6
            t8 = tDeb + dt * 7
            t9 = tDeb + dt * 8
            t10 = tDeb + dt * 9
            t11 = tDeb + dt * 10

            selectObject: son
            if sexe$ = "F"
            	formants1 = To Formant (burg): 0, 5, 4900, 0.025, 30 
               # 5500 = 4900 contexte aw
            elsif sexe$ = "M"
            	formants1 = To Formant (burg): 0, 5, 4400, 0.025, 30 
               # 5000 = 4400 contexte aw
            endif

            

            selectObject: formants1
            #formants = Extract visible formant contour

            if sexe$ = "F"
               formants2 = Track: 3, 550, 1650, 2750, 3850, 4950, 1, 1, 1
            elsif sexe$ = "M"
               formants2 = Track: 3, 500, 1500, 2500, 3500, 4500, 1, 1, 1
            endif

            selectObject: formants1
            Remove

            selectObject: formants2
            f1t1 = Get value at time: 1, t1, "Hertz", "Linear"
            f1t2 = Get value at time: 1, t2, "Hertz", "Linear"
            f1t3 = Get value at time: 1, t3, "Hertz", "Linear"
            f1t4 = Get value at time: 1, t4, "Hertz", "Linear"
            f1t5 = Get value at time: 1, t5, "Hertz", "Linear"
            f1t6 = Get value at time: 1, t6, "Hertz", "Linear"
            f1t7 = Get value at time: 1, t7, "Hertz", "Linear"
            f1t8 = Get value at time: 1, t8, "Hertz", "Linear"
            f1t9 = Get value at time: 1, t9, "Hertz", "Linear"
            f1t10 = Get value at time: 1, t10, "Hertz", "Linear"
            f1t11 = Get value at time: 1, t11, "Hertz", "Linear"            
            f2t1 = Get value at time: 2, t1, "Hertz", "Linear"
            f2t2 = Get value at time: 2, t2, "Hertz", "Linear"
            f2t3 = Get value at time: 2, t3, "Hertz", "Linear"
            f2t4 = Get value at time: 2, t4, "Hertz", "Linear"
            f2t5 = Get value at time: 2, t5, "Hertz", "Linear"
            f2t6 = Get value at time: 2, t6, "Hertz", "Linear"
            f2t7 = Get value at time: 2, t7, "Hertz", "Linear"
            f2t8 = Get value at time: 2, t8, "Hertz", "Linear"
            f2t9 = Get value at time: 2, t9, "Hertz", "Linear"
            f2t10 = Get value at time: 2, t10, "Hertz", "Linear"
            f2t11 = Get value at time: 2, t11, "Hertz", "Linear" 
            f3t1 = Get value at time: 3, t1, "Hertz", "Linear"
            f3t2 = Get value at time: 3, t2, "Hertz", "Linear"
            f3t3 = Get value at time: 3, t3, "Hertz", "Linear"
            f3t4 = Get value at time: 3, t4, "Hertz", "Linear"
            f3t5 = Get value at time: 3, t5, "Hertz", "Linear"
            f3t6 = Get value at time: 3, t6, "Hertz", "Linear"
            f3t7 = Get value at time: 3, t7, "Hertz", "Linear"
            f3t8 = Get value at time: 3, t8, "Hertz", "Linear"
            f3t9 = Get value at time: 3, t9, "Hertz", "Linear"
            f3t10 = Get value at time: 3, t10, "Hertz", "Linear"
            f3t11 = Get value at time: 3, t11, "Hertz", "Linear" 

            # get f0 values

            selectObject: son

            # double estimation
            noprogress To Pitch (ac): 0, 75, 15, "yes", 0.03, 0.45, 0.01, 0.35, 0.14, 600
            q1 = Get quantile: 0, 0, 0.25, "Hertz"
            q3 = Get quantile: 0, 0, 0.75, "Hertz"
            floor = q1 * 0.75
            ceiling = q3 * 1.5
            if floor = undefined
               floor = 75
            endif 
            if ceiling = undefined
               ceiling = 600
            endif
            Remove
            selectObject: son
            pitch = noprogress To Pitch (ac): 0, floor, 15, "yes", 0.03, 0.45, 0.01, 0.35, 0.14, ceiling

            selectObject: pitch

            f0t1 = Get value at time: t1, "Hertz", "linear"
            f0t2 = Get value at time: t2, "Hertz", "linear"
            f0t3 = Get value at time: t3, "Hertz", "linear"
            f0t4 = Get value at time: t4, "Hertz", "linear"
            f0t5 = Get value at time: t5, "Hertz", "linear"
            f0t6 = Get value at time: t6, "Hertz", "linear"
            f0t7 = Get value at time: t7, "Hertz", "linear"
            f0t8 = Get value at time: t8, "Hertz", "linear"
            f0t9 = Get value at time: t9, "Hertz", "linear"
            f0t10 = Get value at time: t10, "Hertz", "linear"
            f0t11 = Get value at time: t11, "Hertz", "linear"

            
            appendFile: fichierResultats$, iSon, tab$, sexe$, tab$, locuteur$, tab$, diphtongue$, tab$, tone$, tab$, pow$, tab$, labelC1$, tab$, labelC2$, tab$, dureeMs, tab$, "0", tab$, f1t1, tab$, f2t1, tab$, f3t1, tab$, f0t1, newline$
            appendFile: fichierResultats$, iSon, tab$, sexe$, tab$, locuteur$, tab$, diphtongue$, tab$, tone$, tab$, pow$, tab$, labelC1$, tab$, labelC2$, tab$, dureeMs, tab$, "1", tab$, f1t2, tab$, f2t2, tab$, f3t2, tab$, f0t2, newline$
            appendFile: fichierResultats$, iSon, tab$, sexe$, tab$, locuteur$, tab$, diphtongue$, tab$, tone$, tab$, pow$, tab$, labelC1$, tab$, labelC2$, tab$, dureeMs, tab$, "2", tab$, f1t3, tab$, f2t3, tab$, f3t3, tab$, f0t3, newline$
            appendFile: fichierResultats$, iSon, tab$, sexe$, tab$, locuteur$, tab$, diphtongue$, tab$, tone$, tab$, pow$, tab$, labelC1$, tab$, labelC2$, tab$, dureeMs, tab$, "3", tab$, f1t4, tab$, f2t4, tab$, f3t4, tab$, f0t4, newline$
            appendFile: fichierResultats$, iSon, tab$, sexe$, tab$, locuteur$, tab$, diphtongue$, tab$, tone$, tab$, pow$, tab$, labelC1$, tab$, labelC2$, tab$, dureeMs, tab$, "4", tab$, f1t5, tab$, f2t5, tab$, f3t5, tab$, f0t5, newline$
            appendFile: fichierResultats$, iSon, tab$, sexe$, tab$, locuteur$, tab$, diphtongue$, tab$, tone$, tab$, pow$, tab$, labelC1$, tab$, labelC2$, tab$, dureeMs, tab$, "5", tab$, f1t6, tab$, f2t6, tab$, f3t6, tab$, f0t6, newline$
            appendFile: fichierResultats$, iSon, tab$, sexe$, tab$, locuteur$, tab$, diphtongue$, tab$, tone$, tab$, pow$, tab$, labelC1$, tab$, labelC2$, tab$, dureeMs, tab$, "6", tab$, f1t7, tab$, f2t7, tab$, f3t7, tab$, f0t7, newline$
            appendFile: fichierResultats$, iSon, tab$, sexe$, tab$, locuteur$, tab$, diphtongue$, tab$, tone$, tab$, pow$, tab$, labelC1$, tab$, labelC2$, tab$, dureeMs, tab$, "7", tab$, f1t8, tab$, f2t8, tab$, f3t8, tab$, f0t8, newline$
            appendFile: fichierResultats$, iSon, tab$, sexe$, tab$, locuteur$, tab$, diphtongue$, tab$, tone$, tab$, pow$, tab$, labelC1$, tab$, labelC2$, tab$, dureeMs, tab$, "8", tab$, f1t9, tab$, f2t9, tab$, f3t9, tab$, f0t9, newline$
            appendFile: fichierResultats$, iSon, tab$, sexe$, tab$, locuteur$, tab$, diphtongue$, tab$, tone$, tab$, pow$, tab$, labelC1$, tab$, labelC2$, tab$, dureeMs, tab$, "9", tab$, f1t10, tab$, f2t10, tab$, f3t10, tab$, f0t10, newline$
            appendFile: fichierResultats$, iSon, tab$, sexe$, tab$, locuteur$, tab$, diphtongue$, tab$, tone$, tab$, pow$, tab$, labelC1$, tab$, labelC2$, tab$, dureeMs, tab$, "10", tab$, f1t11, tab$, f2t11, tab$, f3t11, tab$, f0t11, newline$
            


            selectObject: formants2
            plusObject: pitch
            Remove
            
      	endif

   	endfor

      selectObject: grille 
      plusObject: son 
      Remove

endfor

# Suppression des objets Strings
selectObject: "Strings fileList"

Remove

pauseScript: "Click Continue when you're done"







