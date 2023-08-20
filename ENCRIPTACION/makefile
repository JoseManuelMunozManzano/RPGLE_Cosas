BIN_LIB=CMPSYS
LIBLIST=$(BIN_LIB) JOMUMA1
SHELL=/QOpenSys/usr/bin/qsh

all: encriptpf.sql encript.sqlrpgle decript.sqlrpgle

%.sqlrpgle:
	system -s "CHGATR OBJ('/home/JOMUMA/encript/qrpglesrc/$*.sqlrpgle') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/$*) SRCSTMF('/home/JOMUMA/encript/qrpglesrc/$*.sqlrpgle') COMMIT(*CHG) DBGVIEW(*SOURCE) OPTION(*EVENTF) OBJTYPE(*MODULE) RPGPPOPT(*LVL2)"
	system "CRTPGM PGM($(BIN_LIB)/$*) MODULE($(BIN_LIB)/$*)"
	system "DLTOBJ OBJ($(BIN_LIB)/$*) OBJTYPE(*MODULE)"
	system "CPYFRMSTMF FROMSTMF('/home/JOMUMA/encript/qrpglesrc/$*.sqlrpgle') TOMBR('/QSYS.LIB/$(BIN_LIB).LIB/QRPGLESRC.FILE/$*.MBR') MBROPT(*REPLACE)"
	system "CHGPFM FILE($(BIN_LIB)/QRPGLESRC) MBR($*) SRCTYPE(SQLRPGLE)"

%.rpgle:
	system -s "CHGATR OBJ('/home/JOMUMA/encript/qrpglesrc/$*.rpgle') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTBNDRPG PGM($(BIN_LIB)/$*) SRCSTMF('/home/JOMUMA/encript/qrpglesrc/$*.rpgle') DBGVIEW(*ALL) OPTION(*EVENTF)"	
	system "CPYFRMSTMF FROMSTMF('/home/JOMUMA/encript/qrpglesrc/$*.rpgle') TOMBR('/QSYS.LIB/$(BIN_LIB).LIB/QRPGLESRC.FILE/$*.MBR') MBROPT(*REPLACE)"
	system "CHGPFM FILE($(BIN_LIB)/QRPGLESRC) MBR($*) SRCTYPE(RPGLE)"

%.sql:
	system -s "CHGATR OBJ('/home/JOMUMA/encript/qsqlsrc/$*.sql') ATR(*CCSID) VALUE(1252)"
	system -s "RUNSQLSTM SRCSTMF('/home/JOMUMA/encript/qsqlsrc/$*.sql') COMMIT(*NONE)"
