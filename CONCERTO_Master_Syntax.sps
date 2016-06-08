ECHO '***********************************************************' .
ECHO '***********************************************************' .
ECHO '*****            [ PROGRAM Identification ]           *****' .
ECHO '***********************************************************' .
ECHO '***********************************************************' .
ECHO '' .
ECHO 'Project ID    : 93_30_00_00 ' .
ECHO 'Project Name  : Aufbau Datenanalyse ' .
ECHO 'Wave          : n/a ' .
ECHO 'Year          : n/a ' .
ECHO 'Country       : n/a ' .
ECHO 'Data Set      : e.g. Express / Freight data sets ' .
ECHO '' .
ECHO 'Author        : Georg Maubach (MRSC) ' .
ECHO 'Last Editor   : Georg Maubach (MRSC) ' .
ECHO '' .
ECHO 'Created       : 2005-10-22 ' .
ECHO 'Modified      : 2006-04-17 ' .
ECHO 'Last Used     : 2005-14-17 ' .
ECHO '' .
ECHO 'Status        : Draft/Version/Release' .
ECHO 'Release No    : D/V/Rxx' .
ECHO '' .
ECHO 'Source System : SPSS (Win), Rel. 14.0.1 (07-Dec-2005) ' .
ECHO 'Target System : SPSS (Win), Rel. 12 ' .
ECHO '' .
ECHO 'Job           : template/prototype/input/labeling/   ' .
ECHO '                cleaning/preparation/tables/analysis/ ' .
ECHO '                main' .
ECHO '' .
ECHO 'Based on      : CONCERTO_Master_Syntax_Beta_28.sps ' .
ECHO 'File Name     : CONCERTO_Master_Syntax_Beta_31.sps ' .
ECHO '' .
ECHO '***********************************************************' .
ECHO '***********************************************************' .

/* [ Description ] ---------------------------------------*/ .
/* This master syntax template gives the structure of a
/* syntax file.
/*--------------------------------------------------------*/ .

/* [ General Remarks ] -----------------------------------*/ .
/* - Die Syntax wurde für SPSS 12.0 entwickelt, die Datei-
/*   namen bis zu 64 Zeichen unterstützt. Eine Entwicklung
/*   für SPSS 11.0 wäre möglich gewesen, hätte jedoch bei
/*   den Variablennamen zu schwer nachvollziehbaren
/*   Makronamen geführt. Die Syntax kann jedoch unter Berück-
/*   sichtigung dieser Einschränkung umgeschrieben werden.
/*   Sie verwendet bis auf den ECHO Befehl, auf den auch
/*   verzichtet werden kann, keine weiteren Befehle, die
/*   nicht auch unter SPSS 11.0 verfügbar wären.
/*--------------------------------------------------------*/ .

/* [ Release Notes ] ---------------------------------------*/ .
/* Version 1: - Die Syntax setzt Variablen mit einer
/*              minimalen Länge von F4.0 voraus.
/*-------1---------2---------3---------4---------5--------6 */ .

/* [ Country Specifics ] ---------------------------------*/ .
/* None
/*--------------------------------------------------------*/ .

/* [ Operation ] -----------------------------------------*/ .
/* This syntax can not be run cause the basic configuratins
/* have to be adapted to the actual project.
/* It is organized in sections whose sequence is optimized
/* to run the basic steps in a syntax only once. This leads
/* to a structure that helps to find every step at one
/* place.
/* Also it is organized to store the values for commands
/* which have to be used multiple times in the syntax in
/* macro definitions which ensures that the value has to be
/* given only once at the beginning of the program. Chances
/* have to be made only to the macro defintion but not to
/* the program code itself. This helps to avoid programming
/* failures and keeps the program code consistent.
/* This syntax is designed to read the data set only once
/* but to write it if necessary more than once to different
/* output files with names other than the input file.
/* This shall ensure that the original data is not over-
/* written accidentially.
/* The syntax combines the use of macros and a non-macro
/* structure. If the syntax shall be used without macros
/* section F Routines can be omitted. In section G Main
/* Program the chapter 'Master Syntax WITH macros' can be
/* deleted.
/*--------------------------------------------------------*/ .

