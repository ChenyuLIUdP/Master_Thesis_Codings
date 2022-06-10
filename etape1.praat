# mémoire m2 script 1 : sélection des extraits avec les indices (diphtongue, ton, locuteur, sexe)
# Saisie du chemin d'accès du dossier (chemin relatif par défaut)

form Information

   comment Chemin d'accès du dossier:
   text chemin ../1300Extraits/

endform

Create Strings as file list: "fileList", chemin$ + "*" + ".wav"

selectObject: "Strings fileList"
nSon = Get number of strings

for iSon from 1 to nSon

   selectObject: "Strings fileList"

   fichierSonNom$ = Get string: iSon

   indexExtension = rindex (fichierSonNom$, ".wav")
   nomFichierBase$ = left$ (fichierSonNom$, indexExtension - 1)

   sexe$ = mid$ (fichierSonNom$, 28,1)
   locuteur$ = mid$ (fichierSonNom$, 28,4)


   fichierSon$ = chemin$ + fichierSonNom$
   fichierGrilles$ = chemin$ + nomFichierBase$ + ".TextGrid"

   # Champ de sons
   iChamp = 1
   # Champ de mots (syllabes)
   jChamp = 2
   # Champ de caractères 
   kChamp = 3

   son = Open long sound file: fichierSon$
   grille = Read from file: fichierGrilles$

   selectObject: grille
   nIntervalles = Get number of intervals: iChamp

   for iIntervalle from 1 to nIntervalles

      selectObject: grille
      label$ = Get label of interval: iChamp, iIntervalle 

      if label$ = "a" or label$ = "á" or label$ = "â" or label$ = "à" 

         if iIntervalle < nIntervalles

            jIntervalle = iIntervalle + 1
            kIntervalle = iIntervalle - 1

            selectObject: grille
            labelCoda$ = Get label of interval: iChamp, jIntervalle

            if labelCoda$ = "w"

               selectObject: grille 
               if kIntervalle <> 0
                  labelInitial$ = Get label of interval: iChamp, kIntervalle
                  tPre = Get start point: iChamp, kIntervalle
               elsif kIntervalle = 0 
                  labelInitial$ = "null"
                  tPre = Get start point: iChamp, iIntervalle
               endif

               if jIntervalle <> nIntervalles
                  lIntervalle = jIntervalle + 1
                  tPost = Get end point: iChamp, lIntervalle
               elsif jIntervalle = nIntervalles
                  tPost = Get end point: iChamp, jIntervalle
               endif

               if labelInitial$ <> "y" 

                  selectObject: grille 
                  tDeb = Get start point: iChamp, iIntervalle
                  tFin = Get end point: iChamp, jIntervalle
                  tFinNoyau = Get end point: iChamp, iIntervalle
                  tDebCoda = Get start point: iChamp, jIntervalle

                  selectObject: grille 
                  motNoyau = Get interval at time: jChamp, tDeb
                  motCoda = Get interval at time: jChamp, tDebCoda

                  if motCoda = motNoyau

                     selectObject: son
                     extraitSon = Extract part: tPre, tPost, "no"

                     if label$ = "a" 
                        ton = 1
                        ton$ = "1"
                     elsif label$ = "á" 
                        ton = 2
                        ton$ = "2"
                     elsif label$ = "â" 
                        ton = 3
                        ton$ = "3"
                     elsif label$ = "à" 
                        ton = 4
                        ton$ = "4"
                     endif 

                     diphtongue$ = "au"

                     selectObject: grille
                     mot$ = Get label of interval: jChamp, motNoyau
                     extraitGrille = Extract part: tPre, tPost, "no"

                     iSon$ = string$(iSon)
                     iIntervalle$ = string$(iIntervalle)


                     selectObject: extraitSon
                     Save as WAV file: chemin$ + diphtongue$ + ton$ + "/" + locuteur$ + "-" + mot$ + "-" + iSon$ + "-" + iIntervalle$ + ".wav"
                     selectObject: extraitGrille
                     Save as text file: chemin$ + diphtongue$ + ton$ + "/" + locuteur$ + "-" + mot$ + "-" + iSon$ + "-" + iIntervalle$ + ".TextGrid"

                     selectObject:extraitSon
                     plusObject: extraitGrille
                     Remove


                  endif
               endif
            endif
         endif
      endif
   endfor

   selectObject: grille 
   plusObject: son 
    
   Remove

