       01  WC-DEFAULTS.
           05  WS-STATUS.
                10  WS-STATUS1          PIC  X(001).
                10  WS-STATUS2          PIC  X(001).
                10  WS-STATUS2-BIN      REDEFINES
                    WS-STATUS2          PIC  9(002)         COMP-X.
            05  FILLER REDEFINES        WS-STATUS.
                10  WS-STATUS-BIN       PIC  9(004)         COMP. 
            05  FILLER REDEFINES        WS-STATUS.
                10  WS-STATUS-NUM       PIC  9(002).

           05  WS-FUNCAO                PIC  9(004).
               88  WS-PF1               VALUE 1001.
               88  WS-PF2               VALUE 1002.
               88  WS-PF3               VALUE 1003.
               88  WS-PF4               VALUE 1004.
               88  WS-PF5               VALUE 1005.
               88  WS-PF6               VALUE 1006.
               88  WS-PF7               VALUE 1007.
               88  WS-PF8               VALUE 1008.
               88  WS-PF9               VALUE 1009.
               88  WS-PF10              VALUE 1010.
               88  WS-PF11              VALUE 1011.
               88  WS-PF12              VALUE 1012.

           05  WS-EXIST                PIC  X(001).
           05  WS-CONFIRM              PIC  X(001).
           05  WS-FLAG-ERRO            PIC  X(001)         VALUE SPACES.
           05  WS-DATA-PATH            PIC  X(100)         VALUE SPACES.
           05  WS-ERRO-IO              PIC  X(001).
           05  WS-BLANK-LINE           PIC  X(080)         VALUE SPACES.

      *>---------------------------------------------------------------*
      *> Data Sistema                                                  *
      *>---------------------------------------------------------------*
           05  WS-DATA-HORA-SYS         PIC  X(021)        VALUE SPACES.
           05  FILLER REDEFINES         WS-DATA-HORA-SYS.
               10  WS-DATA-SYS          PIC  9(008).
               10  FILLER REDEFINES     WS-DATA-SYS.
                   15  WS-ANO-SYS       PIC  9(004).
                   15  WS-MES-SYS       PIC  9(002).
                   15  WS-DIA-SYS       PIC  9(002).
               10  WS-HORA-SYS          PIC  9(006).
               10  FILLER REDEFINES     WS-HORA-SYS.
                   15  WS-HORA-MIN-SYS  PIC  9(004).
                   15  FILLER REDEFINES WS-HORA-MIN-SYS.
                       20  WS-HOR-SYS   PIC  9(002).
                       20  WS-MIN-SYS   PIC  9(002).
                   15  WS-SEG-SYS       PIC  9(002).
               10  WS-CEN-SYS           PIC  9(002).
               10  WS-TZD-SYS           PIC  X(005).
               
      *>------------------ COMUNICATION JOB'S AREA -------------------<*
           05  WC-JOBERR.
               10  WC-ARQUIVO           PIC  X(006)        VALUE SPACES.
               10  WC-ERRO              PIC  9(004)        VALUE ZEROS.
               10  WC-ERR-FLAG-WEB      PIC  X(001)        VALUE SPACES.
               10  WC-ERR-ARQUIVO       PIC  X(010)        VALUE SPACES.
               10  WC-ERR-PROGRAMA      PIC  X(010)        VALUE SPACES.
               10  WC-ERR-STATUS        PIC  X(002)        VALUE SPACES.
               10  WC-ERR-PARAMETRO     PIC  X(200)        VALUE SPACES.
               10  WC-ERR-MENSAGEM      PIC  X(080)        VALUE SPACES.
      
      *>------------------------- JSON RETURN -------------------------*
           05  WS-JSON-RETURN          PIC  X(1000)        VALUE SPACES.
           05  WS-JSON-OBJECT          USAGE POINTER.
           05  WS-JSON-STRING          USAGE POINTER.
           