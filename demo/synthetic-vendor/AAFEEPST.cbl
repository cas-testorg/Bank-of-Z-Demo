      * SYNTHETIC DEMO ONLY - bank-owned inbound adapter.
      * Reads vendor charges; does NOT post to DB2 or GL.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. AAFEEPST.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT VENDOR-IN ASSIGN TO AAIN DD
             ORGANIZATION IS SEQUENTIAL
             FILE STATUS IS WS-STATUS.
       DATA DIVISION.
       FILE SECTION.
       FD VENDOR-IN.
           COPY AAIN.
       WORKING-STORAGE SECTION.
       01 WS-STATUS                  PIC XX.
       01 WS-DONE                    PIC X VALUE 'N'.
       01 WS-ACCEPTED                PIC 9(7) VALUE ZERO.
       01 WS-REJECTED                PIC 9(7) VALUE ZERO.
       PROCEDURE DIVISION.
           OPEN INPUT VENDOR-IN
           IF WS-STATUS NOT = '00'
               MOVE 12 TO RETURN-CODE
               GOBACK
           END-IF
           PERFORM UNTIL WS-DONE = 'Y'
               READ VENDOR-IN
                   AT END MOVE 'Y' TO WS-DONE
                   NOT AT END
                       IF AA-IN-STATUS = 'A'
                           ADD 1 TO WS-ACCEPTED
                       ELSE
                           ADD 1 TO WS-REJECTED
                       END-IF
               END-READ
           END-PERFORM
           CLOSE VENDOR-IN
           DISPLAY 'ACCEPTED=' WS-ACCEPTED
           DISPLAY 'REJECTED=' WS-REJECTED
           GOBACK.
