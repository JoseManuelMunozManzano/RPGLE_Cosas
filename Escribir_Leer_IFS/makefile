BIN_LIB=CMPSYS
LIBLIST=$(BIN_LIB) JOMUMA1
SHELL=/QOpenSys/usr/bin/qsh

all: crtreadifs.sqlrpgle

%.sqlrpgle:
	system -s "CHGATR OBJ('/home/JOMUMA/writereadifs/qrpglesrc/$*.sqlrpgle') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/$*) SRCSTMF('/home/JOMUMA/writereadifs/qrpglesrc/$*.sqlrpgle') COMMIT(*NONE) DBGVIEW(*SOURCE) OPTION(*EVENTF) OBJTYPE(*MODULE) RPGPPOPT(*LVL2)"
	system "CRTPGM PGM($(BIN_LIB)/$*) MODULE($(BIN_LIB)/$*)"
	system "DLTOBJ OBJ($(BIN_LIB)/$*) OBJTYPE(*MODULE)"
	system "CPYFRMSTMF FROMSTMF('/home/JOMUMA/writereadifs/qrpglesrc/$*.sqlrpgle') TOMBR('/QSYS.LIB/$(BIN_LIB).LIB/QRPGLESRC.FILE/$*.MBR') MBROPT(*REPLACE)"
	system "CHGPFM FILE($(BIN_LIB)/QRPGLESRC) MBR($*) SRCTYPE(SQLRPGLE)"
