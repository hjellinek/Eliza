;;; ELIZA in Lisp by Bernie Cosell
;;; For more information see http://elizagen.org or http://shrager.org/eliza

;;; GENERAL NOTES:

;;; This file contains the raw transcriptions of two separate,
;;; complete Elizas: one from 1969 and one from 1972. Each has a
;;; function part and a script part. The transcripts arise from
;;; scanned printouts available through elizagen.org. There are some
;;; embedded transcriber's notes. As the original code has no comments
;;; at all, anything here that is a comment is "modern".

;;; *** THIS IS AN UNCHECKED TRANSCRIPTION -- THERE ARE LIKELY TO BE
;;; *** NUMEROUS TYPOS!

;;; Differences compared to the printed pages:
;;; - Both versions of the script contain a pattern (0 YOU 1 O), which
;;;   has here been corrected to (0 YOU 1 0) (letter O vs. digit 0).
;;; - Long lines in the 1969 script that were split on the printed page
;;;   were recombined.
;;; - A stray "^@" on the first page of the 1972 script was removed.

;;; ACKNOWLEDGEMENTS:

;;; Thanks to the following for assistance in transcribing this code
;;; from the original printouts, and then making it work: eMBee, Dave
;;; Cooper, Bob Felts, Saul Good, Ben Hyde, Simon Leinen, Patrick May,
;;; Charlie McMackin, Paul Nathan, Peter De Wachter, Thomas Russ,
;;; Patrick Stein, and Jeff Shrager.

;;; For more information, please contact Jeff Shrager (jshrager@stanford.edu)

;;; LICENSE:

;;; Bernie Cosell has placed his code under a Creative Commons
;;; "Attribution-ShareAlike 3.0 Unported" license, which is described
;;; here: http://creativecommons.org/licenses/by-sa/3.0/deed.en_US,
;;; and as this is merely a transcript of his original code, it seems
;;; like it should carry the same license.

;;; ===================================================================================
;;; |                                    1969 DOCFNS                                  |
;;; ===================================================================================

;;; Eliza-19690731-DOCFNSp1-00of06

;;; /DOCFNS/   31 JULY 1969  1007:42                             PAGE 1

(PROGN (PRIN1 (QUOTE FILE" CREATED ")
              T)
       (PRIN1 (QUOTE 08/22/68" 1522:26")
              T)
       (TERPRI T))
