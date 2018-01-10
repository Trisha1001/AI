; This program helps a user decide on the most suitable laptop based on user specific information such as: profession, income, familiarity with OS and so on.
; The output of this program is a specific computer model (including CPU and GPU models)

;;; Instructions to run ;;;
; Open Clips.
; Click on file, then load and load this file.
; Execute the program using "ctrl +R" or (Exectution -> run) or type "(run)" in the dialog window.
; Answer the questions using lowcase letters.

; N.B. Not all Questions will show up for all users, some questions only appear based on the user's response.
; N.B. The program includes error checking for the user input.







;Start CLIPS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Start Classes Definition;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass COMPUTER 
			(is-a USER)
			(role concrete)
			(slot fullname)
			(slot brand)
			(slot OS)
			(slot model)
            (slot processor)
            (slot graphics)
)

(defclass PERSON 
			(is-a USER)
			(role concrete)
			(slot profession)
    	  	(slot programmer)
         	(slot gamedeveloper)
			(slot newuser)
			(slot earning)
			(slot lastos)

			(slot picked-brand)
			(slot picked-os)
			(slot picked-model)
            (slot picked-processor)
            (slot picked-graphics)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;End Classes Definition;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Start Initializing;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule START

=>
	(printout t "Welcome to TriMy.. your PC purchasing Guide." crlf crlf)
	(printout t "Please use lowercase letters to answer the following questions." crlf crlf)

	(make-instance mainuser of PERSON)

	(make-instance pc1 of COMPUTER (fullname Dell-Windows-Inspiron)(brand dell)(OS windows)(model inspiron))
    (make-instance pc11 of COMPUTER (fullname Dell-Windows-Lattitude-Corei7)(brand dell)(OS windows)(model lattitude)(processor Corei7))
    (make-instance pc111 of COMPUTER (fullname Dell-Windows-Lattitude-Corei7-GTX1060)(brand dell)(OS windows)(model lattitude)(processor Corei7)(graphics GTX1060))
    (make-instance pc1111 of COMPUTER (fullname Dell-Windows-Lattitude-Corei5-GTX560)(brand dell)(OS windows)(model lattitude)(processor Corei5)(graphics GTX560))
    (make-instance pc11111 of COMPUTER (fullname Dell-Windows-Inspiron-Corei7)(brand dell)(OS windows)(model inspiron)(processor Corei7))
    (make-instance pc11113 of COMPUTER (fullname Dell-Windows-XPS-Corei7-GTX560)(brand dell)(OS windows)(model XPS)(processor Corei7)(graphics GTX560))
    (make-instance pc2 of COMPUTER (fullname Apple-Mac-MacBookPro)(brand apple)(OS mac)(model MacBookPro))
    (make-instance pc22 of COMPUTER (fullname Apple-Mac-MacBookPro)(brand apple)(OS mac)(model MacBookPro)(processor Corei7))
    (make-instance pc222 of COMPUTER (fullname Apple-Mac-MacBookPro-GTX950)(brand apple)(OS mac)(model MacBookPro)(processor Corei7)(graphics GTX950))
    (make-instance pc2222 of COMPUTER (fullname Apple-Mac-MacBookPro-Corei5)(brand apple)(OS mac)(model MacBookPro)(processor Corei5))
    (make-instance pc22222 of COMPUTER (fullname Apple-Mac-MacBookPro-Corei5-GTX580)(brand apple)(OS mac)(model MacBookPro)(processor Corei5)(graphics GTX580))
    (make-instance pc22223 of COMPUTER (fullname Apple-Mac-MacBookAir-Corei5)(brand apple)(OS mac)(model MacBookAir)(processor Corei5))
    (make-instance pc3 of COMPUTER (fullname HP-Linux-Elite)(brand hp)(OS linux)(model elite))
    (make-instance pc33 of COMPUTER (fullname HP-Linux-ENVY)(brand hp)(OS linux)(model ENVY)(processor Corei7))
    (make-instance pc333 of COMPUTER (fullname HP-Linux-ENVY-Corei7-GTX745)(brand hp)(OS linux)(model ENVY)(processor Corei7)(graphics GTX745))
    (make-instance pc3333 of COMPUTER (fullname HP-Linux-ENVY-Corei5)(brand hp)(OS linux)(model ENVY)(processor Corei5))
    (make-instance pc33333 of COMPUTER (fullname HP-Linux-elite-Corei7-GTX580)(brand hp)(OS linux)(model ENVY)(processor Corei7)(graphics GTX580))
        
  	(assert (started yes))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;End Initializing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;start User Input;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Ask user whether user profession is student, businessman or jobholder. Ask user whether he/she is going to use pc first time 

(defrule enter_data
	(started yes)
=>
	(printout t "Are you a (student, businessman or jobholder)?" crlf)
	(send [mainuser] put-profession (read))

	(printout t "Is this your first PC? (yes or no)" crlf)
	(send [mainuser] put-newuser (read))
)


; If user is businessman or jobholder, ask whether he/she earns more than 3500$ per month.

(defrule enter_earning
	?ins<-(object (is-a PERSON)(profession businessman|jobholder) )
=>
	(printout t "Do you earn more than $3500 per month?(yes or no)" crlf)
	(send ?ins put-earning (read))
)

; If user is not a new user, ask the os user had used.

(defrule enter_lastos
	?ins<-(object (is-a PERSON)(newuser no) )
=>
	(printout t "What was your last used OS(windows, linux or mac)?" crlf)
	(send ?ins put-picked-os (read))
)

; If user is student or jobholder, ask whether he/she is a computer programmer.

(defrule enter_programming
	?ins<-(object (is-a PERSON)(profession student|jobholder) )
=>
	(printout t "Are you a computer programmer?(yes or no)" crlf)
	(send ?ins put-programmer (read))
)

; If user is student or jobholder and he/she is a computer programmer, ask whether he/she is gamedeveloper.

(defrule enter_gaming
	?ins<-(object (is-a PERSON)(profession student|jobholder) (programmer yes))
=>
	(printout t "Are you a game developer?(yes or no)" crlf)
	(send ?ins put-gamedeveloper (read))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;End User Input;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;start Error Checking;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule error_checking1
	(object (is-a PERSON)
			(profession ?prof)
			)

=>
	(assert (prof ?prof))
)


(defrule error_checking2
	(object (is-a PERSON)
			(newuser ?newu)
			)

=>
	(assert (newu ?newu))
)

(defrule error_checking3
	(object (is-a PERSON)
			(picked-os ?ose)
			)

=>
	(assert (ose ?ose))
)

(defrule error_checking4
	(object (is-a PERSON)(profession student|jobholder)
			(programmer ?pgmr)
			)

=>
	(assert (pgmr ?pgmr))
)

(defrule error_checking5
	(object (is-a PERSON)(programmer yes)
			(gamedeveloper ?gmdvlpr)
			)

=>
	(assert (gmdvlpr ?gmdvlpr))
)

(defrule error_checking6
	(object (is-a PERSON)(profession businessman|jobholder)
			(earning ?erng)
			)

=>
	(assert (erng ?erng))
)

(defrule error_prof
	(prof ~student)(prof ~businessman)(prof ~jobholder)
=>
	(printout t "You wrote a wrong answer for profession! The program is reseting" crlf crlf crlf)
	(reset)
)

(defrule error_newuser
	(newu ~yes)(newu ~no)
=>
	(printout t "You wrote a wrong answer for first pc! The program is reseting" crlf crlf crlf)
	(reset)
)

(defrule error_os
	(ose ~mac)(ose ~windows)(ose ~linux)
=>
	(printout t "You wrote a wrong answer for os! The program is reseting" crlf crlf crlf)
	(reset)
)

(defrule error_programmer
	(pgmr ~yes)(pgmr ~no)
=>
	(printout t "You wrote a wrong answer for programmer! The program is reseting" crlf crlf crlf)
	(reset)
)


(defrule error_gamedeveloper
	(gmdvlpr ~yes)(gmdvlpr ~no)
=>
	(printout t "You wrote a wrong answer for game developer! The program is reseting" crlf crlf crlf)
	(reset)
)

(defrule error_earning
	(erng ~yes)(erng ~no)
=>
	(printout t "You wrote a wrong answer for earning! The program is reseting" crlf crlf crlf)
	(reset)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;End Error Checking;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;start rules;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; If user is student and first time buying laptop and not a programmer then preferable os is windows.

(defrule rule1
	?ins<-(object (is-a PERSON)(profession student)(newuser yes)(programmer no))
=>
	(send ?ins put-picked-os windows)
)

; If user is student and first time buying laptop and programmer but not a gamedeveloper then preferable os is mac.

(defrule rule2
	?ins<-(object (is-a PERSON)(profession student)(newuser yes)(programmer yes)(gamedeveloper no))
=>
	(send ?ins put-picked-os mac)
)

; If user is student and first time buying laptop and programmer and gamedeveloper then preferable os is mac.

(defrule rule3
	?ins<-(object (is-a PERSON)(profession student)(newuser yes)(programmer yes)(gamedeveloper yes))
=>
	(send ?ins put-picked-os mac)        
)

; if user chooses windows as os then brand should be dell.

(defrule rule4
	?ins<-(object (is-a PERSON)(picked-os windows) )
=>
	(send ?ins put-picked-brand dell)
)

; If user chooses linux as os then brand should be hp.

(defrule rule5
	?ins<-(object (is-a PERSON)(picked-os linux) )
=>
	(send ?ins put-picked-brand hp)
)

; If user chooses mac as os then brand should be apple

(defrule rule6
	?ins<-(object (is-a PERSON)(picked-os mac) )
=>
	(send ?ins put-picked-brand apple)
)

; If user is a student, brand is dell and not a programmer then model should be inspiron.

(defrule rule7
	?ins<-(object (is-a PERSON)(profession student)(picked-brand dell) (programmer no))
=>	
	(send ?ins put-picked-model inspiron)
)

; If user is student, brand is dell, programmer but not a game developer then processor and model should be corei7 and ;lattitude respectively.

(defrule rule8
	?ins<-(object (is-a PERSON)(profession student)(picked-brand dell) (programmer yes)(gamedeveloper no))
=>	
     (send ?ins put-picked-processor Corei7)
     (send ?ins put-picked-model lattitude)
)

; If user is student, brand is dell, programmer and game developer then processor, graphics and model should be corei7, ;GTX106o and lattitude respectively.

(defrule rule9
	?ins<-(object (is-a PERSON)(profession student)(picked-brand dell) (programmer yes)(gamedeveloper yes))
=>	
     (send ?ins put-picked-processor Corei7)
     (send ?ins put-picked-graphics GTX1060)
     (send ?ins put-picked-model lattitude)
)

; If user is student, brand is hp and not a programmer then model is elite.

(defrule rule10
	?ins<-(object (is-a PERSON)(profession student)(picked-brand hp) (programmer no))
=>
	(send ?ins put-picked-model elite)
)

; If user is student, brand hp, programmer but not a game developer then processor and model should be Corei7 and ENVY.

(defrule rule11
	?ins<-(object (is-a PERSON)(profession student)(picked-brand hp) (programmer yes)(gamedeveloper no))
=>	
       (send ?ins put-picked-processor Corei7)
       (send ?ins put-picked-model ENVY)
)

; If user is student, brand hp, programmer and game developer then processor, graphics and model 
;should be Corei7, GTX745 and ENVY.

(defrule rule12
	?ins<-(object (is-a PERSON)(profession student)(picked-brand hp) (programmer yes)(gamedeveloper yes))
=>
       (send ?ins put-picked-processor Corei7)
       (send ?ins put-picked-graphics GTX745)
       (send ?ins put-picked-model ENVY)
)

; If user is student, brand is apple and not a programmer then model is MacBookPro.

(defrule rule13
	?ins<-(object (is-a PERSON)(profession student)(picked-brand apple) (programmer no))
=>
	(send ?ins put-picked-model MacBookPro)
)

; If user is student, brand apple, programmer but not game developer then processor and model should be Corei7 and ;MacBookPro.

(defrule rule14
	?ins<-(object (is-a PERSON)(profession student)(picked-brand apple) (programmer yes)(gamedeveloper no))
=>	
        (send ?ins put-picked-processor Corei7)
        (send ?ins put-picked-model MacBookPro)
)

; If user is student, brand apple, programmer and game developer then processor, graphics and model should be Corei7, GTX950 ;and MacBookPro

(defrule rule15
	?ins<-(object (is-a PERSON)(profession student)(picked-brand apple)(programmer yes)(gamedeveloper yes))
=>
	(send ?ins put-picked-processor Corei7)
    (send ?ins put-picked-graphics GTX950)
    (send ?ins put-picked-model MacBookPro)
)

;(defrule rule16
;	?ins<-(object (is-a PERSON)(profession jobholder)(newuser yes)(earning no)(programmer no))
;=>
;	(send ?ins put-picked-os windows)
;)

; If user is a jobholder, brand dell, earning less than 3500$, not a programmer then model is inspiron

(defrule rule17
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand dell)(earning no)(programmer no))
=>	
	(send ?ins put-picked-model inspiron)
)

