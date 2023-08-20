BIN_LIB=CMPSYS
LIBLIST=$(BIN_LIB) JOMUMA1
SHELL=/QOpenSys/usr/bin/qsh

all: ajedreci.sql ajedrelee.sqlrpgle

%.sqlrpgle:
	system -s "CHGATR OBJ('/home/JOMUMA/ajedrez/qrpglesrc/$*.sqlrpgle') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/$*) SRCSTMF('/home/JOMUMA/ajedrez/qrpglesrc/$*.sqlrpgle') COMMIT(*NONE) DBGVIEW(*SOURCE) OPTION(*EVENTF) OBJTYPE(*MODULE) RPGPPOPT(*LVL2)"
	system "CRTPGM PGM($(BIN_LIB)/$*) MODULE($(BIN_LIB)/$*)"
	system "DLTOBJ OBJ($(BIN_LIB)/$*) OBJTYPE(*MODULE)"
	system "CPYFRMSTMF FROMSTMF('/home/JOMUMA/ajedrez/qrpglesrc/$*.sqlrpgle') TOMBR('/QSYS.LIB/$(BIN_LIB).LIB/QRPGLESRC.FILE/$*.MBR') MBROPT(*REPLACE)"
	system "CHGPFM FILE($(BIN_LIB)/QRPGLESRC) MBR($*) SRCTYPE(SQLRPGLE)"

%.sql:
	system -s "CHGATR OBJ('/home/JOMUMA/ajedrez/qsqlsrc/$*.sql') ATR(*CCSID) VALUE(1252)"
	system -s "RUNSQLSTM SRCSTMF('/home/JOMUMA/ajedrez/qsqlsrc/$*.sql') COMMIT(*NONE)"