/* [ Document History ] ----------------------------------*/ .
/* Georg Maubach (MRSC) 01-May-2005
/* Version 1: - Erste Fassung der CONCERTO Master Syntax
/*            - Syntax setzt auf der
/*              Master_Syntax_for_Experts.Beta.Version_0_4.sps
/*              auf
/* Georg Maubach (MRSC) 05-May-2005
/* Version 2: - Änderung der Struktr hinsichtlich der Pro-
/*              zessoreinstellungen über das SET Kommando
/* Georg Maubach (MRSC) 10-May-2005
/* Version 3: - Einführung des Error Reportings über OMS
/* Georg Maubach (MRSC) 13-May-2005
/* Version 4: - Einführung von ECHO für die Syntax- und
/*              Abschnittidentifikation
/*            - Einführung der SPSS Version für Makros zur
/*              selektiven Auswahl von Makros für spezielle
/*              SPSS-Versionen
/*            - Abschnitt E1 Dynamic Syntax ist weggefallen
/* Georg Maubach (MRSC) 24-May-2005
/* Version 5: - Einführung des Anhaltens des OMS Logs in
/*              der atend() Routine
/* Georg Maubach (MRSC) 15-Jun-2005
/* Version 8: - Einführung des Error Reportings in Ab-
/*              hängigkeit von der SPSS-Version
/* Georg Maubach (MRSC) 18-Jun-2005
/* Version 9: - Einführung einer neuen Klasse von Makros:
/*              Signale. Signale werden dazu verwendet,
/*              das Programm in verschiedene Betriebsmodi
/*              zu schalten, z. B. ein- und ausschalten
/*              des Debug-Modus oder ein- und ausschalten
/*              der Ablaufverfolgung (Trace).
/*              Um die Ablaufverfolgung ein- und aus-
/*              schalten zu können, müssen die Nachrichten
/*              mit @trace 'Meldungstext' angegeben
/*              werden.
/* Georg Maubach (MRSC) 20-Jul-2005
/* Version 10: - Umbenennung von @procedure in @analysis.
/*             - Einführung zweier neuer Main Routines
/*               @construct
/*               @deconstruct
/*               Diese Makros enthalten statistische Aus-
/*               wertungen, die Variablen erzeugen, die im
/*               Makro @analysis benötigt werden. @construct
/*               erzeugt die Variablen, @deconstruct löscht
/*               sie wieder aus dem Datensatz.
/*               Die Makros hätten integraler Bestandteil
/*               von @analysis sein können. Die Behandlung
/*               als Main Routine hat jedoch den Vorteil,
/*               dass diese Routinen ohne die Makros ändern
/*               zu müssen bei Bedarf von der Projektleitung
/*               im Abschnitt F - Main Program auskommentiert
/*               werden können. Dies trifft insbesondere auf
/*               @deconstruct zu, wenn mit den erzeugten
/*               Werten weitergerechnet werden soll.
/* Georg Maubach (MRSC) 29-Jul-2005
/* Version 11: - Einfügen von neuen Makros für die Definition
/*               von fehlenden Werten. Diese Werte sind
/*               immer 4-stellig im Bereich -996 bis -999.
/*               Alle Variablen, die mit dieser Syntax ver-
/*               arbeitet werden, müssen deshalb mindestens
/*               F4.0 formatiert werden.
/* Georg Maubach (MRSC) 03-Aug-2005
/* Version 12: - Trennung von Standard Constants (Globals)
/*               und Project Constants (Init)
/*             - Herausnahme des Makros @sysconf, da es
/*               im Programmlauf nur einmal aufgerufen
/*               werden muss. Übernahme in Abschnitt D.
/*               Andere Abschnitte verschieben sich ent-
/*               sprechend.
/*             - Überarbeitung des Makros @main. Parametri-
/*               sierung für verschiedene Splits.
/*             - Überarbeitung des Abschnitts G Main
/*               Program für mehrere Splits.
/*             - Neues Makro @smp (=show macro parameter)
/*               aufgenommen.
/* Georg Maubach (MRSC) 09-Aug-2005
/* Version 13: - Abschnitt C Init in Globals umbenannt.
/* Georg Maubach (MRSC) 05-Sep-2005
/* Version 14: - Distribution list ergänzt.
/*             - Setzen des Journals gelöscht. Das Journal
/*               sollte nur einmal für alle Syntaxen über
/*               die Oberfläche von SPSS auf eine allge-
/*               meingültige Datei gesetzt werden. Andern-
/*               wird bei jedem neuen Setzen des Journals
/*               durch den erneuten Aufruf der Syntax
/*               das alte Journal überschrieben. Damit
/*               gehen aber auch alle gespeicherten Syntax-
/*               läufe verloren.
/*             - Macro Definition für User gelöscht.
/*             - Programmstruktur im Main Program ohne Ver-
/*               wendung von Standard Routinen (Makros) er-
/*               gänzt.
/*             - Abschnitt B Standard Constants und
/*               Abschnitt C Project Constants zusammenge-
/*               fasst. Auch wenn die Werte in den Standard
/*               Constants von Projekt zu Projekt variiren,
/*               so sind die Bezeichner für alle Projekte
/*               identisch.
/*             - Im Abschnitt C Project Constants stehen
/*               jetzt nur noch die projektspezifischen De-
/*               finitionen für Makros.
/*             - Einführung von File Locations und Über-
/*               nahme der Makro Definitionen aus diesem
/*               Abschnitt in die anderen Makro Definitionen.
/*             - Einführung von PRESERVE-RESTORE für separat
/*               für jeden Abschnitt mit Makrodefinitionen.
/* Georg Maubach (2005-10-22)
/* Version 19: - Erweiterung und Überarbeitung der Program
/*               Identification mit Berücksichtung der An-
/*               forderung von großen Marktforschungs-
/*               projekten:
/*               - Welle
/*               - Land für das die Syntax erstellt wurde
/*               - Release Nr. und Release Datum
/*               - Version Nr. und Version Datum
/*               - neben dem Autor auch den Editor, der die
/*                 zuletzt durchgeführten Änderungen vorge-
/*                 nommen hat
/*               - Ertellungsdatum
/*               - Letztes Änderungsdatum
/*               - Job, wenn mehrere Syntaxen für die ver-
/*                 schiedenen Aufgaben innerhalb der Daten-
/*                 analyse für ein Projekt erstellt werden
/*               - Information über die Basis, auf der die
/*                 Syntax beruht
/*               Diese Informationen wurden mit SPSS ECHO 
/*               Kommandos versehen, um sie in das Output-
/*               fenster auszugeben. Bei einer Speicherung
/*               des Outputs ist so erkennbar mit welcher
/*               Syntax die Analysen durchgeführt wurden.
/*             - Änderung von @pprj
/*             - Änderung der Makrowerte für Missing Values
/* Georg Maubach (2005-11-16)
/* Version 20: - Date of syntax run included in @atend
/*               procedure and syntax structured without
/*               macros.
/* Georg Maubach (2005-11-21)
/* Version 21: - Date and time macros added to Standard
/*               Constants section to be used in file
/*               names.
/* Georg Maubach (2005-11-23)
/* Version 22: - Adaption of standard constants
/* Georg Maubach (2005-11-28)
/* Version 23: - Layout der Program Identification verein-
/*               facht und neu gestaltet.
/*             - Syntax Description Section und Operation
/*               Section neu eingefügt.
/*             - Neue Struktur für Section G Main Program
/*               WITHOUT macros erstellt.
/*             - Standardvariablen "sequence", "caseid",
/*               "respondent", "country", "year", "wave",
/*               "valid0-6", "valid", "total", "split",
/*               "weight1-3", "weight" eingeführt.
/*             - Neues Signal "@SIGNOC" eingeführt, das
/*               es für das Debugging ermöglicht, die
/*               Zahl der Fälle zu beschränken.
/*               "@SIGNOC" schaltet die Funktion ein oder
/*               aus. Ein Wert >0 schaltet die Funktion
/*               ein, ein Wert von 0 aus. Der Wert >0 wird
/*               ebenfalls genutzt, um die Zahl der Fälle 
/*               zu bestimmen, die in der Arbeitsdatei ver-
/*               bleiben sollen.
/*               Das Signal wird in @atbegin verwendet.
/*             - Neuen Missing Value Wert "@EXCL" einge-
/*               führt. Er beschreibt die Fälle, die von
/*               einer Analyse ausgeschlossen werden, z. B.
/*               alle Befragten, die jünger als 18 Jahre
/*               alt sind. Dies ist jedoch kein Filter für
/*               eine gesamte Analyse, sondern nur ein
/*               Ausschluss für die Auszählung einer
/*               Variablen, z. B. Alter des Befragten.
/*               Wird die Variable Alter jedoch später
/*               dazu verwendet einen Filter oder einen
/*               Split zu definieren, so wirkt dieser Aus-
/*               schluss dann als Filter für die ausge-
/*               schlossenen Fälle.
/*               Der Missing Value kann in einer Antwort-
/*               statistik dazu verwendet werden,
/*               Aufschluss über die Fallzahlen zu geben
/*               und trägt dann dazu bei Differenzen in 
/*               den ausgezählten Fällen zur Basis zu
/*               erklären.
/*             - Macros zur Definition von Dateinamen für
/*               temporäre Datensätze eingeführt.
/*             - Macros "@today", "@now" und "@datetime"
/*               eingeführt. Diese können in Dateinamen zur
/*               Kennzeichnung von Datensätzes verwendet
/*               werden, um eine tägliche Versionskontrolle
/*               durchzuführen.
/*             - Einstellung für die Kompression von Daten-
/*               sätzen eingeführt (SCOMPRESSION).
/*             - Einstellung für die Festlegung des Wertes
/*               für einen System Missing Value eingeführt.
/*             - Einstellung für die Festlegung eines
/*               Währungsformats für Euro eingeführt.
/*             - Einstellung für die Festlegung des Jahr-
/*               hunderts eingeführt.
/* Georg Maubach (2006-01-24)
/* Version 24: - Einführung neuer Versionsnomenklatur:
/*               E = Entwurfsversion, innerhalb der Daten-
/*                   analyse
/*               V = fertige Version und innerhalb der
/*                   der Organisation kommuniziert
/*               R = fertige Version und nach extern
/*                   kommuniziert
/* Georg Maubach (2006-01-25)
/* Version 25: - Einführung einer neuen Struktur und neuer
/*               Namen für Main Program
/*               Asterix:   einfache und flexible Syntax
/*               Obelix:    Syntax unter Verwendung von
/*                          Include-Dateien für umfangreiche
/*                          Projekte
/*               Miraculix: Syntax unter Verwendung von
/*                          Macros für komplexe Projekte
/* Georg Maubach (2006-02-01)
/* Version 26: - Ergänzung von Einträgen für die Program
/*               Identification
/*             - Ergänzung von Konstanten im Abschnitt B
/*               Standard Constants
/*             - Einführung des neuen Signals @SIGOUT. Es
/*               schaltet die Ausgabe des Outputs mit
/*               Hilfe des Output Management Systems (OMS)
/*               ein oder aus.
/* Georg Maubach (2006-03-24)
/* Version 27: - Länge des Logs im SPSS Output über SET im
/*               Abschnitt D System Configuration auf
/*               "unendlich" gesetzt, so dass immer die
/*               vollständigen Logs als Textfenster ange-
/*               zeigt werden. Funktioniert in SPSS 14,
/*               jedoch nicht in SPSS 12.
/* Georg Maubach (2006-03-27)
/* Version 28: - OLANG wurde auf ENGLISH gesetzt, da die
/*               die Statistiken dann mit englischen Be-
/*               griffen belegt werden, was notwendig ist,
/*               um mit dem OMS auf die entsprechenden
/*               Tabellen zugreifen zu können und unab-
/*               hängig von der verwendeten Sprache zu sein.
/*               Das OMS greift auf die Namen der
/*               Statistiken zurück, z. B. CORRELATIONS,
/*               um Werte auszulesen. Bei Verwendung von
/*               Deutsch als Output-Sprache würde statt-
/*               dessen KORRELATION im Output stehen. Wenn
/*               jetzt mit dem OMS auf KORRELATION als
/*               Tabellenname zugegriffen wird, läuft die
/*               Syntax in einer anderen Sprachversion
/*               nicht mehr. Das OMS würde keine Werte
/*               liefern. Für die internationale Zusammen-
/*               arbeit mit Kollegen und Instituten ist die
/*               Verwendung einheitlicher Sprachversionen
/*               deshalb Voraussetzung.
/*             - CACHE = 10 eingeführt, um Daten früher
/*               zwischenzuspeichern. CACHE kann den Durch-
/*               lauf der Syntaxen verbessern.
/*             - Nach GET FILE in @datadef wird der Chip
/*               CACHE .
/*               EXECUTE .
/*               eingefügt. Sie bewirkt, dass die Daten
/*               direkt in eine temporäre SPSS Datendatei
/*               geschrieben werden, so dass alle Zugriffe,
/*               die ein Lesen der Daten erfordern
/*               schneller ausgeführt werden können.
/* Georg Maubach (2006-03-31)
/* Version 29: - Restructuring of sections in comments.
/*             - Insertion of @output macro for output
/*               management.
/* Georg Maubach (2006-04-12)
/* Version 30: - Path Names überarbeitet
/*
/* Georg Maubach (MRSC) / 17-APR-2006 / Version 31
/* - Signal @SIGODBC eingeführt.
/* - Protocol name "protocol.txt" for all runtime messages
/*   changed to "Runtime_Protocol.txt".
/* - Addtional protocol "Definition_Protocol.txt" for all
/*   definitions introduced.
/*
/*-------------------------------------------------------*/ .

/* [ ToDos] ----------------------------------------------*/ .
/* (Date of ToDo)    ToDo Discription   (Date of ToDo Done)
/* (03-Aug-2005) Complete debugging            (to be done)
/*--------------------------------------------------------*/ .

/* [ Quality Assurance ] ---------------------------------*/ .
/* [ Quality Assurance ] ---------------------------------*/ .
/* Date         : DD-MMM-YYYY
/* Aditors      : Name (Organisation)
/* Contributors : Name (Organisation)
/* Coverage     : Dataset, Syntax, Split
/* Method       : Output comparison using diffent syntaxes
/* Result       : no difference found = ok
/* Actions      : none
/*--------------------------------------------------------*/ .

