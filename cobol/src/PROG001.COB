       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROG001.
      *> AUTHOR. OTTONI, RONALDO.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT                IS COMMA
           CRT STATUS                   IS WS-FUNCAO.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       COPY "COPY\DGNCUS.SEL".

       DATA DIVISION.
       FILE SECTION.
       COPY "COPY\DGNCUS.FD".

       WORKING-STORAGE SECTION.

       77  WS-OPCAO        PIC 9.
       77  WS-FIM          PIC X VALUE 'N'.
       
       *>   DEFAULT VARIABLES TO BE USED ALL PROGRAMS 
       COPY "COPY\PGMWORK.WS".

       01  WS-PROG001-WORK-VARS.
           05 WS-NEXT-ID           PIC  9(009)     VALUE ZEROS.
           05 WS-RETORNO           PIC  X(500)     VALUE SPACES.

       01  WV-SCREEN.
           05  WV-DATA-01.
               10  WV-ID               PIC  9(009).

           05  WV-DATA-02.
               10  WV-NAME             PIC  X(060).
               10  WV-DOCUMENT         PIC  X(025).
               10  WV-EMAIL            PIC  X(150).
               10  WV-PHONE            PIC  9(009).

       01  WW-JSON-RETURN.
           05  ID-FIELD                PIC  ZZZZZZZZ9.
           05  NAME-FIELD              PIC  X(060).
           05  DOCUMENT-FIELD          PIC  X(025).
           05  EMAIL-FIELD             PIC  X(150).
           05  PHONE-FIELD             PIC  9(009).

      *---- WEB -------------------------------------------------------*
       COPY "COPY\PGMLINK.WEB".
         02  WW-WEB-SCREEN.
           05  WW-DATA-01.
               10  WW-ID               PIC  9(009).
               10  FILLER REDEFINES WW-ID.
                15 WE-ID               PIC  ZZZZZZZZ9.
               10  FILLER REDEFINES WW-ID.
                15 WX-ID               PIC  X(009).
           05  WW-DATA-02.
               10  WW-NAME             PIC  X(060).
               10  WW-DOCUMENT         PIC  X(025).
               10  WW-EMAIL            PIC  X(150).
               10  WW-PHONE            PIC  9(009).

           
           
      *> LINKAGE SECTION COPY
       COPY "COPY\PGMLINK.LK".

       SCREEN SECTION.
       01  SC-SCREEN-01.
           02  LINE 05  COL 03 "ID........: ".
           02  LINE 06  COL 01 
           "..........................................................".
       01  SC-DATA-01.
           02  SC-ID   LINE 05 COL 15 PIC  9(009) USING
               WV-ID.