endfor

for iSon from 1 to nSon

   selectObject: "Strings fileList"

   fichierSonNom$ = Get string: iSon

   indexExtension = rindex (fichierSonNom$, ".wav")
   nomFichierBase$ = left$ (fichierSonNom$, indexExtension - 1)

   sexe$ = mid$ (fichierSonNom$, 28,1)
   locuteur$ = mid$ (fichierSonNom$, 28,4)

   fichierSon$ = chemin$ + fichierSonNom$
   fichierGrilles$ = chemin$ + nomFichierBase$ + ".TextGrid"

   # Champ de sons
   iChamp = 1
   # Champ de mots (syllabes)
   jChamp = 2
   # Champ de caractères 
   kChamp = 3

   son = Open long sound file: fichierSon$
   grille = Read from file: fichierGrilles$

   selectObject: grille
   nIntervalles = Get number of intervals: iChamp

   for iIntervalle from 1 to nIntervalles

      selectObject: grille
      label$ = Get label of interval: iChamp, iIntervalle 


      if label$ = "A" or label$ = "Á" or label$ = "Â" or label$ = "À" 
         
         if iIntervalle < nIntervalles

            jIntervalle = iIntervalle + 1
            kIntervalle = iIntervalle - 1

            selectObject: grille
            labelCoda$ = Get label of interval: iChamp, jIntervalle

            if labelCoda$ = "y"

               selectObject: grille 
               if kIntervalle <> 0
                  labelInitial$ = Get label of interval: iChamp, kIntervalle
                  tPre = Get start point: iChamp, kIntervalle
               elsif kIntervalle = 0 
                  labelInitial$ = "null"
                  tPre = Get start point: iChamp, iIntervalle
               endif

               if jIntervalle <> nIntervalles
                  lIntervalle = jIntervalle + 1
                  tPost = Get end point: iChamp, lIntervalle
               elsif jIntervalle = nIntervalles
                  tPost = Get end point: iChamp, jIntervalle
               endif

               if labelInitial$ <> "w" 

                  selectObject: grille 
                  tDeb = Get start point: iChamp, iIntervalle
                  tFin = Get end point: iChamp, jIntervalle
                  tFinNoyau = Get end point: iChamp, iIntervalle
                  tDebCoda = Get start point: iChamp, jIntervalle

                  selectObject: grille 
                  motNoyau = Get interval at time: jChamp, tDeb
                  motCoda = Get interval at time: jChamp, tDebCoda

                  if motCoda = motNoyau

                     selectObject: son
                     extraitSon = Extract part: tPre, tPost, "no"

                     if label$ = "A" 
                        ton = 1
                        ton$ = "1"
                     elsif label$ = "Á" 
                        ton = 2
                        ton$ = "2"
                     elsif label$ = "Â" 
                        ton = 3
                        ton$ = "3"
                     elsif label$ = "À" 
                        ton = 4
                        ton$ = "4"
                     endif 

                     diphtongue$ = "ai"

                     selectObject: grille
                     mot$ = Get label of interval: jChamp, motNoyau
                     extraitGrille = Extract part: tPre, tPost, "no"

                     iSon$ = string$(iSon)
                     iIntervalle$ = string$(iIntervalle)

                     selectObject: extraitSon
                     Save as WAV file: chemin$ + diphtongue$ + ton$ + "/" + locuteur$ + "-" + mot$ + "-" + iSon$ + "-" + iIntervalle$ + ".wav"
                     selectObject: extraitGrille
                     Save as text file: chemin$ + diphtongue$ + ton$ + "/" + locuteur$ + "-" + mot$ + "-" + iSon$ + "-" + iIntervalle$ + ".TextGrid"

                     selectObject:extraitSon
                     plusObject: extraitGrille
                     Remove


                 endif
               endif
            endif
         endif
      endif
   endfor

   selectObject: grille 
   plusObject: son 
    
   Remove

