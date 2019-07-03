; ==============================================
;
; (c) Harm creative enterprises inc.
;
; fall 2003
;
; ==============================================
(defun c:t2z()

	; =======================================
	; Yo stel hier het aantal decimalen in van de X en Y die je wilt trekken
	(setq iDecimalen 2)
	(setq sFilename "text2z.dat")
	; =======================================

	; maak het exportbestand aan
	(setq f (open sFilename "w"))
	(setq ss (ssget))
	; teller om door alle elementen te lopen
	(setq cn 0)
	; als de gebruiker iets geselecteer heeft
	(if ss
		(progn		
			; voor het aantal elementen in de set
			(repeat (sslength ss)
				; vraag aan acad de gegevens van het huidige element
				(setq ent (entget (ssname ss cn)))
				' plak de x, de y en de waarde van de tekst aan elkaar
				(setq aline (strcat 
					(rtos (cadr (assoc 10 ent)) 2 iDecimalen) 
					", "
					(rtos (caddr (assoc 10 ent)) 2 iDecimalen)
					", "
					(cdr (assoc 1 ent))
					"\n")
				)
				; plaats de regel in een bestand
				(princ aline f)
				; hoog de teller op om het volgende element te pakken te krijgen
				(setq cn (1+ cn))
			)
		)
	)
	; sluit het bestand
	(setq f (close f))
)