; If user is jobholder, first time buying pc and earns more than 3500$ per month then os should be mac.

(defrule rule18
	?ins<-(object (is-a PERSON)(profession jobholder)(newuser yes)(earning yes))
=>
	(send ?ins put-picked-os mac)
)

; If user is a jobholder, brand is apple, earns more than 3500$/month, not a programmer then processor and model should be ;Corei5 and NacBookPro.

(defrule rule19
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand apple)(earning yes)(programmer no))
=>
	(send ?ins put-picked-processor Corei5)
    (send ?ins put-picked-model MacBookPro)
)

; If user is a jobholder, brand apple, earns less than 3500$/month, not a programmer then processor Corei5 and model ;MacBookPro.

(defrule rule20
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand apple)(earning no)(programmer no))
=>
	(send ?ins put-picked-processor Corei5)
    (send ?ins put-picked-model MacBookPro)
)

; If user is a jobholder, brand apple, earns more than 3500$/month, programmer but not a game developer then processor Corei7 ;and model MacBookPro.

(defrule rule21
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand apple)(earning yes)(programmer yes)(gamedeveloper no))
=>
	(send ?ins put-picked-processor Corei7)
    (send ?ins put-picked-model MacBookPro)
)

; If user is a jobholder, brand apple, earns more than 3500$/month, programmer and game developer then processor corei7, ;graphics GTX950 and model MacBookPro.