/* [ Distribution List ] ---------------------------------*/ .
/* (DD-MMM-YYY) Firstname Lastname (Company)    (Version XX)
/*--------------------------------------------------------*/ .

/* [ Editing Marks ] -------------------------------------*/ .
/* %EM% : Editing Marker
/* Example:
/* %EM%: Development has to be continued in this section
/* --------------------------------------------------------
/* %IA% : Adaption for network infrastructure
/* *%IA%.
/* /* >>>>> Begin infrastructure adaption <<<<< */.
/* /* >>>>> End infrastructure adaption <<<<< */.
/* --------------------------------------------------------
/* %CA% : Country adaption necessary in syntax
/*        code. If only macros have to be
/*        defined with another value what does
/*        not effect the syntax code itself
/*        the country adaption is marked with %CA%.
/*        If there are country specific variables
/*        or filters these country specifics have
/*        to be regarded and the syntax has to be
/*        reworked.
/* Example:
/* *%CA%.
/* *////////// Begin Country Adaption //////////* .
/* Syntax code to be changed
/* *////////// End Country Adaption //////////* .
/* --------------------------------------------------------
/* %DD% : Data dependent code is marked if
/*        syntax programs are used for 
/*        different market segments. This 
/*        special code which is not part of
/*        the master program should be 
/*        marked with %DDC% and commented
/* Example:
/* *%DD%.
/* /* >>>>> Begin data dependent code for EXPRESS data sets <<<<< */.
/* /* >>>>> End data dependent code for EXPRESS data sets <<<<< */.
/* --------------------------------------------------------
/* %SA% : Special Analysis
/* Example:
/* *%SA%.
/* /* ##### Begin special analysis ##### /* .
/* /* ##### End special analysis ##### /* .
/* --------------------------------------------------------
/* %##% : Chips which seem not to work proberly
/*        are marked with %##% and embedded with:
/* Example:
/* *%##%.
/* /* ##### Begin instable code ##### /* .
/* /* ##### End instable code ##### /* .
/*--------------------------------------------------------*/ .

ECHO '*---------------------------------------------------------*' .
ECHO '*                        [ START ]                        *' .
ECHO '*---------------------------------------------------------*' .

OMS
   /SELECT LOGS TEXTS WARNINGS
   /DESTINATION
    FORMAT    = TEXT
    OUTFILE   = 'c:\temp\Definition_Protocol.txt'
   /TAG = 'Definition_Protocol' .

ECHO '/*========================================================*/' .
ECHO '/*                  A. Processor Controls                 */' .
ECHO '/*========================================================*/' .
PRESERVE . /* Level 1 Begin: Processor Controls */ .

* Output * .
SET PRINTBACK = BOTH     /* command printback in the journal file (listing/both/OFF) */ .
SET RESULTS   = LISTING  /* text output generated by program commands (LISTING/none) */ .

* Errors * .
SET ERRORS    = LISTING  /* print errors in text output und SmartViewer Warnungen und Fehlermeldungen (LISTING/off) */ .
SET UNDEFINED = WARN     /* warn if a numeric variable is assigned a value other than a number (WARN/nowarn) */ .

* Macro Treatment * .
SET MEXPAND   = ON   /* macro expansion (ON/off) */ .
SET MPRINT    = OFF  /* macro expansion in the output (on/OFF) */ .
SET MITERATE  = 1000 /* maximum loop traversals */ .
SET MNEST     = 50   /* maximum nesting level */ .
SET MXLOOPS   = 40   /* maximum number of loop definitions */ .

ECHO '/*========================================================*/' .
ECHO '/*                   B. Standard Constants                */' .
ECHO '/*========================================================*/' .
PRESERVE . /* Level 2 Begin: Standard Constants */ .
SET PRINTBACK = ON .
SET ERRORS    = OFF .
SET WARNINGS  = OFF .

/*----- B1. Date and Time -----*/ .
DEFINE @today     () 'YYYY-MM-YY'                             !ENDDEFINE .
DEFINE @now       () 'HH-MM'                                  !ENDDEFINE .
DEFINE @datetime  () !CONCAT(!UNQUOTE(!EVAL(@today)),'--',
                             !UNQUOTE(!EVAL(@now))
                            )                                 !ENDDEFINE .

/*----- B2. Project Information -----*/ .
DEFINE @prjid     () 'xx_xx_xx_xx'                            !ENDDEFINE .
DEFINE @prjname   () 'project_name'                           !ENDDEFINE .
DEFINE @prjshort  () 'short_project_name'                     !ENDDEFINE .
DEFINE @client    () 'Firstname Lastname (Organisation)'      !ENDDEFINE .

DEFINE @wave      () 'Wave No'                                !ENDDEFINE .
DEFINE @year      () 2005                                     !ENDDEFINE .
DEFINE @countryID () 'Internet Top Level Domain, e.g. DE'     !ENDDEFINE .
DEFINE @country   () 'Country Name'                           !ENDDEFINE .
DEFINE @segment   () 'Market Segment Name'                    !ENDDEFINE .

DEFINE @fieldbeg  () 'YYYY-MM-DD'                             !ENDDEFINE .
DEFINE @fieldend  () 'YYYY-MM-DD'                             !ENDDEFINE .
DEFINE @datedata  () 'YYYY-MM-DD'                             !ENDDEFINE .

DEFINE @job       () 'Syntax job name, e.g. input'            !ENDDEFINE .

/*----- B3. Project Team -----*/ .
DEFINE @customer  () 'Customer Name'                          !ENDDEFINE .
DEFINE @mri       () 'Market Research Institut, e.g. MRSC'    !ENDDEFINE .
DEFINE @analyst   () 'Georg Maubach (MRSC)'                   !ENDDEFINE .
DEFINE @fieldorg  () 'Field Organisation'                     !ENDDEFINE .
DEFINE @partner1  () 'Partner Name'                           !ENDDEFINE .
DEFINE @partner2  () 'Partner Name'                           !ENDDEFINE .

/*----- B4. Dataset Label -----*/ .
DEFINE  @filelab  () !QUOTE(!CONCAT(
                     !UNQUOTE(!EVAL(@pid)),' ',
                     !UNQUOTE(!EVAL(@prjname)),' ',
                     !UNQUOTE(!EVAL(@wave)),'. Wave ',
                     !UNQUOTE(!EVAL(@countryID)),'-',
                     !UNQUOTE(!EVAL(@country)),'-',
                     !UNQUOTE(!EVAL(@year)),' ',
                     !UNQUOTE(!EVAL(@mri)),' ',
                     !UNQUOTE(!EVAL(@analyst))
                                   )
                            )                                 !ENDDEFINE .

/*----- B5. Data Set Information -----*/ .
DEFINE  @dsinfo1 () 'Information on dataset'                  !ENDDEFINE .

/*----- B6. File Locations -----*/ .
DEFINE @drive      () 'c:\'                                   !ENDDEFINE .
DEFINE @wrkplc     () 'workplace2\'                           !ENDDEFINE .

/*----- B7. Pathes -----*/ .
DEFINE @psys       () 'c:\windows\system32\'     !ENDDEFINE .
DEFINE @pspss      () 'c:\programme\spss\'       !ENDDEFINE .
DEFINE @plib       () !EVAL(@pprj) + 'syntax\'   !ENDDEFINE .
DEFINE @psbs       () 'currently_not_used'       !ENDDEFINE .
DEFINE @ptmp       () !EVAL(@pprj) + 'tmp\'      !ENDDEFINE .
DEFINE @psps       () !EVAL(@pprj) + 'syntax\'   !ENDDEFINE .

DEFINE @plib       () !QUOTE(!CONCAT(
                      !UNQUOTE(!EVAL(@drive)),
                      !UNQUOTE(!EVAL(@wrkplc)),
                      'lib\'     
                                    )
                             )                                !ENDDEFINE .
DEFINE @ptmp       () !QUOTE(!CONCAT(
                      !UNQUOTE(!EVAL(@drive)),
                      !UNQUOTE(!EVAL(@wrkplc)),
                      'tmp\'
                                    )
                             )                                !ENDDEFINE .
DEFINE @pusrtpl    () !QUOTE(!CONCAT(
                      !UNQUOTE(!EVAL(@drive)),
                      !UNQUOTE(!EVAL(@wrkplc)),
                      'User-Templates\'
                                    )
                             )                                !ENDDEFINE .
DEFINE @pprotocol  () !EVAL(@drive) + !EVAL(@wrkplc) + 'tmp\' !ENDDEFINE .
DEFINE @pomslog    () !EVAL(@drive) + !EVAL(@wrkplc) + 'tmp\' !ENDDEFINE .


DEFINE @pprj       () !QUOTE(!CONCAT(
                      !UNQUOTE(!EVAL(@drive)),
                      !UNQUOTE(!EVAL(@wrkplc)),
                      'project\'
                      !UNQUOTE(!EVAL(@prjid)),'_',
                      !UNQUOTE(!EVAL(@prjname)),'\',
                      !UNQUOTE(!EVAL(@cid)),'\'
                                   )
                           )                                  !ENDDEFINE .
DEFINE @pdatsav    () !EVAL(@pprj) + 'data.sav\'              !ENDDEFINE .
DEFINE @pdatxls    () !EVAL(@pprj) + 'data.xls\'              !ENDDEFINE .
DEFINE @pdatmdb    () !EVAL(@pprj) + 'data.mdb\'              !ENDDEFINE .
DEFINE @pdattxt    () !EVAL(@pprj) + 'data.txt\'              !ENDDEFINE .