endfor

for iSon from 1 to nSon

   selectObject: "Strings fileList"

   fichierSonNom$ = Get string: iSon

   indexExtension = rindex (fichierSonNom$, ".wav")
   nomFichierBase$ = left$ (fichierSonNom$, indexExtension - 1)

   sexe$ = mid$ (fichierSonNom$, 28,1)
   locuteur$ = mid$ (fichierSonNom$, 28,4)

   fichierSon$ = chemin$ + fichierSonNom$
   fichierGrilles$ = chemin$ + nomFichierBase$ + ".TextGrid"

   # Champ de sons
   iChamp = 1
   # Champ de mots (syllabes)
   jChamp = 2
   # Champ de caractères 
   kChamp = 3

   son = Open long sound file: fichierSon$
   grille = Read from file: fichierGrilles$

   selectObject: grille
   nIntervalles = Get number of intervals: iChamp

   for iIntervalle from 1 to nIntervalles

      selectObject: grille
      label$ = Get label of interval: iChamp, iIntervalle


      if label$ = "e" or label$ = "é" or label$ = "ê" or label$ = "è" 

         if iIntervalle < nIntervalles

            jIntervalle = iIntervalle + 1
            kIntervalle = iIntervalle - 1

            selectObject: grille
            labelCoda$ = Get label of interval: iChamp, jIntervalle

            if labelCoda$ = "y"

               selectObject: grille 
               if kIntervalle <> 0
                  labelInitial$ = Get label of interval: iChamp, kIntervalle
                  tPre = Get start point: iChamp, kIntervalle
               elsif kIntervalle = 0 
                  labelInitial$ = "null"
                  tPre = Get start point: iChamp, iIntervalle
               endif

               if jIntervalle <> nIntervalles
                  lIntervalle = jIntervalle + 1
                  tPost = Get end point: iChamp, lIntervalle
               elsif jIntervalle = nIntervalles
                  tPost = Get end point: iChamp, jIntervalle
               endif

               if labelInitial$ <> "w" 

                  selectObject: grille 
                  tDeb = Get start point: iChamp, iIntervalle
                  tFin = Get end point: iChamp, jIntervalle
                  tFinNoyau = Get end point: iChamp, iIntervalle
                  tDebCoda = Get start point: iChamp, jIntervalle

                  selectObject: grille 
                  motNoyau = Get interval at time: jChamp, tDeb
                  motCoda = Get interval at time: jChamp, tDebCoda

                  if motCoda = motNoyau

                     selectObject: son
                     extraitSon = Extract part: tPre, tPost, "no"

                     if label$ = "e" 
                        ton = 1
                        ton$ = "1"
                     elsif label$ = "é" 
                        ton = 2
                        ton$ = "2"
                     elsif label$ = "ê" 
                        ton = 3
                        ton$ = "3"
                     elsif label$ = "è" 
                        ton = 4
                        ton$ = "4"
                     endif 

                     diphtongue$ = "ei"

                     selectObject: grille
                     mot$ = Get label of interval: jChamp, motNoyau
                     extraitGrille = Extract part: tPre, tPost, "no"

                     iSon$ = string$(iSon)
                     iIntervalle$ = string$(iIntervalle)

                     selectObject: extraitSon
                     Save as WAV file: chemin$ + diphtongue$ + ton$ + "/" + locuteur$ + "-" + mot$ + "-" + iSon$ + "-" + iIntervalle$ + ".wav"
                     selectObject: extraitGrille
                     Save as text file: chemin$ + diphtongue$ + ton$ + "/" + locuteur$ + "-" + mot$ + "-" + iSon$ + "-" + iIntervalle$ + ".TextGrid"

                     selectObject:extraitSon
                     plusObject: extraitGrille
                     Remove



                 endif
               endif
            endif
         endif
      endif
   endfor

   selectObject: grille 
   plusObject: son 
    
   Remove