(defrule rule22
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand apple)(earning yes)(programmer yes)(gamedeveloper yes))
=>
	(send ?ins put-picked-processor Corei7)
    (send ?ins put-picked-graphics GTX950)
    (send ?ins put-picked-model MacBookPro)
)


; If user is jobholder, brand apple, earns less than 3500$/month, programmer but not a game developer then processor Corei5 ;and model MacBook Pro.

(defrule rule23
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand apple)(earning no)(programmer yes)(gamedeveloper no))
=>
	(send ?ins put-picked-processor Corei5)
    (send ?ins put-picked-model MacBookPro)
)

; If user is jobholder, brand apple, earning less than 3500$/month, programmer, game developer then processor corei5, 
; graphics GTX580 and model MacBook Pro.

(defrule rule24
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand apple)(earning no)(programmer yes)(gamedeveloper yes))
=>
	(send ?ins put-picked-processor Corei5)
    (send ?ins put-picked-graphics GTX580)
    (send ?ins put-picked-model MacBookPro)
)

; If user is a jobholder, first time buying pc and earns less than 3500$/month then os should be windows.

(defrule rule25
	?ins<-(object (is-a PERSON)(profession jobholder)(newuser yes)(earning no))
=>
	(send ?ins put-picked-os windows)
)

;(defrule rule26
;	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand dell)(earning no)(programmer no))
;=>	
;	(send ?ins put-picked-model inspiron)
;)