/*----- B8. File Names -----*/ .
DEFINE @fdatsi1    () 'input_dataset_1.sav'                   !ENDDEFINE .
DEFINE @fdatso1    () !QUOTE(!CONCAT(
                     !UNQUOTE(!EVAL(@pid)),'_',
                     !UNQUOTE(!EVAL(@prjname)),'_',
                     !UNQUOTE(!EVAL(@wid)),'_',
                     !UNQUOTE(!EVAL(@year)),'_',
                     !UNQUOTE(!EVAL(@countryID)),'_',
                     !UNQUOTE(!EVAL(@job)),'_',
                     !UNQUOTE(!EVAL(@datetime))
                                   )
                             )                                !ENDDEFINE .

DEFINE @foeqxi1    () 'open_ended_question_1.xls'             !ENDDEFINE .
DEFINE @foeqso1    () 'open_ended_question_1.sav'             !ENDDEFINE .

DEFINE @fdataux1   () 'auxiliary_dataset_1.sav'               !ENDDEFINE .

DEFINE @fdattmp1   () 'temporary_data_set_1.sav'              !ENDDEFINE .
DEFINE @fdattmp2   () 'temporary_data_set_2.sav'              !ENDDEFINE .
DEFINE @fdattmp3   () 'temporary_data_set_3.sav'              !ENDDEFINE .
DEFINE @finctmp    () 'dynamic.inc'                           !ENDDEFINE .

DEFINE @fprotocol  () 'Runtime_Protocol.txt'                  !ENDDEFINE .
DEFINE @fomslog    () 'omslog.txt'                            !ENDDEFINE .

* DEFINE @ftabtpl  () 'MRSC-Standard.1.tlo'                   !ENDDEFINE .
* DEFINE @fplottpl () 'chart_style.sgt'                       !ENDDEFINE .
* DEFINE @ftlook   () @usrtmpl + @ftabtpl                     !ENDDEFINE .
* DEFINE @fctemp   () @pspss   + @fplottpl                    !ENDDEFINE .

/*----- B9. Library Names -----*/ .
DEFINE @pCONCERTO  () 'c:\workplace2\CONCERTO.R1_0\'          !ENDDEFINE .

DEFINE @pdatelib   () 'date.lib\'                             !ENDDEFINE .
DEFINE @pdeflib    () 'def.lib\'                              !ENDDEFINE .
DEFINE @pgraphlib  () 'graph.lib\'                            !ENDDEFINE .
DEFINE @piolib     () 'io.lib\'                               !ENDDEFINE .
DEFINE @pimportlib () 'import.lib\'                           !ENDDEFINE .
DEFINE @pmodlib    () 'mod.lib\'                              !ENDDEFINE .
DEFINE @psamplelib () 'sample.lib\'                           !ENDDEFINE .
DEFINE @pstatlib   () 'stat.lib\'                             !ENDDEFINE .
DEFINE @ptablib    () 'tab.lib\'                              !ENDDEFINE .
DEFINE @putilslib  () 'utils.lib\'                            !ENDDEFINE .

DEFINE @fCONCERTO  () 'CONCERTO.3.inc .'                      !ENDDEFINE .

/*----- B10. Development and Debugging -----*/ .
/* Macro signal to control the execution of macros, e.g. general               */ .
/* routines, subroutines or main routines.                                     */ .
DEFINE @SIGTRC  () 1 !ENDDEFINE . /* Signal for tracing   (1=ON, 0=OFF)        */ .

/* Macro signal to be used in other macros whose execution shall be            */ .
/* executed only if a debugging of routines is necessary, e.g. in the          */ .
/* macro to show the macro parameter values in @smp.                           */ .
DEFINE @SIGDBG  () 1 !ENDDEFINE . /* Signal for debugging (1=ON, 0=OFF)        */ .

/* Macro signal to define chips that are only needed for quality               */ .
/* assurance during program development. These chips can be shut off by        */ .
/* this signal.                                                                */ .
DEFINE @SIGCHK  () 1 !ENDDEFINE . /* Signal for checking  (1=ON, 0=OFF)        */ .

/* Macro signal to reduce the cases in the data set to the number defined in   */ .
/* the macro @SIGNOC. The routine is called in @atbegin.                       */ .
/* Example: @SIGNOC () 100 !ENDDEFINE would reduce the number of cases in the  */ .
/*          data set to 100. The number is greater than 0 and would therefore  */ .
/*          been carried out in the macro @atbegin                             */ .
DEFINE @SIGNOC  () 0 !ENDDEFINE . /* Signal for case reduction (>0=ON, 0=OFF)  */ .

/* Macro signal to switch on or off of output to files using the Output        */ .
/* Management System OMS                                                       */ .
DEFINE @SIGOUT  () 1 !ENDDEFINE . /* Signal for output (1=ON, 0=OFF)           */ .

/* Macro signal to switch on or off loading or saving file using the ODBC      */ .
/* interface                                                                   */ .
DEFINE @SIGODBC () 1 !ENDDEFINE . /* Signal for ODBC (1=ON, 0=OFF)             */ .

/*----- B11. Missing Values -----*/ .
DEFINE @DK      () -994 !ENDDEFINE . /* Dont Know Value                        */ .
DEFINE @NA      () -995 !ENDDEFINE . /* No Answer Value                        */ .
DEFINE @DKNA    () -996 !ENDDEFINE . /* Dont Know / No Answer Value            */ .
DEFINE @FILMIS  () -997 !ENDDEFINE . /* Filter Missing Value                   */ .
DEFINE @EXCL    () -998 !ENDDEFINE . /* Value for excluded cases, e.g. age <18 */ .
DEFINE @USEMIS  () -999 !ENDDEFINE . /* (General) User Missing / Initial Value */ .

/*----- B12. CTABLES configuration -----*/ .
DEFINE @srowmis  () EXCLUDE !ENDDEFINE. /* Value for row variables in MISSING of CTABLES   */ .
DEFINE @srowemp  () INCLUDE !ENDDEFINE. /* Value for row variables in EMPTY of CTABLES     */ .
DEFINE @scolmis  () EXCLUDE !ENDDEFINE. /* Value for colum variables in MISSING of CTABLES */ .
DEFINE @scolemp  () INCLUDE !ENDDEFINE. /* Value for colum variables in EMPTY of CTABLES   */ .

/*----- B13. Software Information -----*/ .
DEFINE @sourcesys () 'SPSS (Win), Rel.13.0.1 (20 Nov2004)' !ENDDEFINE .
DEFINE @targetsys () 'SPSS (Win), Rel. 12.0.1'             !ENDDEFINE .
DEFINE @version   () 13                                    !ENDDEFINE .

/*----- B14. Other Standard Constants -----*/ .
* None.

RESTORE . /* Level 2 End: Standard Constants */ .

ECHO '/*========================================================*/' .
ECHO '/*             C Project Constants (Globals)              */' .
ECHO '/*========================================================*/' .
PRESERVE . /* Level 2 Begin: Project Constants */ .
SET PRINTBACK = ON .
SET ERRORS    = OFF .
SET WARNINGS  = OFF .

* Example: DEFINE brandlist () 10 11 12 13 14 15 !ENDDEFINE .

RESTORE . /* Level 2 End: Project Constants */ .

ECHO '/*========================================================*/' .
ECHO '/*                   D System Configuration               */' .
ECHO '/*========================================================*/' .
PRESERVE . /* Level 2 Begin: System Configuration */ .

/*----- D1. General Configuration -----*/ .
SET  COMPRESSION = YES    /* compression for temporary files (no depends on system)  */ .
SET BLANKS       = SYSMIS /* n or SYSMIS (".")                                       */ .
SET CACHE        = 10     /* number or 20 (default) of dataset changes before saving */ .
                          /* dataset to internal temporary file                      */ .

/*----- D2. Formats -----*/ .
SET FORMAT    = F8.2         /* standard format for numbers                    */ .
SET CCE       = '-.Euro ..'  /* standard format for european currency Euro     */ .
SET SCALEMIN  = 10           /* <x values: nominal, >x values: scale           */ .

SET TFIT      = BOTH         /* fitting of columns in tables (Labels, BOTH)    */ .
* SET TLOOK     @ftlook      /* template for tables (NONE, file name)          */ .
* SET CTEMPLATE @fctemp      /* template for graphs and plots (NONE, file name */ .

/*----- D3. Output -----*/ .
SET OVARS    = BOTH    /* object legend for variables (LABELS/names/both)      */ .
SET ONUMBERS = BOTH    /* object legend for values (values/LABELS/both)        */ .
SET TVARS    = BOTH    /* pivot table legend for variables (NAMES/labels/both) */ .
SET TNUMBERS = BOTH    /* pivot table legend for values (VALUES/labels/both)   */ .
SET LENGTH   = NONE    /* show complete logs in output  (length as integer)    */ .
SET OLANG    = ENGLISH /* language for output and OMS commands                 */ .

/*----- D4. Time Series Settings -----*/ .
SET EPOCH = 2000 . /* two digit years will be interpretated as 2000+ */ .

/*----- D5. Random Number Generation -----*/ .
SET SEED 123456789 . /* number or RANDOM */ .