*
       01  SC-SCREEN-02.
           02  LINE 07  COL 03 "NAME......: ".
           02  LINE 08  COL 03 "DOCUMENT..: ".
           02  LINE 09  COL 03 "EMAIL.....: ".
           02  LINE 10  COL 03 "PHONE.....: ".
       01  SC-DATA-02.
           02  SC-NAME LINE 07  COL 15  PIC  X(060) USING
               WV-NAME.
           02  SC-DOCUMENT LINE 08  COL 15  PIC  X(025) USING
               WV-DOCUMENT.
           02  SC-EMAIL LINE 09 COL 15 PIC X(050) USING
               WV-EMAIL.
           02  SC-PHONE LINE 10 COL 15 PIC 9(009) USING
               WV-PHONE.

       PROCEDURE DIVISION USING LK-PARAMETERS.
       DECLARATIVES.

       COPY "COPY\DGNCUS.DEC".

       END DECLARATIVES.

       000-PROGRAM SECTION.

       MAIN-PROCESS.
           IF LK-FLAG-WEB = "S"
              GO WEB-000-PARAMETERS
           END-IF.
           
       010-INITIALIZE-VARS.
           INITIALIZE WS-PROG001-WORK-VARS
                      WV-DATA-01
                      WV-DATA-02
           .

       020-MOUNT-SCREEN.
           IF LK-FLAG-WEB = "S"
              EXIT PARAGRAPH.

       021-DISPLAY-SCREEN-01.
           IF LK-FLAG-WEB = "S"
               EXIT PARAGRAPH.

           DISPLAY SC-SCREEN-01.
       
       021-DISPLAY-DATA-01.
           IF LK-FLAG-WEB = "S"
               EXIT PARAGRAPH.

           DISPLAY SC-DATA-01.

       022-DISPLAY-SCREEN-02.
           IF LK-FLAG-WEB = "S"
               EXIT PARAGRAPH.

           DISPLAY SC-SCREEN-02.

       022-DISPLAY-DATA-02.
           IF LK-FLAG-WEB = "S"
               EXIT PARAGRAPH.

           DISPLAY SC-DATA-02.

       011-MOUNT-DATE-TIME.
           MOVE FUNCTION CURRENT-DATE   TO WS-DATA-HORA-SYS.

       040-OPEN-FILES.
           MOVE "DGNCUS" TO WS-DGNCUS
           
           OPEN I-O DGNCUS
           .

       090-EXIT.
           EXIT.

       100-DATA-ENTRY.
           IF LK-FLAG-WEB = "S" AND 
              WK-FUNCTION NOT = "START"
              EXIT PARAGRAPH.
           
           INITIALIZE WV-DATA-01
                      WV-DATA-02

           PERFORM 021-DISPLAY-DATA-01
           PERFORM 022-DISPLAY-DATA-02.

       110-ID.
           IF LK-FLAG-WEB = "S"
              EXIT PARAGRAPH.

           INITIALIZE WV-DATA-02
           PERFORM 022-DISPLAY-DATA-02

           ACCEPT SC-ID
           MOVE FUNCTION NUMVAL(SC-ID) TO WV-ID 

           IF WS-PF1
              PERFORM 900-CLOSE-FILES
                 THRU 990-END-PROGRAM.

       111-TEST-ID.
           PERFORM 700-NEXT-ID
              THRU 709-NEXT-ID-END

           IF WV-ID = ZEROS OR
              WV-ID > WS-NEXT-ID
              MOVE WS-NEXT-ID          TO WV-ID
              IF LK-FLAG-WEB NOT = "S"
                 PERFORM 021-DISPLAY-DATA-01.

       190-READ-DGNCUS.
           INITIALIZE DGNCUS-REG
           MOVE WV-ID                  TO DGNCUS-ID
           MOVE "00"                   TO DGNCUS-RT
           MOVE "S"                    TO WS-EXIST
           READ DGNCUS INVALID KEY
                MOVE "N"               TO WS-EXIST
                INITIALIZE DGNCUS-BODY.

           MOVE DGNCUS-NAME            TO WV-NAME
           MOVE DGNCUS-DOCUMENT        TO WV-DOCUMENT
           MOVE DGNCUS-EMAIL           TO WV-EMAIL
           MOVE DGNCUS-PHONE           TO WV-PHONE
           .

       200-BODY-DATA-ENTRY.
           PERFORM 022-DISPLAY-DATA-02.

       210-NAME.
           IF LK-FLAG-WEB = "S"
               EXIT PARAGRAPH.

           ACCEPT SC-NAME.

           IF WS-PF1
              GO 110-ID.

           IF WS-PF3
              PERFORM 400-DELETE-RECORD
              GO 100-DATA-ENTRY.

       211-TEST-NAME.
           IF WV-NAME = SPACES
              IF LK-FLAG-WEB NOT = "S"
                 DISPLAY "NAME IT'S MANDATORY - ERROR"
              END-IF
              GO 210-NAME.

           MOVE FUNCTION UPPER-CASE(WV-NAME)
                                       TO WV-NAME.

           IF LK-FLAG-WEB NOT = "S"
              DISPLAY SC-NAME.
 
       210-DOCUMENT.
           IF LK-FLAG-WEB = "S"
               EXIT PARAGRAPH.
           
           ACCEPT SC-DOCUMENT.

           IF WS-PF1
              GO 210-NAME.

       211-TEST-DOCUMENT.
           IF WV-DOCUMENT = SPACES
              EXIT PARAGRAPH.

       210-EMAIL.
           IF LK-FLAG-WEB = "S"
               EXIT PARAGRAPH.

           ACCEPT SC-EMAIL.

           IF WS-PF1
              GO 210-DOCUMENT.

       211-TEST-EMAIL.
           IF WV-EMAIL = SPACES
               EXIT PARAGRAPH.

           MOVE FUNCTION LOWER-CASE(WV-EMAIL)
                                       TO WV-EMAIL.

           IF LK-FLAG-WEB NOT = "S"
               DISPLAY SC-EMAIL.

       210-PHONE.
           IF LK-FLAG-WEB = "S"
               EXIT PARAGRAPH.

           ACCEPT SC-PHONE.

           IF WS-PF1
              GO 210-EMAIL.

       211-TEST-PHONE.
           IF WV-PHONE = ZEROS
              EXIT PARAGRAPH.

       290-CONFIRM.
           IF LK-FLAG-WEB = "S"
               EXIT PARAGRAPH.

           MOVE "N"                    TO WS-CONFIRM
           DISPLAY "CONFIRM DATA RECORDING? " LINE 12 COL 01
           ACCEPT WS-CONFIRM AT LINE 12 COL 25.

           MOVE FUNCTION UPPER-CASE(WS-CONFIRM)
                                       TO WS-CONFIRM
           DISPLAY WS-BLANK-LINE LINE 12 COL 01
           IF WS-CONFIRM NOT = "S"
              INITIALIZE WV-DATA-01
                         WV-DATA-02
              PERFORM 021-DISPLAY-DATA-01
              PERFORM 022-DISPLAY-DATA-02
              GO 100-DATA-ENTRY.

       290-EXIT.
           EXIT.
      
      *----------------------------------------------------------------*
       300-RECORD-SAVE.
           INITIALIZE DGNCUS-REG
           MOVE WV-ID                  TO DGNCUS-ID
           MOVE "00"                   TO DGNCUS-RT
           READ DGNCUS INVALID KEY
               INITIALIZE DGNCUS-BODY.

           MOVE WV-NAME                TO DGNCUS-NAME
           MOVE WV-DOCUMENT            TO DGNCUS-DOCUMENT
           MOVE WV-EMAIL               TO DGNCUS-EMAIL
           MOVE WV-PHONE               TO DGNCUS-PHONE

           WRITE DGNCUS-REG INVALID KEY
                 REWRITE DGNCUS-REG.

       390-EXIT.
           IF LK-FLAG-WEB = "S"
               EXIT PARAGRAPH.

           GO 100-DATA-ENTRY.
           
      *----------------------------------------------------------------* 
       400-DELETE-RECORD.
           PERFORM 190-READ-DGNCUS
           DELETE DGNCUS INVALID KEY
                  DISPLAY WS-BLANK-LINE AT LINE 15 COL 01
                  DISPLAY "DELETE RECORD - ERROR " AT LINE 15 COL 01
                  EXIT PARAGRAPH.

      *----------------------------------------------------------------* 
       700-NEXT-ID.
           MOVE ZEROS                  TO WS-NEXT-ID
           INITIALIZE DGNCUS-REG
           MOVE HIGH-VALUES            TO DGNCUS-ID
           MOVE "00"                   TO DGNCUS-RT
           START DGNCUS KEY NOT > DGNCUS-KEY INVALID KEY
                   GO 709-NEXT-ID-END.

       702-READ-DGNCUS.
           READ DGNCUS PREVIOUS WITH IGNORE LOCK AT END
                GO 709-NEXT-ID-END.

           IF DGNCUS-RT NOT = "00"
              GO 702-READ-DGNCUS.

           MOVE DGNCUS-ID              TO WS-NEXT-ID.

       709-NEXT-ID-END.
           ADD 1                       TO WS-NEXT-ID
           EXIT.

      *----------------------------------------------------------------* 
       900-CLOSE-FILES.
           CLOSE DGNCUS
           .

       990-END-PROGRAM.
           EXIT PROGRAM.

       000-WEB SECTION.

       WEB-000-PARAMETERS.
           ACCEPT WK-PARAMETERS-WEB FROM ENVIRONMENT "PARAMETERS"
           
           MOVE WK-PARAMETERS          TO LK-PARAMETERS.

       WEB-010-BEGIN.
           PERFORM 010-INITIALIZE-VARS
              THRU 090-EXIT.

       WEB-020-SET-VARIABLES.
           MOVE WW-DATA-01             TO WV-DATA-01.
           MOVE WW-DATA-02             TO WV-DATA-02.

           MOVE FUNCTION NUMVAL(WW-ID) TO WV-ID.

       WEB-030-CALL-FUNCTIONS.
           IF WK-FUNCTION = "TESTAR-CODIGO"
              PERFORM 111-TEST-ID
           END-IF

           IF WK-FUNCTION = "RECORD-ACCESS"
              PERFORM 100-DATA-ENTRY
                 THRU 190-READ-DGNCUS
              IF WK-FLAG-FUNCTION = "N"
                 GO WEB-090-END
              END-IF
           END-IF.

           IF WK-FUNCTION = "RECORD-SAVE"
              PERFORM 200-BODY-DATA-ENTRY
                 THRU 290-EXIT
              IF WK-FLAG-FUNCTION = "N"
                 GO WEB-090-END
              END-IF
              PERFORM 300-RECORD-SAVE
                 THRU 390-EXIT
              IF WK-FLAG-FUNCTION = "N"
                 GO WEB-090-END
              END-IF
           END-IF.

       WEB-040-SEND-VARIABLES.
           MOVE WV-DATA-01             TO WW-DATA-01
           MOVE WV-DATA-02             TO WW-DATA-02

           MOVE WW-ID                  TO WE-ID
           MOVE SPACES                 TO WS-JSON-RETURN
           
      *     STRING '{'
      *            '"id":' WE-ID ','
      *            DELIMITED BY SIZE
      *            '"name":"' WW-NAME '",'
      *            DELIMITED BY "  "
      *            '"document":"' WW-DOCUMENT '",'
      *            DELIMITED BY "  "
      *            '"email":"' WW-EMAIL '",'
      *            DELIMITED BY "  "
      *            '"phone":"' WW-PHONE '"'
      *            DELIMITED BY "  "
      *            '}'
      *            DELIMITED BY SIZE
      *            INTO WS-JSON-RETURN
      *     INSPECT WS-JSON-RETURN REPLACING ALL X'00' BY SPACE.
      *     DISPLAY WS-JSON-RETURN UPON CONSOLE.

           CALL "cJSON_CreateObject" RETURNING WS-JSON-OBJECT.

           CALL "cJSON_AddStringToObject" USING
                                       BY VALUE WS-JSON-OBJECT
                                       BY REFERENCE "id"
                                       BY REFERENCE WE-ID

           CALL "cJSON_AddStringToObject" USING
                                       BY VALUE WS-JSON-OBJECT
                                       BY REFERENCE "name"
                                       BY REFERENCE WW-NAME

           CALL "cJSON_AddStringToObject" USING
                                       BY VALUE WS-JSON-OBJECT
                                       BY REFERENCE "document"
                                       BY REFERENCE WW-DOCUMENT

           CALL "cJSON_AddStringToObject" USING
                                       BY VALUE WS-JSON-OBJECT
                                       BY REFERENCE "email"
                                       BY REFERENCE WW-EMAIL

           CALL "cJSON_AddStringToObject" USING
                                       BY VALUE WS-JSON-OBJECT
                                       BY REFERENCE "phone"
                                       BY REFERENCE WW-PHONE
           
           CALL "cJSON_Print" USING WS-JSON-OBJECT
                              RETURNING WS-JSON-STRING

           DISPLAY WS-JSON-STRING.

       WEB-090-END.
           PERFORM 900-CLOSE-FILES
              THRU 990-END-PROGRAM

           STOP RUN.

       END PROGRAM PROG001.
