      * SYNTHETIC DEMO ONLY - bank-owned outbound adapter.
      * No actual account DB access or billing calculation.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. AAEXTR.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT VENDOR-OUT ASSIGN TO AAOUTDD
             ORGANIZATION IS SEQUENTIAL
             FILE STATUS IS WS-STATUS.
       DATA DIVISION.
       FILE SECTION.
       FD VENDOR-OUT.
           COPY AAOUT.
       WORKING-STORAGE SECTION.
       01 WS-STATUS                  PIC XX.
       PROCEDURE DIVISION.
           OPEN OUTPUT VENDOR-OUT
           IF WS-STATUS NOT = '00'
               MOVE 12 TO RETURN-CODE
               GOBACK
           END-IF
      * One illustrative record; not a production extract.
           MOVE '00001234' TO AA-OUT-ACCOUNT-ID
           MOVE '202610'   TO AA-OUT-PERIOD
           MOVE 'TRNF'     TO AA-OUT-SERVICE-CODE
           MOVE 12         TO AA-OUT-ACTIVITY-COUNT
           WRITE AA-OUT-RECORD
           IF WS-STATUS NOT = '00'
               MOVE 12 TO RETURN-CODE
           END-IF
           CLOSE VENDOR-OUT
           GOBACK.