ECHO '/*========================================================*/' .
ECHO '/*                       E Libraries                      */' .
ECHO '/*========================================================*/' .
ECHO '/*--------------------------------------------------------*/' .
ECHO '/*                       E1 Include                       */' .
ECHO '/*--------------------------------------------------------*/' .
PRESERVE . /* Level 3 Begin: Include */ .
SET PRINTBACK = ON .
SET ERRORS    = OFF .
SET WARNINGS  = OFF .

* INCLUDE FILE = 'Special Library' .

RESTORE . /* Level 3 End: Include */ .

ECHO '/*--------------------------------------------------------*/' .
ECHO '/*                        E2 Insert                       */' .
ECHO '/*--------------------------------------------------------*/' .
PRESERVE . /* Level 3 Begin: Insert */ .
SET PRINTBACK = ON .
SET ERRORS    = OFF .
SET WARNINGS  = OFF .

* INSERT FILE = 'Special Library' .

RESTORE . /* Level 3 End: Insert */ .

ECHO '/*--------------------------------------------------------*/' .
ECHO '/*                      E3 CONCERTO                       */' .
ECHO '/*--------------------------------------------------------*/' .
/*----- E3.1 Configure CONCERTO -----*/ .
DATA LIST FREE /lib (A64) macro (A64) macver (F2.0) use(F1.0) spssver (F2.0) .
/*-------1---------2---------3---------4---------5------6*/ .
BEGIN DATA
date.lib   num2date  1 1 12

def.lib    genxls    1 0 12

graph.lib  ovrview1  1 0 12

io.lib     getsav    1 0 12
io.lib     sav2mdb   1 0 12
io.lib     sav2sheet 1 0 12
io.lib     sav2xls   1 0 12
io.lib     savdat    2 0 12

mod.lib    cat2dic   1 0 12
mod.lib    varh2v    1 0 12

sample.lib none      1 0 12

tab.lib    basetab   1 0 12

utils.lib  caselab   3 0 12
utils.lib  echo      1 0 12
utils.lib  findstr   1 0 11
utils.lib  genvbo    1 0 12
utils.lib  nobase    2 0 12
utils.lib  novals    1 0 12
utils.lib  repchar   1 0 12
utils.lib  sortvar   3 0 12
utils.lib  vallist   2 0 12
utils.lib  varlst    1 0 12
END DATA .

/*----- E3.2 Initialize CONCERTO -----*/ .
PRESERVE . /* Level 3 Begin: CONCERTO */ .
SET PRINTBACK = ON .
SET ERRORS    = ON .
SET MPRINT    = ON .

INCLUDE FILE = @pCONCERTO + @fCONCERTO .

RESTORE . /* Level 3 End: CONCERTO */ .

ECHO '/*========================================================*/' .
ECHO '/*                        F Routines                      */' .
ECHO '/*========================================================*/' .
PRESERVE . /* Level 3 Begin: Routines */ .
SET PRINTBACK = ON .
SET ERRORS    = OFF .
SET WARNINGS  = OFF .

ECHO '/*--------------------------------------------------------*/' .
ECHO '/*                  F1 General Routines                   */' .
ECHO '/*--------------------------------------------------------*/' .
PRESERVE . /* Level 4 Begin: General Routines */ .
SET PRINTBACK = ON .
SET ERRORS    = OFF .
SET WARNINGS  = OFF .

/*--------------------------------------------------------*/ .
/* smp = Show Macro Parameter                             */ .
/*--------------------------------------------------------*/ .
/* Parameter:
/* 1        (unquoted)   = list of parameters handed over
/*                         to the macro
/*--------1---------2---------3---------4---------5-------*/ .
DEFINE @smp (!POS !CMD) .

!IF (!EVAL(@SIGDBG) = 1) !THEN
!LET !plist = 'Parameter: ' .
!LET !plist = !CONCAT('Parameter: ',!HEAD(!1)) .
!DO !element !IN (!TAIL(!1)) .
!LET !plist = !CONCAT(!plist,' ~ ',!element) .
!DOEND .
ECHO !QUOTE(!plist) .
!IFEND .

!ENDDEFINE .

/*--------------------------------------------------------*/ .
/* trace = Trace commands                                 */ .
/*--------------------------------------------------------*/ .
/* Parameter:
/* 1         (quoted)   = message to be printed in output
/*--------1---------2---------3---------4---------5-------*/ .
DEFINE @trace (!POS !CMD) .

!IF (!EVAL(@SIGTRC) = 1) !THEN .
ECHO !1 .
!IFEND .

!ENDDEFINE .


/* [ Name ] ----------------------------------------------*/.
/* syscall (Execute SYStem CALL command)
/*
/* [ Status ] --------------------------------------------*/.
/* Author   : Georg Maubach (MRSC)
/* Date     : 24-Jul-2005
/* Status   : released
/* Version  : 1
/* Release  : 1
/*
/* [ Description ] ---------------------------------------*/.
/* The macro executes the given system command.
/*
/* [ Parameter ] -----------------------------------------*/.
/* path     (quoted)   = path to the command to be executed
/* cmd      (quoted)   = command to be executed
/* params   (quoted)   = parameters to be handed over to the
/*                       command
/*
/* [ Result ] --------------------------------------------*/.
/* The command is executed and the control is handed back
/* to SPSS after 3 seconds.
/*
/* [ Operation ] -----------------------------------------*/.
/* There can be multiple parameter entries. They have all
/* to be quoted. If a blank shall appear in or between the
/* the parameters is has to be included in one of the para-
/* meters or given explicitly in quotes.
/*
/* [ Example ] -------------------------------------------*/.
/* Command to be executed:
/* c:\programme\Windows NT\Zubehör\wordpad.exe c:\workplace2\tmp\errmsg.txt
/* The macro call can be give as stated below:
/* @syscall path   = 'C:\Programme\Windows NT\Zubehör\' 
/*          cmd    = 'wordpad.exe'
/*          params = 'c:\workplace2\' 'tmp\' 'errmsg.txt'.
/* In this example 3 parameters are handed over.
/*
/* [ Release Notes ] -------------------------------------*/.
/* - SPSS responds with a warning message if a command
/*   is executed that will not be executed and terminated
/*   within the given execution time. If only an application
/*   is called and not terminated this warning might occur.
/*   Is has no effect on the syntax or the execution of the
/*   command.
/*--------1---------2---------3---------4---------5-------*/.

DEFINE @syscall (path    !TOKENS(1)
                /cmd     !TOKENS(1)
                /params  !CMDEND) .

!LET !command = !CONCAT('"',!UNQUOTE(!path),!UNQUOTE(!cmd),'" ').

!DO !element !IN (!EVAL(!params)) .
!LET !command = !CONCAT(!UNQUOTE(!command),!UNQUOTE(!element)).
!DOEND .

HOST COMMAND = !CONCAT("['",!command,"']") TIMELIMIT = 3 .

!ENDDEFINE .

/* [ Name ] ----------------------------------------------*/.
/* SyntaxRunTime (Print SYNTAXRUNTIME in Output)
/*
/* [ Status ] --------------------------------------------*/.
/* Author   : Raynald Levesque
/* Date     : 16-Nov-2005
/* Status   : released
/* Version  : 1
/* Release  : 1
/*
/* [ Description ] ---------------------------------------*/.
/* The macro prints the current system date and time.
/*
/* [ Parameter ] -----------------------------------------*/.
/* None.
/*
/* [ Result ] --------------------------------------------*/.
/* The current system date and time is printed in the out-
/* put to show when the syntax was last run.
/*
/* [ Operation ] -----------------------------------------*/.
/* No comments.
/*
/* [ Example ] -------------------------------------------*/.
/* None.
/*
/* [ Release Notes ] -------------------------------------*/.
/* None.
/*--------1---------2---------3---------4---------5-------*/.

DEFINE @SyntaxRunTime ().

PRESERVE.
SET PRINTBACK=OFF MPRINT=OFF.

ECHO ''.
ECHO ''.
ECHO 'Syntax Run Time:'.

DO IF $CASENUM=1. 
- PRINT /$TIME (DATETIME). 
END IF. 
EXECUTE.

ECHO ''.
ECHO ''.

RESTORE.

!ENDDEFINE.

RESTORE . /* Level 4 End: General Routines */ .


ECHO '/*--------------------------------------------------------*/' .
ECHO '/*                      F2 Sub Routines                   */' .
ECHO '/*--------------------------------------------------------*/' .
PRESERVE . /* Level 4 Begin: Sub Routines */ .
SET PRINTBACK = ON .
SET ERRORS    = OFF .
SET WARNINGS  = OFF .

/*----------------------------*/ .
DEFINE @sub1 (param1 !TOKENS(1)
             /param2 !TOKENS(1)) .
/*----------------------------*/ .
@trace '*----- [ Begin @sub1 ] -----*' .
@smp !param1 !param2 .

* Commands .

* Data Transformation Check .
!IF (!eval(@SIGCHK) = 1) !THEN .
echo '*-[Begin Data Transformation Check]-*' .
* Data Checking Commands .
echo '*-[End Data Transformation Check]-*' .
!IFEND .

* Commands .

@trace '*----- [ End @sub1 ] -----*' .
!ENDDEFINE .

RESTORE . /* Level 4 End: Sub Routines */ .