; If user is a jobholder, brand dell, earns more than 3500$/month, not a programmer then processor corei7 and model ;lattitude.

(defrule rule27
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand dell)(earning yes)(programmer no))
=>
	
	(send ?ins put-picked-processor Corei7)
    (send ?ins put-picked-model lattitude)
)

; If user is jobholder, brand dell, earns more than 3500$/month, programmer but not a developer then processor corei7
; model lattitude.

(defrule rule28
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand dell)(earning yes)(programmer yes)(gamedeveloper no))
=>	
     (send ?ins put-picked-processor Corei7)
     (send ?ins put-picked-model lattitude)
)

; If user is a jobholder, brand dell, earns less than 3500$/month, programmer but not a game developer then
; processor Corei7 and model inspiron.

(defrule rule29
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand dell)(earning no)(programmer yes)(gamedeveloper no))
=>	
     (send ?ins put-picked-processor Corei7)
     (send ?ins put-picked-model inspiron)
)

; If user is a jobholder, brand dell, earns more than 3500$/month, programmer and game developer then
; processor corei7, graphics GTX1060 and model lattitude.

(defrule rule30
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand dell)(earning yes)(programmer yes)(gamedeveloper yes))
=>	
     (send ?ins put-picked-processor Corei7)
     (send ?ins put-picked-graphics GTX1060)
     (send ?ins put-picked-model lattitude)
)