(DEFINEQ

(DOCTOR
  (LAMBDA NIL
    (PROG (SENTENCE KEYSTACK MEMSTACK TIMON)
          (SETSEPR 109 106 0)
          (SETBRK 14 12 31 1 13 8 9 27 26 3)
          (CONTROL T)
          (GCGAG NIL)
          (SETQ FLIPFLOP 0)
          (SETQ TIMON (QUOTIENT (CLOCK)
              60))
          (RECONSTRUCT (QUOTE (TELL ME YOUR PROBLEMS "."
                  PLEASE TERMINATE INPUT WITH A PERIOD OR A
                  QUESTION MARK "."))
            T)
          (SETNONE)
      A   (PRIN1 (QUOTE "
*"))
          (COND
            ((NULL (SETQ SENTENCE (MAKESENTENCE)))
              (GO A)))
          (SETQ KEYSTACK (CDR SENTENCE))
          (SETQ SENTENCE (CAR SENTENCE))
          (COND
            ((EQUAL SENTENCE (QUOTE (GOODBYE)))
              (RETURN (RECONSTRUCT (APPEND (QUOTE (IT'S BEEN
                          MY PLEASURE "," THAT'S))
                    (CONS (PACK (LIST (QUOTE $)
                          (REMAINDER (PLUS (QUOTIENT
                                  (CLOCK)
                                60)
                              (MINUS TIMON)
                              1440)
                            1440)
                          (QUOTE 0)))
                      (QUOTE (PLEASE "."))))
                  T))))
          (ANALYZE)
          (GO A)
      )))

;;; Eliza-19690731-DOCFNSp1-01of06

;;; /DOCFNS/   31 JULY 1969  1007:42                             PAGE 1:1

(MAKESENTENCE
  (LAMBDA NIL
    (PROG (FLAG WORD SENTENCE KEYSTACK)
      A1  (SETQ KEYSTACK (CONS))
          (SETQ SENTENCE (CONS))
      A   (SETQ WORD (RATOM))
          (COND
            ((NUMBERP WORD)
              (SETQ WORD (PACK (LIST (QUOTE *)
                    WORD)))))
          (COND
            ((EQ WORD RUBOUT)
              (RETURN (TERPRI)))
            ((MEMBER WORD TRMLIS)
              (TERPRI)
              (RETURN (RPLACD SENTENCE KEYSTACK)))
            ((MEMBER WORD PCTLIS)
              (COND
                ((NULL (CDR KEYSTACK))
                  (GO A1))
                ((NULL (SETQ FLAG (MAKESENTENCE)))
                  (RETURN))
                ((AND (CDDR FLAG)
                    (NOT (GREATERP (GETP (CDR KEYSTACK)
                          (QUOTE PRIORITY))
                         (GETP (CDDR FLAG)
                           (QUOTE PRIORITY)))))
                  (RETURN FLAG))
                (T (RETURN (RPLACD SENTENCE KEYSTACK))))))
          (TCONC (COND
              ((GETP WORD (QUOTE TRANSLATION)))
              (WORD))
            SENTENCE)
          (COND
            ((SETQ FLAG (GETP WORD (QUOTE MEMR)))
              (SETQ MEMSTACK (APPEND FLAG MEMSTACK))))
          (COND
            ((AND (SETQ FLAG (GETP WORD (QUOTE PRIORITY)))
                (CDR KEYSTACK)
                (GREATERP FLAG (GETP (CDR KEYSTACK)
                    (QUOTE PRIORITY))))
              (RPLACD KEYSTACK (CONS (CDR KEYSTACK)
                  (CDR WORD))))
            (FLAG (BCONC (CDR WORD)
                KEYSTACK)))
          (GO A)
      )))

;;; Eliza-19690731-DOCFNSp1-02of06

;;; /DOCFNS/   31 JULY 1969  1007:42                     PAGE 1:2

(ANALYZE
  (LAMBDA NIL
    (PROG (RULES PARSELIST CR)
          (BCONC (GETP (QUOTE NONE)
              (COND
                ((ZEROP (SETQ FLIPFLOP (PLUS 2 (MINUS
                            FLIPFLOP))))
                  (QUOTE MEM))
                ((QUOTE LASTRESORT))))
            KEYSTACK)
          (SETQ KEYSTACK (CDR KEYSTACK))
      A   (SETQ RULES (GETP KEYSTACK (QUOTE RULES)))
      B   (COND
           ((OR (NULL RULES)
                (EQ (CAR RULES)
                    (QUOTE NEWKEY)))
             (SETQ KEYSTACK (CAR KEYSTACK))
             (GO A))
           ((ATOM (CAR RULES))
             (SETQ RULES (GETP (CAR RULES)
                 (QUOTE RULES)))
             (GO B)))
          (SETQ PARSELIST (CONS NIL NIL))
          (COND
           ((NOT (TEST (CAAR RULES)
                 SENTENCE))
             (SETQ RULES (CDR RULES)))
           ((ATOM (SETQ CR (CAR (SETQ RULES (CAR (ADVANCE
                           RULES)))))))
           ((EQ (CAR CR)
               (QUOTE PRE))
             (SETQ SENTENCE (RECONSTRUCT (CADR CR)))
             (SETQ RULES (CDDR CR)))
           (T (RECONSTRUCT CR T)
             (MEMORY)
             (RETURN)))
          (GO B)
      )))

;;; Eliza-19690731-DOCFNSp1-03of06

;;; /docfns/   31 July 1969  1007:42

(TEST
  (LAMBDA (D S)
    (PROG (CD PSV)
          (SETQ PSV (CDR PARSELIST))
      LP  (COND
            ((NULL D)
              (COND
                (S (GO RN))
                (T (SETQ PARSELIST (CAR PARSELIST))
                  (RETURN T))))
            ((EQ 0 (SETQ CD (CAR D)))
              (GO T0))
            ((NULL S)
              (GO RN))
            ((NUMBERP CD)
              (TCONC S PARSELIST)
              (COND
                ((SETQ S (NTH S CD))
                  (GO T3))
                (T (GO RN))))
            ((ATOM CD)
              (COND
                ((EQ CD (CAR S)))
                (T (GO RN))))
            ((CAR CD)
              (COND
                ((MEMBER (CAR S)
                    CD))
                (T (GO RN))))
            ((TEST4 (CAR S)
                (CDR CD)))
            (T (GO RN)))
          (TCONC S PARSELIST)
      T3  (SETQ S (CDR S))
          (SETQ D (CDR D))
          (GO LP)
      T0  (TCONC S PARSELIST)
          (COND
            ((NULL (SETQ D (CDR D)))
              (SETQ PARSELIST (CAR PARSELIST))
              (RETURN T)))
      T1  (COND
            ((TEST D S)
              (RETURN T))
            ((SETQ S (CDR S))
              (GO T1)))
      RN  (RPLACD PARSELIST (COND
              (PSV (RPLACD PSV NIL))))
          (RETURN NIL)
      )))

;;; Eliza-19690731-DOCFNSp1-04of06

;;; * /DOCFNS/ 31 JULY 1969 1007:42

(TEST4
  (LAMBDA (CS L)
    (PROG NIL
      LP  (COND
            ((GETP CS (CAR L))
              (RETURN T))
            ((SETQ L (CDR L))
              (GO LP)))
          (RETURN NIL)
      )))

(ADVANCE
  (LAMBDA (RULES)
    (RPLACA (CDAR RULES)
      (COND
        ((NULL (CDADAR RULES))
          (CDDAR RULES))
        ((CDADAR RULES))))))

(RECONSTRUCT
  (LAMBDA (RULE PF)
    (PROG (SENT CR V1 V2 TPF QMF)
          (COND
            ((NULL PF)
              (SETQ SENT (CONS))))
      LP  (COND
            ((NULL RULE)
              (COND
                (PF (COND
                    ((NULL QMF)
                      (PRIN1 (QUOTE ?))))
                  (TERPRI)))
              (RETURN (CAR SENT)))
            ((NUMBERP (SETQ CR (CAR RULE)))
              (GO T1))
            (PF (COND
                ((MEMBER CR TRMLIS)
                  (PRIN1 CR)
                  (SETQ QMF T))
                (T (COND
                    (TPF (SPACES 1))
                    (T (TERPRI)
                      (SETQ TPF T)))
                  (PRIN1 CR))))
            (T (TCONC CR SENT)))
      T3  (SETQ RULE (CDR RULE))
          (GO LP)
      T1  (SETQ V1 (CAR (SETQ CR (NTH PARSELIST CR))))
          (SETQ V2 (CADR CR))
      T2  (COND

;;; eliza-page-19690731-docfnsp1-05of06

;;; /DOCFNS/ 31 JULY 1969  1007:42

            ((EQ V1 V2)
              (GO T3))
            (PF (COND
                (TPF (SPACES 1))
                (T (TERPRI)
                  (SETQ TPF T)))
              (PRIN1 (CAR V1)))
            (T (TCONC (CAR V1)
                SENT)))
          (SETQ V1 (CDR V1))
          (GO T2)
      )))
    
(MEMORY
  (LAMBDA NIL
    (PROG (PARSELIST X)
      LP  (COND
            ((NULL MEMSTACK)
              (RETURN)))
          (SETQ PARSELIST (CONS NIL NIL))
          (COND
            ((TEST (CAAR MEMSTACK)
                SENTENCE)
             (RPLACA (SETQ X (CDAADR (GETP (QUOTE NONE)
                     (QUOTE MEM))))
               (CONS (CAR X)
                 (CONS (RECONSTRUCT (CAAR (ADVANCE MEMSTACK)))
                   (CDAR X))))))
          (SETQ MEMSTACK (CDR MEMSTACK))
          (GO LP)
      )))

(BCONC
 (LAMBDA (WHAT LIST)
   (COND
     ((NULL LIST)
       (CONS (SETQ LIST (CONS NIL WHAT))
         LIST))
     ((NULL (CAR LIST))
       (RPLACA LIST (CDR (RPLACD LIST (CONS NIL WHAT)))))
     ((RPLACA LIST (CAR (RPLACA (CAR LIST)
             (RPLACA (CONS LIST WHAT)
               NIL))))))))

(RPLQQ
  (NLAMBDA RPLQ
    (RPLACD (CAR RPLQ)
      (CDR RPLQ))))

;;; Eliza-19690731-DOCFNSp1-06of06

;;; /DOCFNS/   31 JULY 1969  1007:42                     PAGE 1:6

(SETNONE
  (LAMBDA NIL
    (PROG (A)
          (SETQ A (GENSYM))
          (RPLACD A (GETP (QUOTE NONE)
              (QUOTE LASTRESORT)))
          (PUT (QUOTE NONE)
            (QUOTE MEM)
            (LIST (QUOTE RULES)
              (LIST (LIST (LIST 0)
                  (LIST NIL)
                  A))))
      )))
)

  (PRINT (QUOTE DOCFNS))
  (RPAQQ DOCFNS (DOCTOR MAKESENTENCE ANALYZE TEST TEST4
        ADVANCE RECONSTRUCT MEMORY BCONC RPLQQ SETNONE))
  (PRINT (QUOTE DOCVARS))
  (RPAQQ DOCVARS (TRMLIS PCTLIS RUBOUT STOP))
  (RPAQQ TRMLIS ("." ! ?))
  (RPAQQ PCTLIS ("," ; "(" ")" :))
  (RPAQQ RUBOUT \#)
STOP

;;; ===================================================================================
;;; |                                    1969 SCRIPT                                  |
;;; ===================================================================================

;;; Eliza-19690731-SCRIPTp1-00of21

;;; /SCRIPT/   31 JULY 1969  1008:27                            PAGE 1

(SETQQ WDLIST (SORRY DONT CANT WONT REMEMBER IF DREAMT DREAMED DREAM
DREAMS HOW WHEN ALIKE SAME CERTAINLY FEEL THINK BELIEVE WISH MY
NONE PERHAPS MAYBE NAME DEUTSCH FRANCAIS SVENSKA ITALIANO ESPANOL
HELLO COMPUTER MACHINE MACHINES COMPUTERS AM ARE YOUR WAS WERE ME
YOU'RE I'M MYSELF YOURSELF MOTHER MOM DAD FATHER SISTER BROTHER
WIFE CHILDREN I YOU XXYYZZ YES NO CAN IS WHERE WHAT XXWHAT BECAUSE
WHY EVERYONE EVERYBODY NOBODY NOONE ALWAYS LIKE DIT OH EVERY DO
GIRLS WOMEN BOY GIRL MAN WOMAN SEXY SEXUAL SEX FRIENDLY FRIEND CRY
LAUGH LOVE HATE DISLIKE))

(RPLQQ SORRY
PRIORITY
   2
RULES
   (((0)
         (NIL)
         (APOLOGIES ARE NOT NECESSARY ".")
         (WHAT FEELINGS DO YOU HAVE WHEN YOU APOLOGIZE))))

(RPLQQ DONT
TRANSLATION
   DON'T)

(RPLQQ CANT
TRANSLATION
   CAN'T)

(RPLQQ WONT
TRANSLATION
   WON'T)

(RPLQQ REMEMBER
PRIORITY
   5
RULES
   (((REMEMBER 0)
         (NIL)
         (PRE (DO I REMEMBER 2)
            REMEMBER))
      ((YOU REMEMBER 0)
         (NIL)
         (DO YOU OFTEN THINK OF 3)
         (WHAT ELSE DOES THINKING OF 3 BRING TO MIND)
         (WHAT ELSE DO YOU REMEMBER)
         (WHY DO YOU REMEMBER 3 JUST NOW)
         (WHAT IN THE PRESENT SITUATION REMINDS YOU OF 3)
         (WHAT IS THE CONNECTION BETWEEN ME AND 3))
      ((DO I REMEMBER 0)
         (NIL)
         (WHY DID YOU THINK I WOULD FORGET 4)
         (WHY DO YOU THINK I SHOULD RECALL 4 NOW)
         (WHAT ABOUT 4))))

;;; Eliza-19690731-SCRIPTp1-01of21

(RPLQQ IF
PRIORITY
   3
RULES
   (((0 IF 0)
         (NIL)
         (DO YOU THINK IT'S LIKELY THAT 3)
         (DO YOU WISH THAT 3)
         (WHAT DO YOU THINK ABOUT 3)
         (REALLY"," IF 3))))

(RPLQQ DREAMT
PRIORITY
   4
RULES
   (((0 YOU DREAMT 0)
         (NIL)
         (REALLY 4)
         (HAVE YOU EVER FANTASIED 4 WHILE YOU WERE AWAKE)
         (HAVE YOU DREAMT 4 BEFORE)
         DREAM
         NEWKEY)))

(RPLQQ DREAMED
TRANSLATION
   DREAMT
PRIORITY
   4
RULES
   (DREAMT))

(RPLQQ DREAM
PRIORITY
   3
RULES
   (((0 YOU DREAM (OF ABOUT) 0)
     (NIL)
     (WHAT MIGHT 5 REPRESENT)
     (WHAT DOES 5 SUGGEST TO YOU)
     (HOW DOES THAT DREAM RELATE TO YOUR PROBLEM))
   ((0)
         (NIL)
         (WHAT DO YOU DREAM ABOUT)
         (WHAT PERSONS APPEAR IN YOUR DREAMS)
         (WHAT MAY DREAMS HAVE TO DO WITH YOUR PROBLEM)
         NEWKEY)))

;;; Eliza-19690731-SCRIPTp1-02of21

;;; /SCRIPT/   31 JULY 1969  1008:27                     PAGE 1:2


(RPLQQ DREAMS
TRANSLATION
   DREAM
PRIORITY
   3
RULES
   (DREAM))

(RPLQQ HOW
RULES
   (WHAT)
PRIORITY
   0)

(RPLQQ WHEN
PRIORITY
   0
RULES
   (((WHEN (DO DID DOES WILL)
            0)
         (NIL)
         XXWHAT)
      ((0)
         (NIL)
         (IS THERE ANY OTHER TIME)
         (WHY THEN"," DO YOU SUPPOSE))))

(RPLQQ ALIKE
PRIORITY
   10
RULES
   (DIT))

(RPLQQ SAME
RULES
   (DIT)
PRIORITY
   3)

(RPLQQ CERTAINLY
PRIORITY
   0
RULES
   (YES))

(RPLQQ FEEL
BELIEF
   T)

;;; Eliza-19690731-SCRIPTp1-03of21

(RPLQQ THINK
BELIEF
   T)

(RPLQQ BELIEVE
BELIEF
   T)

(RPLQQ WISH
BELIEF
   T)

(RPLQQ MY
MEMR
   (((YOUR 2 0)
         (NIL)
         (LETS DISCUSS FURTHER WHY YOUR 2 3 ".")
         (EARLIER YOU SAID YOUR 2 3 ".")
         (BUT YOUR 2 3 ".")
         (DOES THAT HAVE ANYTHING TO DO WITH THE FACT THAT YOUR 2 3))
      ((0 YOUR 1)
         (NIL)
         (WOULD YOU LIKE TO DISCUSS YOUR 3)
         (PERHAPS THAT CONCERNS YOUR 3 ".")
         (TELL ME MORE ABOUT YOUR 3 ".")))
PRIORITY
   0
TRANSLATION
   YOUR
RULES
   (((0 YOUR 0 (NIL FAMILY)
            0)
         (NIL)
         (TELL ME MORE ABOUT YOUR FAMILY ".")
         (WHO ELSE IN YOUR FAMILY 5)
         (YOUR 4)
         (WHAT ELSE COMES TO MIND WHEN YOU THINK OF YOUR 4))
      ((YOUR 2 0)
         (NIL)
         (IS IT IMPORTANT TO YOU THAT YOUR 2 3)
         (DO YOU SUPPOSE ANYONE ELSE'S 2 3)
         (WHAT MAKES YOU THINK YOUR 2 3)
         (SUPPOSE I DIDN'T BELIEVE THAT YOUR 2 3 "."))
      ((0 YOUR 1)
         (NIL)
         (YOUR 3)
         (WHY DO YOU SAY THAT YOUR 3)
         (WHO ELSE KNOWS ABOUT YOUR 3)
         (WHY DO YOU MENTION YOUR 3 JUST NOW)
         (WHY IS YOUR 3 IMPORTANT TO YOU)
         (DO YOU OFTEN DISCUSS YOUR 3))))

;;; Eliza-19690731-SCRIPTp1-04of21

;;; /SCRIPT/   31 JULY 1969  1008:27                     PAGE 1:4

(RPLQQ NONE
LASTRESORT
   (RULES (((0)
            (NIL)
            (I AM NOT SURE I UNDERSTAND YOU FULLY ".")
            (PLEASE GO ON ".")
            (WHAT DOES THAT SUGGEST TO YOU)
            (WHAT ELSE WOULD YOU LIKE TO DISCUSS)
            (WHY DO YOU SAY THAT JUST NOW)))))

(RPLQQ PERHAPS
PRIORITY
   0
RULES
   (((0)
         (NIL)
         (YOU DON'T SEEM QUITE CERTAIN ".")
         (WHY THE UNCERTAIN TONE)
         (CAN'T YOU BE MORE POSITIVE)
         (YOU AREN'T SURE)
         (DON'T YOU KNOW))))

(RPLQQ MAYBE
PRIORITY
   0
RULES
   (PERHAPS))

(RPLQQ NAME
PRIORITY
   15
RULES
   (((0)
         (NIL)
         (I AM NOT INTERESTED IN NAMES ".")
         (I'VE TOLD YOU BEFORE I DON'T CARE ABOUT NAMES - PLEASE CONTINUE "."))))

(RPLQQ DEUTSCH
PRIORITY
   0
RULES
   (((0)
         (NIL)
         (I AM SORRY"," I SPEAK ONLY ENGLISH))))

;;; Eliza-19690731-SCRIPTp1-05of21

;;; /SCRIPT/   31 JULY 1968  1008:27

(RPLQQ FRANCAIS
PRIORITY
   0
RULES
   (DEUTSCH))

(RPLQQ SVENSKA
PRIORITY
   0
RULES
   (DEUTSCH))

(RPLQQ ITALIANO
PRIORITY
   0
RULES
   (DEUTSCH))

(RPLQQ ESPANOL
PRIORITY
   0
RULES
   (DEUTSCH))

(RPLQQ HELLO
PRIORITY
   0
RULES
   (((0)
         (NIL)
         (HOW DO YOU DO "."))))

(RPLQQ COMPUTER
PRIORITY
   0
RULES
   (((0)
         (NIL)
         (DO COMPUTERS WORRY YOU)
         (WHY DO YOU MENTION COMPUTERS)
         (WHAT DO YOU THINK MACHINES HAVE TO DO WITH YOUR PROBLEM)
         (DON'T YOU THINK COMPUTERS CAN HELP PEOPLE))))

;;; Eliza-19690731-SCRIPTp1-06of21

;;; /SCRIPT/  31 JULY 1969  1008:27

(RPLQQ MACHINE
PRIORITY
   0
RULES
   (COMPUTER))

(RPLQQ MACHINES
PRIORITY
   0
RULES
   (COMPUTER))

(RPLQQ COMPUTERS
PRIORITY
   0
RULES
   (COMPUTER))

(RPLQQ AM
PRIORITY
   0
TRANSLATION
   ARE
RULES
   (((ARE YOU 0)
         (NIL)
         (DO YOU BELIEVE YOU ARE 3)
         (WOULD YOU WANT TO BE 3)
         (YOU WISH I WOULD TELL YOU YOU ARE 3 ".")
         (WHAT WOULD IT MEAN IF YOU WERE 3)
         XXWHAT)
      ((0)
         (NIL)
         (WHY DO YOU SAY 'AM')
         (I DON'T UNDERSTAND THAT))))

(RPLQQ ARE
PRIORITY
   0

;;; Eliza-19690731-SCRIPTp1-07of21

;;; /SCRIPT/   31 JULY 1969  1008:27                     PAGE 1:7

RULES
   (((THERE (ARE IS)
            (NO NOT)
            0)
         (NIL)
         (WHAT IF THERE WERE 4)
         (DID YOU THINK THERE MIGHT BE 4)
         (PRE (THERE 2 4)
            ARE))
      ((THERE (ARE IS)
            0)
         (NIL)
         (2 THERE REALLY 3)
         (WHY 2 THERE 3)
         (HOW 3 THE 4 RELATED TO YOU))
      ((ARE I 0)
         (NIL)
         (WHY ARE YOU INTERESTED IN WHETHER I AM 3 OR NOT)
         (WOULD YOU PREFER IF I WEREN'T 3)
         (PERHAPS I AM 3 IN YOUR FANTASIES ".")
         (DO YOU SOMETIMES THINK I AM 3)
         XXWHAT)
      ((ARE 0)
         (NIL)
         XXWHAT)
      ((0 1 (ARE IS)
            NOT
            0)
         (NIL)
         (POSSIBLY THAT IS FOR THE BETTER ".")
         (WHAT IF 2 WERE 5)
         (WHAT DO YOU REALLY KNOW ABOUT 2))
      ((0 (ARE IS)
            0)
         (NIL)
         (SUPPOSE 1 WERE NOT 3 ".")
         (POSSIBLY 1 REALLY 2 NOT 3 ".")
         (TELL ME MORE ABOUT 1 ".")
         (DID YOU THINK 1 MIGHT NOT BE 3)
         (1 PERHAPS 2 3 "."))))

;;; Eliza-19690731-SCRIPTp1-08of21

(RPLQQ YOUR
PRIORITY
   0
TRANSLATION
   MY
RULES
   (((0 MY 1)
         (NIL)
         (WHY ARE YOU CONCERNED OVER MY 3)
         (WHAT ABOUT YOUR OWN 3)
         (ARE YOU WORRIED ABOUT SOMEONE ELSES 3)
         (REALLY"," MY 3))
      ((MY 0)
         (NIL)
         (PERHAPS YOUR OWN 2 ".")
         (ARE YOU WORRIED THAT MY 2))))

(RPLQQ WAS
PRIORITY
   2
RULES
   (((WAS YOU 0)
         (NIL)
         (WHAT IF YOU WERE 3)
         (DO YOU THINK YOU WERE 3)
         (WERE YOU 3)
         (WHAT WOULD IT MEAN IF YOU WERE 3)
         XXWHAT)
      ((YOU WAS 0)
         (NIL)
         (WERE YOU REALLY)
         (WHY DO YOU TELL ME YOU WERE 3 NOW)
         (PERHAPS I ALREADY KNEW YOU WERE 3 "."))
      ((WAS I 0)
         (NIL)
         (WOULD YOU LIKE TO BELIEVE I WAS 3)
         (WHAT SUGGESTS THAT I WAS 3)
         (WHAT DO YOU THINK)
         (PERHAPS I WAS 3 ".")
         (WHAT IF I HAD BEEN 3))))

(RPLQQ WERE
PRIORITY
   0
TRANSLATION
   WAS
RULES
   (WAS))


;;; Eliza-19690731-SCRIPTp1-09of21

;;; /SCRIPT/   31 JULY 1969  1008:27                                   PAGE 1:9

(RPLQQ ME
TRANSLATION
   YOU)

(RPLQQ YOU'RE
PRIORITY
   0
TRANSLATION
   I'M
RULES
   (((0 I'M 0)
         (NIL)
         (PRE (I ARE 3)
            YOU))))

(RPLQQ I'M
PRIORITY
   0
TRANSLATION
   YOU'RE
RULES
   (((0 YOU'RE 0)
         (NIL)
         (PRE (YOU ARE 3)
            I))))

(RPLQQ MYSELF
TRANSLATION
   YOURSELF)

(RPLQQ YOURSELF
TRANSLATION
   MYSELF)

(RPLQQ MOTHER
FAMILY
   T)

(RPLQQ MOM
TRANSLATION
   MOTHER
FAMILY
   T)

;;; Eliza-19690731-SCRIPTp1-10of21

;;; /SCRIPT/   31 JULY 1969  1008:27                         PAGE 1:10

(RPLQQ DAD
TRANSLATION
   FATHER
FAMILY
   T)

(RPLQQ FATHER
FAMILY
   T)

(RPLQQ SISTER
FAMILY
   T)

(RPLQQ BROTHER
FAMILY
   T)

(RPLQQ WIFE
FAMILY
   T)

(RPLQQ CHILDREN
FAMILY
   T)

(RPLQQ I
PRIORITY
   0
TRANSLATION
   YOU
RULES
   (((0 YOU (WANT NEED)
            0)
         (NIL)
         (WHAT WOULD IT MEAN TO YOU IF YOU GOT 4)
         (WHY DO YOU WANT 4)
         (WHAT WOULD GETTING 4 MEAN TO YOU))
      ((0 YOU ARE 0 (SAD UNHAPPY DEPRESSED SICK ILL)
            0)
         (NIL)
         (I AM SORRY TO HEAR YOU ARE 5 ".")
         (DO YOU THINK COMING HERE WILL HELP YOU NOT TO BE 5)
         (CAN YOU EXPLAIN WHAT MADE YOU 5))
      ((0 YOU ARE 0 (HAPPY ELATED GLAD BETTER)
            0)
         (NIL)
         (HOW HAVE I HELPED YOU TO BE 5)
         (HAS YOUR TREATMENT MADE YOU 5)
         (WHAT MAKES YOU 5 JUST NOW))

;;; Eliza-19690731-SCRIPTp1-11of21

      ((0 YOU (NIL BELIEF)
            YOU
            0)
         (NIL)
         (DO YOU REALLY THINK SO)
         (BUT YOU ARE NOT SURE YOU 5)
         (DO YOU REALLY DOUBT YOU 5))
      ((0 YOU 0 (NIL BELIEF)
            0
            I
            0)
         (NIL)
         (PRE (6 7)
            YOU))
      ((0 YOU ARE 0)
         (NIL)
         (IS IT BECAUSE YOU ARE 4 THAT YOU CAME TO ME)
         (HOW LONG HAVE YOU BEEN 4)
         (DO YOU BELIEVE IT NORMAL TO BE 4)
         (DO YOU ENJOY BEING 4))
      ((0 YOU (CAN'T CANNOT)
            0)
         (NIL)
         (HOW DO YOU KNOW YOU CAN'T 4)
         (HAVE YOU TRIED)
         (PERHAPS YOU COULD 4 NOW ".")
         (DO YOU REALLY WANT TO BE ABLE TO 4))
      ((0 YOU (DON'T WON'T)
            0)
         (NIL)
         (DON'T YOU REALLY 4)
         (WHY DON'T YOU 4)
         (DO YOU WISH YOU DID 4)
         (DOES THAT TROUBLE YOU))
      ((0 YOU FEEL 0)
         (NIL)
         (TELL ME MORE ABOUT SUCH FEELINGS ".")
         (DO YOU OFTEN FEEL 4)
         (DO YOU ENJOY FEELING 4)
         (OF WHAT DOES FEELING 4 REMIND YOU))
      ((YOU 0 I)
         (NIL)
         (PERHAPS IN YOUR FANTASY WE 2 EACH OTHER ".")
         (DO YOU WISH TO 2 ME)
         (YOU SEEM TO NEED TO 2 ME ".")
         (DO YOU 2 ANYONE ELSE))
      ((0 YOU (NIL EMOTION)
            0)
         (NIL)
         (WHAT ELSE DO YOU 3)


;;; Eliza-19690731-SCRIPTp1-12of21

;;; /SCRIPT/   31 JULY 1969  1008:27                     PAGE 1:12

         (TELL ME MORE ABOUT 4 ".")
         (WHY DO YOU 3 4)
         (I DOUBT THAT YOU REALLY 3 4 "."))
      ((0 YOU 1 0) ;; ??? xscriber notes that the final 0 looks like an O in the printout ???
         (NIL)
         (YOU SAY 2 3 4)
         (CAN YOU ELABORATE ON THAT)
         (DO YOU SAY 2 3 4 FOR SOME SPECIAL REASON)
         (TELL ME MORE ABOUT YOURSELF)
         (OH? 2 3 4)
         (THAT'S QUITE INTERESTING ".")))
MEMR
   (((0 YOU ARE 0)
         (NIL)
         (ARE YOU STILL 4)
         (EARLIER YOU SAID YOU WERE 4 ".")
         (MAYBE NOW WE CAN DISCUSS WHY YOU ARE 4 ".")
         (DID YOU TELL ME YOU WERE 4))))

(RPLQQ YOU
PRIORITY
   0
TRANSLATION
   I
RULES
   (((0 I REMIND YOU OF 0)
         (NIL)
         DIT)
      ((0 I ARE 0)
         (NIL)
         (WHAT MAKES YOU THINK I AM 4)
         (DOES IT PLEASE YOU TO BELIEVE I AM 4)
         (PERHAPS YOU WOULD LIKE TO BE 4 ".")
         (DO YOU SOMETIMES WISH YOU WERE 4))
      ((0 I 0 YOU)
         (NIL)
         (WHY DO YOU THINK I 3 YOU)
         (YOU LIKE TO THINK I 3 YOU - DON'T YOU)
         (WHAT MAKES YOU THINK I 3 YOU)
         (REALLY? I 3 YOU)
         (DO YOU WISH TO BELIEVE I 3 YOU)
         (SUPPOSE I DID 3 YOU - WHAT WOULD THAT MEAN)
         (DOES SOMEONE ELSE BELIEVE I 3 YOU))
      ((0 I 1 0)
         (NIL)
         (SUPPOSE YOU 3 4 ".")
         (OH? I 3 4)
         (WHAT MAKES YOU THINK I 3 4)
         (WHO ARE YOU REALLY TALKING ABOUT))))

;;; Eliza-19690731-SCRIPTp1-13of21

;;; /SCRIPT/   31 JULY 1969  1008:27                             PAGE 1:13

(RPLQQ XXYYZZ
RULES
   (((0)
         (NIL)
         (IS THERE SOMETHING BOTHERING YOU)
         (CAN YOU BE MORE INFORMATIVE)
         (PERHAPS YOU'D RATHER TALK ABOUT SOMETHING ELSE ".")
         (PLEASE TELL ME MORE "."))))

(RPLQQ YES
PRIORITY
   -1
RULES
   (((0)
         (NIL)
         XXYYZZ
         (WHY ARE YOU SO SURE)
         (I SEE ".")
         (I UNDERSTAND "."))))

(RPLQQ NO
PRIORITY
   -1
RULES
   (((0 NO (BODY ONE)
            0)
         (NIL)
         NOBODY)
      ((0)
         (NIL)
         XXYYZZ
         (VERY WELL ".")
         (WHY NOT)
         (WHY 'NO'))))

(RPLQQ CAN
PRIORITY
   0
RULES
   (((CAN I 0)
         (NIL)
         (YOU BELIEVE I CAN 3 DON'T YOU)
         XXWHAT
         (YOU WANT ME TO BE ABLE TO 3 ".")
         (PERHAPS YOU WOULD LIKE TO BE ABLE TO 3 YOURSELF "."))
      ((CAN YOU 0)
         (NIL)
         (WHETHER OR NOT YOU CAN 3 DEPENDS ON YOU MORE THAN ON ME ".")
         (DO YOU WANT TO BE ABLE TO 3)
         (PERHAPS YOU DON'T WANT TO 3 ".")
         XXWHAT)))


;;; Eliza-19690731-SCRIPTp1-14of21

;;; /SCRIPT/   31 JULY 1969  1008:27                     PAGE 1:14

(RPLQQ IS
PRIORITY
   0
RULES
   (((IS 0)
         (NIL)
         XXWHAT)
      ARE))

(RPLQQ WHERE
PRIORITY
   0
RULES
   (WHAT))

(RPLQQ WHAT
PRIORITY
   0
RULES
   ((((HOW WHERE WHAT WHY)
            0)
         (NIL)
         XXWHAT)))

(RPLQQ XXWHAT
RULES
   (((0)
         (NIL)
         (WHY DO YOU ASK)
         (WHY DOES THAT QUESTION INTEREST YOU)
         (WHY ARE SUCH QUESTIONS ON YOUR MIND)
         (WHAT ANSWER WOULD PLEASE YOU MOST)
         (WHAT DO YOU THINK)
         (WHEN HAVE YOU ASKED SUCH QUESTIONS BEFORE)
         (WHO ELSE HAVE YOU ASKED))))

(RPLQQ BECAUSE
PRIORITY
   0
RULES
   (((0)
         (NIL)
         (IS THAT THE REAL REASON)
         (I SEE ".")
         (DON'T ANY OTHER REASONS COME TO MIND)
         (DOES THAT REASON SEEM TO EXPLAIN ANYTHING ELSE)
         (AND WHAT DOES THAT SUGGEST)
         (WHAT OTHER REASONS MIGHT THERE BE))))

;;; Eliza-19690731-SCRIPTp1-15of21

;;; /SCRIPT/   31 JULY 1969  1008:27                     PAGE 1:15

(RPLQQ WHY
PRIORITY
   0
RULES
   (((0 WHY (DON'T WON'T)
            I
            0)
         (NIL)
         (DO YOU BELIEVE I DON'T 5)
         (PERHAPS I WILL 5 IN GOOD TIME ".")
         (SHOULD YOU 5 YOURSELF)
         (YOU WANT ME TO 5 ".")
         WHAT)
      ((0 WHY CAN'T YOU 0)
         (NIL)
         (DO YOU THINK YOU SHOULD BE ABLE TO 5)
         (DO YOU WANT TO BE ABLE TO 5)
         (DO YOU BELIEVE THIS WILL HELP YOU TO 5)
         (HAVE YOU ANY IDEA WHY YOU CAN'T 5)
         WHAT)
      WHAT))

(RPLQQ EVERYONE
PRIORITY
   2
RULES
   (((0)
         (NIL)
         (CAN YOU THINK OF ANYONE IN PARTICULAR)
         (WHO"," FOR EXAMPLE)
         (YOU ARE THINKING OF A VERY SPECIAL PERSON ".")
         (YOU HAVE A PARTICULAR PERSON IN MIND"," DON'T YOU))))

(RPLQQ EVERYBODY
PRIORITY
   2
RULES
   (EVERYONE))

(RPLQQ NOBODY
PRIORITY
   2
RULES
   (((0)
         (NIL)
         (SURELY SOMEONE"...")
         (PERHAPS YOU JUST DON'T KNOW OF ANYONE "."))))

;;; Eliza-19690731-SCRIPTp1-16of21

;;; /SCRIPT/   32 JULY 1969 1008:27

(RPLQQ NOONE
PRIORITY
   2
RULES
   (NOBODY))

(RPLQQ ALWAYS
PRIORITY
   1
RULES
   (((0)
         (NIL)
         (CAN YOU THINK OF A SPECIFIC EXAMPLE)
         (WHEN)
         (WHAT INCIDENT ARE YOU THINKING OF)
         (REALLY"," ALWAYS))))

(RPLQQ LIKE
RULES
   (((0 (AM IS ARE WAS)
            0
            LIKE
            0)
         (NIL)
         DIT))
EMOTION
   T
PRIORITY
   3)

(RPLQQ DIT
RULES
   (((0)
         (NIL)
         (IN WHAT WAY)
         (WHAT RESEMBLANCE DO YOU SEE)
         (WHAT DOES THAT SIMILARITY SUGGEST TO YOU)
         (WHAT OTHER CONNECTIONS DO YOU SEE)
         (WHAT IS THE CONNECTION"," DO YOU SUPPOSE)
         (HOW))))

;;; Eliza-19690731-SCRIPTp1-17of21

;;; /SCRIPT/   31 JULY 1969  1008:27                                     PAGE 1:17

(RPLQQ OH
PRIORITY
   10
RULES
   (((0 YOUR OH YOUR 0)
         (NIL)
         (PRE (1 MY-OH-MY 5)
            NEWKEY))
      ((0 OH YOUR 0)
         (NIL)
         (PRE (1 OH-MY 4)
            NEWKEY))))

(RPLQQ EVERY
PRIORITY
   0
RULES
   (((0 EVERY (ONE BODY)
            0)
         (NIL)
         EVERYONE)
      ((0 EVERY TIME 0)
         (NIL)
         ALWAYS)))

(RPLQQ DO
PRIORITY
   0
RULES
   (((DO I 0)
         (NIL)
         (PRE (I 3)
            YOU)
         XXWHAT)
      ((DO YOU 0)
         (NIL)
         (PRE (YOU 3)
            I)
         XXWHAT)))

;;; Eliza-19690731-SCRIPTp1-18of21

;;; /SCRIPT/   31 JULY 1969 1008:27                             PAGE 1:18

(RPLQQ GIRLS
PRIORITY
   3
RULES
   (((0 (GIRLS WOMEN)
            0)
         (NIL)
         (PRE (1 2 S 3)
            BOY))))

(RPLQQ WOMEN
PRIORITY
   3
RULES
   (GIRLS))

(RPLQQ BOY
PRIORITY
   3
PERSON
   T
RULES
   (((0 (NIL PERSON)
            FRIEND
            0)
         (NIL)
         (I WOULD LIKE TO MEET YOUR 2 FRIEND ".")
         (PRE (1 FRIEND 4)
            FRIEND)
         (SUPPOSE THE FRIEND WERE NOT A 2 "."))
      ((0 (NIL PERSON)
            0)
         (NIL)
         (WHY DO YOU SAY A 2)
         (WHAT 2 ARE YOU THINKING OF)
         NEWKEY)
      ((0 (NIL PERSON)
            S
            0)
         (NIL)
         (WHAT GROUP OF 2 ARE YOU THINKING OF)
         (I EXPECTED THAT YOU WOULD WANT TO TALK ABOUT 2 ".")
         (DO YOU KNOW MANY 2))))


;;; Eliza-19690731-SCRIPTp1-19of21

;;; /SCRIPT/   31 JULY 1969  1008:27                             PAGE 1:19

(RPLQQ GIRL
PRIORITY
   3
PERSON
   T
RULES
   (BOY))

(RPLQQ MAN
PRIORITY
   3
PERSON
   T
RULES
   (BOY))

(RPLQQ WOMAN
PRIORITY
   3
PERSON
   T
RULES
   (BOY))

(RPLQQ SEXY
PRIORITY
   5
RULES
   (SEX))

(RPLQQ SEXUAL
PRIORITY
   5
RULES
   (SEX))

(RPLQQ SEX
PRIORITY
   5

;;; Eliza-19690731-SCRIPTp1-20of21

;;; /SCRIPT/   31 JULY 1969  1008:27                     PAGE 1:20

RULES
   (((0 YOU 0 SEX 0)
         (NIL)
         (ARE YOU SURE YOU REALLY 3 IT 5)
         (DO YOU REALLY WANT TO DISCUSS SEX)
         (PERHAPS YOU ARE WORRIED THAT YOU 3 IT 5)
         NEWKEY)
      ((0)
         (NIL)
         (WHAT ARE YOUR REAL FEELINGS ABOUT SEX)
         (DO YOU EVER DREAM ABOUT SEX)
         (WHY DO YOU MENTION SEX)
         (COULD SEX BE PART OF YOUR PROBLEM)
         NEWKEY))
MEMR
   (((0 YOU 0 SEX 0)
         (NIL)
         (EARLIER YOU SAID YOU 3 4 5 ".")
         (TELL ME AGAIN WHY YOU 3 4 5 ".")
         (DO YOU SAY THAT BECAUSE YOU 3 4 5))))

(RPLQQ FRIENDLY
PRIORITY
   0
RULES
   (FRIEND))

(RPLQQ FRIEND
PRIORITY
   1
RULES
   (((0 YOUR FRIEND 0)
         (NIL)
         (WHAT ELSE CAN YOU TELL ME ABOUT YOUR FRIEND)
         (WHAT MIGHT YOUR FRIENDS HAVE TO DO WITH YOUR PROBLEM))
      ((0)
         (NIL)
         (DO YOU THINK FRIENDS ARE IMPORTANT)
         (WHAT DO YOU THINK ABOUT YOUR FRIENDS))))

(RPLQQ CRY
PRIORITY
   2
RULES
   (LAUGH))

;;; Eliza-19690731-SCRIPTp1-21of21.lisp

;;; /SCRIPT/   31 JULY 1969  1008:27

(RPLQQ LAUGH
PRIORITY
   2
RULES
   (((0 (LAUGH CRY)
            0)
         (NIL)
         (WHAT WOULD MAKE YOU 2)
         (REALLY 2)
         (WOULD YOU LIKE TO LAUGH)
         NEWKEY)))

(RPLQQ LOVE
EMOTION
   T)

(RPLQQ HATE
EMOTION
   T)

(RPLQQ DISLIKE
EMOTION
   NIL)
STOP