ECHO '/*--------------------------------------------------------*/' .
ECHO '/*                     F3 Main Routines                   */' .
ECHO '/*--------------------------------------------------------*/' .
PRESERVE . /* Level 4 Begin: Main Routines */ .
SET PRINTBACK = ON .
SET ERRORS    = OFF .
SET WARNINGS  = OFF .

/*--------------------------------------------------------*/ .
/* atbegin = AT BEGIN of Main Program                     */ .
/*--------------------------------------------------------*/ .
/* Parameter: None
/*--------1---------2---------3---------4---------5-------*/ .

DEFINE @atbegin () .

@trace '----- [ Begin @atbegin ] -----' .

* SPSS Configuration.
PRESERVE . /* Begin */ .

* Job Protocol .
* Note: OMS is only active when a working file has been defined .
!IF (!EVAL(@version)>=12)
     !THEN
          OMS
             /SELECT LOGS TEXT WARNINGS
             /DESTINATION FORMAT = TEXT
                          OUTFILE = !QUOTE(!CONCAT(!UNQUOTE(!EVAL(@pprotocol)), !UNQUOTE(!EVAL(@fprotocol))))
                          VIEWER = YES
             /TAG = 'Runtime_Protocol'
!IFEND .

* OMS Log .
!IF (!EVAL(@version)>=12)
     !THEN
           OMSLOG FILE = @pomslog + @fomslog
!IFEND .

* Reduce number of cases for debugging.
!IF (!EVAL(@SIGNOC) > 0)
     !THEN
           N OF CASES !EVAL(@SIGNOC)
!IFEND .

@trace '----- [ End @atbegin ] -----' .
!ENDDEFINE .


/*--------------------------------------------------------*/ .
/* datadef = DATA DEFinition                              */ .
/*--------------------------------------------------------*/ .
/* Parameter: None
/*--------1---------2---------3---------4---------5-------*/ .
DEFINE datadef () .

@trace '===== [ Begin @datadef ] =====' .

@trace '*----- Datadef 1: Data Conversion -----*' .

@trace '*----- Datadef 2: Data Set Preparation -----*' .

@trace '*----- Datadef 3: Load and Merge Data Sets -----*' .
NEW FILE .
GET
    FILE = !QUOTE(!CONCAT(!UNQUOTE(!EVAL(@pdatsav)),!UNQUOTE(!EVAL(@fdatsi1)))) .
CACHE .
EXECUTE .

@trace '*----- Datadef 4: New Variables -----*' .

@trace '*----- Datadef 5: Meta Data Definition -----*' .
@trace '*----- Datadef 5.1: Variable Labels -----*' .
@trace '*----- Datadef 5.2: Value Labels -----*' .
@trace '*----- Datadef 5.3: Variable Level -----*' .
@trace '*----- Datadef 5.4: Formats -----*' .
@trace '*----- Datadef 5.5: Missing Values -----*' .
@trace '*----- Datadef 5.6: User Defined Data Properties -----*' .

@trace '*----- Datadef 6: Multiple Response Sets -----*' .

@trace '*----- Datadef 6: Quality Assurance -----*' .

@trace '*----- Datadef 7: Data Set Information -----*' .

@trace '*----- Datadef 8: Save Base Data Set -----*' .

@trace '===== [ End @datadef ] =====' .

!ENDDEFINE .


/*--------------------------------------------------------*/ .
/* datamod = DATA MODification                            */ .
/*--------------------------------------------------------*/ .
/* Parameter: None
/*--------1---------2---------3---------4---------5-------*/ .
DEFINE @datamod ().
@trace '===== [ Begin @datamod ] =====' .

@trace '*----- Datamod 1: Data Cleaning -----*' .

@trace '*----- Datamod 2: Classification in Categories -----*' .

@trace '*----- Datamod 3: Data Cut Definition -----*' .

@trace '*----- Datamod 4: Determination of Valid Cases -----*' .

@trace '*----- Datamod 5: Quality Assurance -----*' .

@trace '*----- Datamod 6: Save Base Data Set -----*' .
FILE LABEL ##### HIER WEITER ##### .

@trace '===== [ End @datamod ] =====' .
!ENDDEFINE .

/*--------------------------------------------------------*/ .
/* construct = Prepare Data Set for Analysis              */ .
/*--------------------------------------------------------*/ .
/* Parameter: None.
/*--------1---------2---------3---------4---------5-------*/ .
DEFINE @construct ().
@trace '===== [ Begin @construct ] =====' .

/* Statistical procedures that define data in data set. /* .

@trace '===== [ End @construct ] =====' .
!ENDDEFINE .

/*--------------------------------------------------------*/ .
/* analysis = Analysis of Data Set                        */ .
/*--------------------------------------------------------*/ .
/* Parameter: None.
/*--------1---------2---------3---------4---------5-------*/ .
DEFINE @analysis ().
@trace '===== [ Begin @analysis ] =====' .

@trace '*----- Procedur 1: Exploration -----*' .

@trace '*----- Procedur 2: Data Selection -----*' .

@trace '*----- Procedur 3: Weighting -----*' .

@trace '*----- Procedur 4: Data Cut -----*' .

@trace '*----- Procedur 5: Descriptive Analysis -----*' .

@trace '*----- Procedur 6: Multivariate Analysis -----*' .

@trace '===== [ End @analysis ] =====' .
!ENDDEFINE .

/*--------------------------------------------------------*/ .
/* deconstruct = Finish Analysis                          */ .
/*--------------------------------------------------------*/ .
/* Parameter: None.
/*--------1---------2---------3---------4---------5-------*/ .
DEFINE @deconstruct ().
@trace '===== [ Begin @deconstruct ] =====' .

/* Removing all variables defined by @construct */ .

@trace '===== [ End @deconstruct ] =====' .
!ENDDEFINE .

/*--------------------------------------------------------*/ .
/* output = OUTPUT processing                             */ .
/*--------------------------------------------------------*/ .
/* Parameter: None
/*--------1---------2---------3---------4---------5-------*/ .
DEFINE @output ()

@trace '*===== [ Begin @output ] =====*' .

* commands .

@trace '*===== [ End @output ] =====*' .

!ENDDEFINE .

/*--------------------------------------------------------*/ .
/* atend = AT END of program                              */ .
/*--------------------------------------------------------*/ .
/* Parameter: None
/*--------1---------2---------3---------4---------5-------*/ .
DEFINE @atend () .
@trace '===== [ Begin @atend ] =====' .

* SPSS Configuration.
RESTORE . /* End */ .

* Date and Time of Syntax Run.
@SyntaxRunTime.

* Job Journal .
!IF (!EVAL(@version) >= 12) !THEN OMSEND TAG = ['Runtime_Protocol'] !IFEND .

* OMS Log .
!IF (!EVAL(@version) >= 12) !THEN OMSEND LOG !IFEND .

@trace '===== [ End @atend ] =====' .
!ENDDEFINE .

/*----------------------------------------------------------*/ .

/*--------------------------------------------------------*/ .
/* main = MAIN program                                    */ .
/*--------------------------------------------------------*/ .
/* Parameter: None
/*--------1---------2---------3---------4---------5-------*/ .
DEFINE @main () .
@trace '===== [ Begin @main ] =====' .

@atbegin .

@datadef .

@datamod .

* Filter Definition overall * .
!IF ('OVERALL' = !QUOTE!UPCASE(!EVAL(!split))))
COMPUTE filsplit = 1 .
EXECUTE .
!IFEND .

* Filter Definition split 1 * .
!IF ('SPLITNAME1' = !QUOTE!UPCASE(!EVAL(!split))))
DO IF (condition to define split 1) .
- COMPUTE filsplit = 1 .
ELSE .
- COMPUTE filsplit = 0 .
END IF .
!IFEND .

* Filter Definition split 2 * .
!IF ('SPLITNAME2' = !QUOTE!UPCASE(!EVAL(!split))))
DO IF (condition to define split 1) .
- COMPUTE filsplit = 1 .
ELSE .
- COMPUTE filsplit = 0 .
END IF .
!IFEND .

* Switch on filter .
FILTER BY filsplit .

* Switch on weight * .
WEIGHT BY weight .

@construct .

@analysis .

/* @deconstruct . */ /* comment out @deconstruct if variables generated */
                     /* by @construct are need for further analysis     */ .

WEIGHT OFF .
FILTER OFF .

@atend .

@trace '===== [ End @main ] =====' .
!ENDDEFINE .

RESTORE . /* Level 4 End: Main Routines */ .

RESTORE . /* Level 3 End: Routines */ .

OMSEND
    TAG = 'Definition_Protocol' .

ECHO '/*========================================================*/' .
ECHO '/*                      G Main Program                    */' .
ECHO '/*========================================================*/' .

TITLE '*---------------------------------------------------------*' .
TITLE '*      [ Main Program Template WITH simple syntax ]       *' .
TITLE '*      [             Asterix Structure            ]       *' .
TITLE '*      [          For Small Ad-hoc Projects       ]       *' .
TITLE '*---------------------------------------------------------*' .
TITLE '*===== [ At Begin ] =====*' .
TITLE '*----- [ Job Protocol ] -----*'.
OMS
 /SELECT LOGS TEXT WARNINGS
 /DESTINATION
  FORMAT  = TEXT
  OUTFILE = @perrmsg + @ferrmsg VIEWER = YES
 /TAG     = 'Protocol'.

OMSLOG FILE = @pomslog + @fomslog.