; If user is jobholder, brand dell, earns less than 3500$/month, programmer and game developer then
; processor corei5, graphics GTX560 and model lattitude.

(defrule rule31
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand dell)(earning no)(programmer yes)(gamedeveloper yes))
=>	
     (send ?ins put-picked-processor Corei5)
     (send ?ins put-picked-graphics GTX560)
     (send ?ins put-picked-model lattitude)
)

; If user is a jobholder, earns less than 3500$/month, brand hp, not a programmer then model should be elite.


(defrule rule32
	?ins<-(object (is-a PERSON)(profession jobholder)(earning no)(picked-brand hp) (programmer no))
=>
	(send ?ins put-picked-model elite)
)

; If user is a jobholder, earns more than 3500$/month, brand hp, not a programmer then processor corei7, model ENVY.

(defrule rule33
	?ins<-(object (is-a PERSON)(profession jobholder)(earning yes)(picked-brand hp) (programmer no))
=>
	(send ?ins put-picked-processor Corei7)
	(send ?ins put-picked-model ENVY)
)

; If user is jobholder, brand hp, earns less than 3500$/month, programmer but not a game developer then
; Processor corei5 and model ENVY.

(defrule rule34
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand hp)(earning no)(programmer yes)(gamedeveloper no))
=>	
   	(send ?ins put-picked-processor Corei5)
   	(send ?ins put-picked-model ENVY)
)

; If user is a jobholder, brand hp, earns more than 3500$/month, programmer but not a game developer then
; processor Corei7 and Model ENVY.

(defrule rule35
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand hp)(earning yes)(programmer yes)(gamedeveloper no))
=>	
   	(send ?ins put-picked-processor Corei7)
   	(send ?ins put-picked-model ENVY)
)

; if user is a jobholder, brand hp, earns less than 3500$/month, programmer, game developer then
; processor Corei7, graphics GTX580, model elite.

