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
  (RPAQQ RUBOUT #)
STOP