TITLE '*===== [ Datensatz aufbauen ] =====*' .
TITLE '*----- [ File Conversion ] -----*'.
* None, due to no coding and analysing of coded open-ended questions.


TITLE '*----- [ Load Data Set ] -----*'.
NEW FILE .
GET FILE = @pdatsav + @fdats1i.
EXECUTE.


TITLE '*----- [ Merge Data Sets / Tables ] -----*'.
MATCH FILES FILE=*
   /TABLE = @pdatxls + @fdatxi1 /BY caseid.
EXECUTE.

MATCH FILES FILE=*
   /TABLE = @pdatxls + @fdatxi1 /BY caseid.
EXECUTE.


TITLE '*----- [ Rename Variables ] -----*'.
REN VAR (lfdn = respondent). 
REN VAR (q1 = q01).	
REN VAR (q2i1 = q02.01).	
EXECUTE.


TITLE '*----- [ Variable Format Transformation ] -----*'.
* Change the format of the variables, e.g. from string
* to number.
COMPUTE newvar = NUMBER(oldvar,F8.0).
EXECUTE.


TITLE '*----- [ Create New Variables ] -----*'.
* Here all project specific new variables should be 
* defined, e.g. splits, weights and data cuts as a
* cut of data within a table.


TITLE '*- Fallnummern -*' .
COMPUTE sequence   = $casenum.
COMPUTE caseid     = lfdn .
COMPUTE respondent = lfdn.

TITLE '*- Datensatzkennzeichnung *-' .
STRING  country (A2) .
COMPUTE country    = @countryID .
COMPUTE year       = @year .
COMPUTE wave       = @wave .

TITLE '*- Standardvariablen -*' .
COMPUTE total      = 0 . /* Gesamtvariable */ .

COMPUTE valid1     = 0 . /* tester */ .
COMPUTE valid2     = 0 . /* respondents not responding within field period */ .
COMPUTE valid3     = 0 . /* respondent finishing the questionnaire */ .
COMPUTE valid4     = 0 . /* respondent answering the minimum amount of questions */ .
COMPUTE valid5     = 0 . /* respondent is customer not employee */ .
COMPUTE valid6     = 0 . /* respondent is not lurker, e.g. answering the questionnary more than once */ .
COMPUTE valid      = 0 . /* valid case, combined all other circumstances from valid1 to valid6 */ .

COMPUTE split      = 0 . /* general filter for splits (as a temporary selection of cases */ .

COMPUTE weight1    = 1 . /* first weight component variable  */ .
COMPUTE weight2    = 1 . /* second weight component variable */ .
COMPUTE weight3    = 1 . /* third weight component variable  */ .
COMPUTE weight     = 1 . /* overall weight variable          */ .

EXECUTE .



TITLE '*----- [ Keep only numeric variables ] -----*'.
* Get variable type (numeric/string).
@vartype .



TITLE '*----- [ Delete not needed variables ] -----*'.
MATCH FILES FILE=*
 /DROP @delvars.
EXECUTE.



TITLE '*----- [ Sort variables ] -----*'.
* Keep only numeric variables and sort them.
@sortvar varlst=@numvars.



TITLE '*----- [ Merge Variables ] -----*'.
* q15.x into q16.x.
IF (MISSING (q16.01) = 1) q16.01 = q15.01.	
IF (MISSING (q16.02) = 1) q16.02 = q15.02.	
IF (MISSING (q16.04) = 1) q16.04 = q15.03.	
EXECUTE.



TITLE '*----- [ Multiple Response Sets ] -----*'.
MRSETS
  /MDGROUP
   NAME=$q43
   LABEL='Problem that caused last complaint'
   VARIABLES=q43.01 TO q43.09
   VALUE=1
  /DISPLAY NAME=[$q43].
EXECUTE.



TITLE '*===== [ Variableneigenschaften vergeben ] =====*' .
TITLE '*----- [ Variable Labels Definition ] -----*'.
*              0---------1---------2---------3---------4---------5---------!.
TITLE '*- Fragebogenvariablen -*' .
VARIABLE LABEL q01    '01 Language Selection'.
VARIABLE LABEL q02.01 '02.01 Information on: Ground freight'.
VARIABLE LABEL q02.02 '02.02 Information on: Air Freight'.
VARIABLE LABEL q02.03 '02.03 Information on: Ocean Freight'.
EXECUTE.

TITLE '*- Fallnummer -*' .
VARIABLE LABEL sequence 'Case Sequence'.
VARIABLE LABEL caseid 'Case ID' .
VARIABLE LABEL respondent 'Respondent ID'.

TITLE '*- Datensatzkennzeichnung -*' .
VARIABLE LABEL country 'Country ID' .
VARIABLE LABEL year 'Year of Survey'.
VARIABLE LABEL wave 'Wave ID' .

TITLE '*- Standardvariablen -*' .
VARIABLE LABEL total 'total'.

VARIABLE LABEL valid1 'Tester' .
VARIABLE LABEL valid2 'Out of field period' .
VARIABLE LABEL valid3 'Finisher' .
VARIABLE LABEL valid4 'Minimum of questions answered' .
VARIABLE LABEL valid5 'Customer' .
VARIABEL LABEL valid6 'Acceptable respondent (no lurker)' .
VARIABLE LABEL valid  'Valid Case'.

VARIABLE LABEL split 'Filter for split' .

VARIABLE LABEL weight1 'Weight 1' .
VARIABLE LABEL weight2 'Weight 2' .
VARIABLE LABEL weight3 'Weight 3' .
VARIABLE LABEL weight  'Overall Weight' .

EXECUTE .

TITLE '*----- [ Value Labels] -----*'.
VALUE LABEL q01
        1  'English'
        2  'German'
        3  'French'
        4  'Portuguese'
        5  'Italian'
        6  'Spanish'
        7  'Durch'
        8  'Mandarin'
        9  'Cantonese'
        10 'Japanese'
        11 'Simple Chinese'.

EXECUTE.


TITLE '*----- [ Variable Level ] -----*'.
VARIABLE LEVEL ALL (SCALE).
EXECUTE.



TITLE '*----- [ Formats ] -----*'.
FORMATS q01    TO q64.62 (F8.0).
FORMATS r17.01 TO r45.07 (F8.0).
FORMATS gcs mnc smc sporadic (F1.0).
EXECUTE.



TITLE '*----- [ Missing Values ] -----*'.
MISSING VALUE q01    TO q02.03 (-999 THRU    0).
MISSING VALUE q03.01 TO q03.02 (-999 THRU -997).
MISSING VALUE q03.03 TO q11    (-999 THRU    0).
MISSING VALUE q12.01 TO q12.15 (-999 THRU    0, 8).
MISSING VALUE q13.01 TO q14.01 (-999 THRU    0).
MISSING VALUE q15.01 TO q16.45 (-999 THRU -997).
MISSING VALUE q17.01 TO q42    (-999 THRU    0).
MISSING VALUE q43.01 TO q43.09 (-999 THRU -997).
MISSING VALUE q44    TO q46    (-999 THRU    0).
MISSING VALUE q47.01 TO q53.02 (-999 THRU -997).
MISSING VALUE q57.01 TO q58.01 (-999 THRU    0).
MISSING VALUE q61.01 TO q64.62 (-999 THRU -997).
EXECUTE.



TITLE '*===== [ Preparation ] =====*' .
TITLE '*----- [ Cleaning ] -----*'.
* q03.
* wenn shipments angegeben sind, dann dk/na auf NULL setzen.
IF (q03.01 > 0 & q03.03 = 1) q03.03 = 0.
IF (q03.02 > 0 & q03.03 = 1) q03.03 = 0.
* wenn keine shipments angegeben sind, dann dk/na.
IF (q03.01 = -99) q03.01       = -998.
IF (q03.02 = -99) q03.02       = -998.
* wenn Typwandlung (String -> Number) fehlgeschlagen, SYSMIS in USERMIS umwandeln.
IF (SYSMIS(q03.01) = 1) q03.01 = -998.
IF (SYSMIS(q03.02) = 1) q03.02 = -998.
EXECUTE.



TITLE '*----- [ Recoding ] -----*'.
/* If in q07.xx only ONE provider is used
/* q15/q16 is not asked.
/* If only one provider is used q16 is recoded
/* according to q07.xx.
/* The only used provider is added in q16. */ .
COUNT NoOfUsedProviders = q07.01 TO q07.15 (1).
IF (NoOfUsedProviders = 1 & q07.01 = 1) q16.01 = 1.
IF (NoOfUsedProviders = 1 & q07.02 = 1) q16.04 = 1.
IF (NoOfUsedProviders = 1 & q07.03 = 1) q16.07 = 1.
IF (NoOfUsedProviders = 1 & q07.04 = 1) q16.10 = 1.
IF (NoOfUsedProviders = 1 & q07.05 = 1) q16.13 = 1.
IF (NoOfUsedProviders = 1 & q07.06 = 1) q16.16 = 1.
IF (NoOfUsedProviders = 1 & q07.07 = 1) q16.19 = 1.
IF (NoOfUsedProviders = 1 & q07.08 = 1) q16.22 = 1.
IF (NoOfUsedProviders = 1 & q07.09 = 1) q16.25 = 1.
IF (NoOfUsedProviders = 1 & q07.10 = 1) q16.28 = 1.
IF (NoOfUsedProviders = 1 & q07.11 = 1) q16.31 = 1.
IF (NoOfUsedProviders = 1 & q07.12 = 1) q16.34 = 1.
IF (NoOfUsedProviders = 1 & q07.13 = 1) q16.37 = 1.
IF (NoOfUsedProviders = 1 & q07.14 = 1) q16.40 = 1.
IF (NoOfUsedProviders = 1 & q07.15 = 1) q16.43 = 1.
EXECUTE.



