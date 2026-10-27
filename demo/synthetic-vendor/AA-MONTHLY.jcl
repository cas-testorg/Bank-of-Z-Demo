//* SYNTHETIC DEMO - NOT PRODUCTION JCL
//* STEP 1: Bank-owned extract produces AA.OUT
//AADEMO   JOB (DEMO),'AA VENDOR',CLASS=A,MSGCLASS=X
//EXTRACT  EXEC PGM=AAEXTR
//AAOUTDD  DD DSN=&&AAOUT,DISP=(NEW,PASS),
//            UNIT=SYSDA,SPACE=(TRK,(1,1)),
//            DCB=(RECFM=FB,LRECL=25,BLKSIZE=250)
//* STEP 2: External vendor executable is NOT in this repository.
//* Vendor consumes AAOUTDD and produces AAIN DD per contract.
//VENDOR   EXEC PGM=VNDAAENG,COND=(0,NE,EXTRACT)
//AAOUTDD  DD DSN=&&AAOUT,DISP=(OLD,PASS)
//AAINDD   DD DSN=&&AAIN,DISP=(NEW,PASS),
//            UNIT=SYSDA,SPACE=(TRK,(1,1)),
//            DCB=(RECFM=FB,LRECL=28,BLKSIZE=280)
//* STEP 3: Bank-owned consumer reads vendor charge file.
//CONSUME  EXEC PGM=AAFEEPST,COND=(0,NE,VENDOR)
//AAINDD   DD DSN=&&AAIN,DISP=(OLD,DELETE)
