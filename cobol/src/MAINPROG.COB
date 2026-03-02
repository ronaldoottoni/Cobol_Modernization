       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAINPROG.
      *> AUTHOR. OTTONI, RONALDO.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       77  WS-OPTION        PIC 9.
       77  WS-END          PIC X VALUE 'N'.

      *>   DEFAULT VARIABLES TO BE USED ALL PROGRAMS 
       COPY "copy\PGMWORK.WS".
       
       01  WS-MAINPROG-WORK-VARS.
           05 WS-TITLE    PIC X(40)
              VALUE "=== COBOL SYSTEM - MAIN MENU ===".
           05 WS-LINE     PIC X(40)
              VALUE "----------------------------------------".

      *>   VARIABLES TO PREPAR THE LINKAGE'S CALL
       COPY "copy\PGMLINK.WS".

       PROCEDURE DIVISION.
       MAIN-PROCESS.
           MOVE "N"                    TO LK-FLAG-WEB
           PERFORM UNTIL WS-END = 'S'
               PERFORM SHOW-MENU
               PERFORM READ-OPTION
               PERFORM EXECUTE-OPTION
           END-PERFORM

           STOP RUN
           .

       SHOW-MENU.
           DISPLAY SPACES 
           DISPLAY WS-TITLE
           DISPLAY WS-LINE
           DISPLAY "1 - Customer Registration"
           DISPLAY "9 - Exit"
           DISPLAY WS-LINE
           DISPLAY "Choose an Option: "
           .

       READ-OPTION.
           ACCEPT WS-OPTION
           .

       EXECUTE-OPTION.
           EVALUATE WS-OPTION
               WHEN 1
                   CALL "PROG001" USING LK-PARAMETERS
               WHEN 9
                   MOVE 'S' TO WS-END
               WHEN OTHER
                   DISPLAY "Invalid Option!"
           END-EVALUATE
           .

       END PROGRAM MAINPROG.