endfor

for iSon from 1 to nSon

   selectObject: "Strings fileList"

   fichierSonNom$ = Get string: iSon

   indexExtension = rindex (fichierSonNom$, ".wav")
   nomFichierBase$ = left$ (fichierSonNom$, indexExtension - 1)

   sexe$ = mid$ (fichierSonNom$, 28,1)
   locuteur$ = mid$ (fichierSonNom$, 28,4)

   fichierSon$ = chemin$ + fichierSonNom$
   fichierGrilles$ = chemin$ + nomFichierBase$ + ".TextGrid"

   # Champ de sons
   iChamp = 1
   # Champ de mots (syllabes)
   jChamp = 2
   # Champ de caractères 
   kChamp = 3

   son = Open long sound file: fichierSon$
   grille = Read from file: fichierGrilles$

   selectObject: grille
   nIntervalles = Get number of intervals: iChamp

   for iIntervalle from 1 to nIntervalles

      selectObject: grille
      label$ = Get label of interval: iChamp, iIntervalle

      if label$ = "o" or label$ = "ó" or label$ = "ô" or label$ = "ò"

         if iIntervalle < nIntervalles

            jIntervalle = iIntervalle + 1
            kIntervalle = iIntervalle - 1

            selectObject: grille
            labelCoda$ = Get label of interval: iChamp, jIntervalle

            if labelCoda$ = "w"

               selectObject: grille 
               if kIntervalle <> 0
                  labelInitial$ = Get label of interval: iChamp, kIntervalle
                  tPre = Get start point: iChamp, kIntervalle
               elsif kIntervalle = 0 
                  labelInitial$ = "null"
                  tPre = Get start point: iChamp, iIntervalle
               endif

               if jIntervalle <> nIntervalles
                  lIntervalle = jIntervalle + 1
                  tPost = Get end point: iChamp, lIntervalle
               elsif jIntervalle = nIntervalles
                  tPost = Get end point: iChamp, jIntervalle
               endif

               if labelInitial$ <> "y" 

                  selectObject: grille 
                  tDeb = Get start point: iChamp, iIntervalle
                  tFin = Get end point: iChamp, jIntervalle
                  tFinNoyau = Get end point: iChamp, iIntervalle
                  tDebCoda = Get start point: iChamp, jIntervalle

                  selectObject: grille 
                  motNoyau = Get interval at time: jChamp, tDeb
                  motCoda = Get interval at time: jChamp, tDebCoda

                  if motCoda = motNoyau

                     selectObject: son
                     extraitSon = Extract part: tPre, tPost, "no"

                     if label$ = "o" 
                        ton = 1
                        ton$ = "1"
                     elsif label$ = "ó" 
                        ton = 2
                        ton$ = "2"
                     elsif label$ = "ô" 
                        ton = 3
                        ton$ = "3"
                     elsif label$ = "ò" 
                        ton = 4
                        ton$ = "4"
                     endif 

                     diphtongue$ = "ou"

                     selectObject: grille
                     mot$ = Get label of interval: jChamp, motNoyau
                     extraitGrille = Extract part: tPre, tPost, "no"

                     iSon$ = string$(iSon)
                     iIntervalle$ = string$(iIntervalle)

                     selectObject: extraitSon
                     Save as WAV file: chemin$ + diphtongue$ + ton$ + "/" + locuteur$ + "-" + mot$ + "-" + iSon$ + "-" + iIntervalle$ + ".wav"
                     selectObject: extraitGrille
                     Save as text file: chemin$ + diphtongue$ + ton$ + "/" + locuteur$ + "-" + mot$ + "-" + iSon$ + "-" + iIntervalle$ + ".TextGrid"

                     selectObject:extraitSon
                     plusObject: extraitGrille
                     Remove


                  endif
               endif
            endif
         endif
      endif
   endfor   

   selectObject: grille 
   plusObject: son 
    
   Remove

endfor

selectObject: "Strings fileList"

Remove

pauseScript: "Click Continue when you're done"