(defrule rule36
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand hp)(earning no)(programmer yes)(gamedeveloper yes))
=>	
   	(send ?ins put-picked-processor Corei7)
   	(send ?ins put-picked-graphics GTX580)
   	(send ?ins put-picked-model elite)
)

; If user is a jobholder, brand hp, earns more than 3500$/month, programmer and game developer
; then processor Corei7, graphics GTX745 and model ENVY.

(defrule rule37
	?ins<-(object (is-a PERSON)(profession jobholder)(picked-brand hp)(earning yes)(programmer yes)(gamedeveloper yes))
=>	
   	(send ?ins put-picked-processor Corei7)
   	(send ?ins put-picked-graphics GTX745)
   	(send ?ins put-picked-model ENVY)
)

; If user is a businessman, earns less than 3500$/month, brand hp then processot corei5 and model ENVY.

(defrule rule38
	?ins<-(object (is-a PERSON)(profession businessman)(earning no)(picked-brand hp))
=>
	(send ?ins put-picked-processor Corei5)
   	(send ?ins put-picked-model ENVY)
)

; If user is a businessman, earns more than 3500$/month, brand hp then
; processor corei7 and model ENVY.

(defrule rule39
	?ins<-(object (is-a PERSON)(profession businessman)(earning yes)(picked-brand hp))
=>
	(send ?ins put-picked-processor Corei7)
    (send ?ins put-picked-model ENVY)
)

; If user is a businessman, brand dell, earns less than 3500$/month then processor Corei5,
; graphics GTX560 and model lattitude.

(defrule rule40
	?ins<-(object (is-a PERSON)(profession businessman)(picked-brand dell)(earning no))
=>	
     (send ?ins put-picked-processor Corei5)
     (send ?ins put-picked-graphics GTX560)
     (send ?ins put-picked-model lattitude)
)

; If user is a businessman, brand dell, earns more than 3500$/month then processor Corei7,
; graphics GTX560 and model XPS.

(defrule rule41
	?ins<-(object (is-a PERSON)(profession businessman)(picked-brand dell)(earning yes))
=>	
     (send ?ins put-picked-processor Corei7)
     (send ?ins put-picked-graphics GTX560)
     (send ?ins put-picked-model XPS)
)

; If user is a businessman, brand apple, earns more than 3500$/month then processor Corei7,
; and model MacBookPro.

(defrule rule42
	?ins<-(object (is-a PERSON)(profession businessman)(picked-brand apple)(earning yes))
=>
	(send ?ins put-picked-processor Corei7)
    (send ?ins put-picked-model MacBookPro)
)


; If user is a businessman, brand apple, earns less than 3500$/month then processor Corei5,
; and model MacBookAir.

(defrule rule43
	?ins<-(object (is-a PERSON)(profession businessman)(picked-brand apple)(earning no))
=>
	(send ?ins put-picked-processor Corei5)
    (send ?ins put-picked-model MacBookAir)
)

; If user is a businessman and earns more than 3500$/month then os should be mac.

(defrule rule44
	?ins<-(object (is-a PERSON)(profession businessman)(earning yes)(newuser yes))
=>
	(send ?ins put-picked-os mac)
)

; If user is a businessman and earns less than 3500$/month then os should be windows.

(defrule rule45
	?ins<-(object (is-a PERSON)(profession businessman)(earning no)(newuser yes))
=>
	(send ?ins put-picked-os windows)
)

;;;;;Output Rule;;;;;;;;;;

(defrule rule100
	?per-ins <- (object (is-a PERSON)(picked-os ?oss)(picked-brand ?brands)(picked-model ?models) (picked-processor ?processors)(picked-graphics ?graphics))
	?ins <- (object (is-a COMPUTER) (OS ?oss) (brand ?brands) (model ?models) (processor ?processors)(graphics ?graphics))
=>
	(printout t "your computer is " (send ?ins get-fullname) crlf crlf)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;End rules;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;End CLIPS