TITLE '*----- [ Scale Transformation (Spreading of Scales) ] -----*'.
DO REPEAT #1 = q17.01 TO q17.15
         /#2 = r17.01 TO r17.15.
- COMPUTE #2 = (#1 - 1) * 100 / 9.
- IF (SYSMIS(#2)=1) #2 = -997.
- MISSING VALUE #2 (-999 THRU -997).
END REPEAT.



TITLE '*----- [ Categories ] -----*'.
* Create categories of scale variables or
* merge already existing categories.



TITLE '*----- [ Compute values for all new variables ] -----*' .
* Compute and recode all values for all new variables which
* shall be used within data selection, filtering,
* weighting and analysis .



TITLE '*----- [ Quality Assurance ] -----*'.
FREQ q01 TO q09.


TITLE '*===== [ Analysis ] =====*' .
TITLE '*----- [ Response Statistic ] -----*' .
* All respondents .
FREQUENCIES total .

* Tester .
DO IF (valid1 = 1) .
- COMPUTE valid = 1 .
ELSE .
- COMPUTE valid = 0 .
END IF .
FREQUENCIES total .

* Out of field period .
DO IF (valid1 = 1 & valid2 = 1) .
- COMPUTE valid = 1 .
ELSE .
- COMPUTE valid = 0 .
END IF .
FREQUENCIES total .

* Finisher .
DO IF (valid1 = 1 & valid2 = 1 & valid3 = 1) .
- COMPUTE valid = 1 .
ELSE .
- COMPUTE valid = 0 .
END IF .
FREQUENCIES total .

* Minimum questions answered .
DO IF (valid1 = 1 & valid2 = 1 & valid3 = 1 & valid4 = 1) .
- COMPUTE valid = 1 .
ELSE .
- COMPUTE valid = 0 .
END IF .
FREQUENCIES total .

* Customers .
DO IF (valid1 = 1 & valid2 = 1 & valid3 = 1 & valid4 = 1 & valid5 = 1) .
- COMPUTE valid = 1 .
ELSE .
- COMPUTE valid = 0 .
END IF .
FREQUENCIES total .

* Acceptable respondent (no lurker) .
DO IF (valid1 = 1 & valid2 = 1 & valid3 = 1 & valid4 = 1 & valid5 = 1 & valid6 = 1) .
- COMPUTE valid = 1 .
ELSE .
- COMPUTE valid = 0 .
END IF .
FREQUENCIES total .



TITLE '*----- [ Select relevant cases for survey (Filter) ] -----*'.
* Cases which are cleaned by Globalpark OPST cleaning method.
* will not be excluded from analysis due to a loss in cases.
* The cleaning functionality of Globalpark OPST is used which
* results in the LAST RESPONSE cleaning method.
* Therefore the select command is commented out which results 
* in the LAST RESPONSE cleaning method.
* SELECT IF (cleaned = 1 | cleaned = 2). /* only uncleaned cases are selected */ .
SELECT IF (dispcode = 31 | dispcode = 32). /* select only ended or ended with interruption interviews */ .



TITLE '*----- [ Select cases for analysis (Split) ] -----*'.
DO IF (valid = 1 & split = 1) .
- COMPUTE filter = 1 .
ELSE .
- COMPUTE filter = 0 .
END IF .
FILTER BY filter .



TITLE '*----- [ Set Weight ] -----*'.
WEIGHT BY weight .



TITLE '*----- [ Analysis ] -----*'.
* All statistical procedures, e.g.
* CTABLES, CORRELATION, T-TEST, 
* ONEWAY, etc.




TITLE '*----- [ Save base data set ] -----*'.
FILE LABEL @filelab.

SAVE OUTFILE = @pdatsav + @fdats1o /COMPRESSED.



TITLE '*===== [ At End ] =====*' .
TITLE '*----- [ Syntax Run Time ] -----*'.
PRESERVE.
SET PRINTBACK=OFF MPRINT=OFF.

ECHO ''.
ECHO ''.

ECHO 'Syntax Run Time'.

DO IF $CASENUM=1. 
- PRINT /$TIME (DATETIME). 
END IF. 
EXECUTE.

RESTORE.


TITLE '*----- [ Job Protocol ] -----*'.
OMSEND TAG = ['Protocol'].
OMSEND LOG.

@syscall path='C:\Programme\Windows NT\Zubehör\' cmd='wordpad.exe' params='c:\workplace2\' 'tmp\' 'protocol.txt'.


TITLE '*----- [ Restore Program Configuration ] -----*'.
RESTORE . /* Level 2 End: System Configuration */ .
RESTORE . /* Level 1 End: Processor Controls */ .

TITLE '*---------------------------------------------------------*' .
TITLE '*      [ Main Program Template WITH include files ]       *' .
TITLE '*      [              Obelix Structure            ]       *' .
TITLE '*      [             For Large Projects           ]       *' .
TITLE '*---------------------------------------------------------*' .

TITLE '*===== [ At Begin ] =====*' .
TITLE '*----- [ Job Protocol ] -----*'.
OMS
 /SELECT LOGS TEXT WARNINGS
 /DESTINATION
  FORMAT  = TEXT
  OUTFILE = @perrmsg + @ferrmsg VIEWER = YES
 /TAG     = 'Protocol'.

OMSLOG FILE = @pomslog + @fomslog.

TITLE '*===== [ Datensatz aufbauen ] =====*' .
INCLUDE FILE = 'Create_dataset.sps' .

TITLE '*===== [ Labeling ] =====*' .
INCLUDE FILE = 'Labeling.sps' .

TITLE '*===== [ Cleaning ] =====*' .
INCLUDE FILE = 'cleaning.sps' .

TITLE '*===== [ Preparation ] =====*' .
INCLUDE FILE = 'Preparation.sps' .

TITLE '*===== [ Tables ] =====*' .
INCLUDE FILE = 'Tables.sps' .

TITLE '*===== [ Analysis ] =====*' .
INCLUDE FILE = 'Analysis.sps' .

TITLE '*===== [ At End ] =====*' .
TITLE '*----- [ Syntax Run Time ] -----*'.
PRESERVE.
SET PRINTBACK=OFF MPRINT=OFF.

ECHO ''.
ECHO ''.

ECHO 'Syntax Run Time'.

DO IF $CASENUM=1. 
- PRINT /$TIME (DATETIME). 
END IF. 
EXECUTE.

RESTORE.


TITLE '*----- [ Job Protocol ] -----*'.
OMSEND TAG = ['Protocol'].
OMSEND LOG.

@syscall path='C:\Programme\Windows NT\Zubehör\' cmd='wordpad.exe' params='c:\workplace2\' 'tmp\' 'protocol.txt'.


TITLE '*----- [ Restore Program Configuration ] -----*'.
RESTORE . /* Level 2 End: System Configuration */ .
RESTORE . /* Level 1 End: Processor Controls */ .


TITLE '*---------------------------------------------------------*' .
TITLE '*          [ Main Program Template WITH macros ]          *' .
TITLE '*          [          Miraculix Structure      ]          *' .
TITLE '*          [   For Large and Complex Projects  ]          *' .
TITLE '*---------------------------------------------------------*' .
TITLE '*---------------------------------------------------------*' .
TITLE '*                         [ Overall ]                     *' .
TITLE '*---------------------------------------------------------*' .
/* Alternative 1: Main Routines einzeln */ .
@atbegin .

@datadef .

@datamod .

* Filter Definition * .
COMPUTE filsplit = 1 .
FILTER BY filsplit .

* Switch on weight * .
WEIGHT BY weight .

@construct .

@analysis .

/* @deconstruct . */ /* comment out @deconstruct if variables generated */
                     /* by @construct are need for further analysis     */ .

WEIGHT OFF .
FILTER OFF .

@atend .

/* Alternative 2: Main Routines durch @main() /*.
@main split=overall.

TITLE '*---------------------------------------------------------*' .
TITLE '*                         [ Split 1 ]                     *' .
TITLE '*---------------------------------------------------------*' .
/* Alternative 1: Main Routines einzeln */ .
@atbegin .

@datadef .

@datamod .

* Filter Definition * .
DO IF (condition to define filter for split).
- COMPUTE filsplit = 1 .
ELSE .
- COMPUTE filsplit = 0 . /* delete old values of data set */ .
END IF .

* Switch filter on .
FILTER BY filsplit .

* Switch on weight * .
WEIGHT BY weight .

@construct .

@analysis .

/* @deconstruct . */ /* comment out @deconstruct if variables generated */
                     /* by @construct are need for further analysis     */ .

WEIGHT OFF .
FILTER OFF .

@atend .

/* Alternative 2: Main Routines durch @main() /*.
@main split=splitname1.

ECHO '*---------------------------------------------------------*' .
ECHO '*                        [ FINISH ]                       *' .
ECHO '*---------------------------------------------------------*' .

* EOF * .

