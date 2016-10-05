
; *****************************************************************************
; *                                                                           *
; * PICAXE Blockly Connect Program                                      008   *
; *                                                                           *
; *****************************************************************************
; *                                                                           *
; * Author  : Revolution Education Ltd                                        *
; *                                                                           *
; * Email   : support@picaxe.com                                              *
; * Website : www.picaxe.com                                                  *
; * Forum   : www.picaxeforum.co.uk                                           *
; *                                                                           *
; *****************************************************************************
; *                                                                           *
; *                                                                           *
; *                                                                           *
; *                                                                           *
; *                                                                           *
; *                                                                           *
; *                                                                           *
; *                                                                           *
; *****************************************************************************
; *                                                                           *
; * Version History                                                           *
; *                                                                           *
; *     0.X     JB  Beta development versions                                 *
; *                                                                           *
; *     1.0     JB  First public release                                      *
; *                                                                           *
; *****************************************************************************

  Symbol VERSION_MAJOR = 0
  Symbol VERSION_MINOR = 08

; *****************************************************************************
; *                                                                           *
; * Check this code can be compiled for the PICAXE selected                   *
; *                                                                           *
; *****************************************************************************
; *                                                                           *
; * Currently the code is only written for M2 and X2 chips. If more are added *
; * this section and other parts of the code must be updated to enable full   *
; * support for those chips.                                                  *
; *                                                                           *
; *****************************************************************************

  #IfDef _08M2
    #Define _isM2
    #Define _isOK
  #EndIf

  #IfDef _14M2
    #Define _isM2
    #Define _isOK
  #EndIf

  #IfDef _18M2
    #Define _isM2
    #Define _isOK
  #EndIf

  #IfDef _20M2
    #Define _isM2
    #Define _isOK
  #EndIf

  #IfDef _20X2
    #Define _isX2
    #Define _isOK
  #EndIf

  #IfDef _28X2
    #Define _isX2
    #Define _isOK
  #EndIf

  #IfDef _40X2
    #Define _isX2
    #Define _isOK
  #EndIf

  #IfDef _isOK
    #Undefine _isOK
  #Else
    #Error This code is not suitable for currently selected PICAXE type
  #EndIf

; *****************************************************************************
; *                                                                           *
; * Specify baud rate of SERTXD and SERRXD used                               *
; *                                                                           *
; *****************************************************************************
; *                                                                           *
; * This is an informative entry but does ensure the Programming Editor       *
; * Terminal switches to the correct baud rate if the code is explicitly      *
; * downloaded for testing purposes rather than automatically downloaded by   *
; * Programming Editor or Scraxe.                                             *
; *                                                                           *
; *****************************************************************************

  #Terminal 19200

; *****************************************************************************
; *                                                                           *
; * Define the operational speed of this program                              *
; *                                                                           *
; *****************************************************************************
; *                                                                           *
; * We want to run quite fast to make this program as responsive as possible  *
; * and to keep SERTXD and SERRXD baud rates high to minimise transmission    *
; * times.                                                                    *
; *                                                                           *
; * Baud rates of 19200 are reasonbly fast and supported by a physical serial *
; * cables, AXE027 and many PICAXE chips.                                     *
; *                                                                           *
; * The FREQ setting is the speed required to run the chip at to obtain the   *
; * desired baud rate, FREQ_DEFAULT is the normal operating speed of the chip *
; * and FREQ_MULTIPLIER is how many times faster the chip is running over its *
; * default speed. This is used to adjust time constants when running at the  *
; * operational speed.                                                        *
; *                                                                           *
; * FREQ_DEFAULT is simply informative and for reference. It is not easy to   *
; * mathematically calculate the actual FREQ_MULTIPLIER so it is easier to    *
; * have FREQ_MULTIPLIER set by hand. Having FREQ and FREQ_DEFAULT makes it   *
; * easier to spot any errors.                                                *
; *                                                                           *
; *****************************************************************************

  #IfDef _isM2
    Symbol FREQ            = M16
    Symbol FREQ_DEFAULT    = M4
    Symbol FREQ_MULTIPLIER = 4
    Symbol FREQ_N2400      = N2400_16
    #Define _isOK
  #EndIf

  #IfDef _isX2
    Symbol FREQ            = M16
    Symbol FREQ_DEFAULT    = M8
    Symbol FREQ_MULTIPLIER = 2
    Symbol FREQ_N2400      = N2400_16
    #Define _isOK
  #EndIf

  #IfDef _isOK
    #Undefine _isOK
  #Else
    #Error No FREQ / FREQ_MULTIPLIER set for PICAXE type
  #EndIf

; *****************************************************************************
; *                                                                           *
; * Constants                                                                 *
; *                                                                           *
; *****************************************************************************

; .---------------------------------------------------------------------------.
; | Time constants                                                            |
; |---------------------------------------------------------------------------|
; |                                                                           |
; | Because the chip operates at different speeds above its default depending |
; | on type we have to adjust time constants accordingly. We specify all time |
; | constants in milliseconds and adjust according to the FREQ_MULTIPLIER     |
; | in use.                                                                   |
; |                                                                           |
; | If a new time period is added into the code it should be specified as an  |
; | MS_XXX constant then added here.                                          |
; |                                                                           |
; `---------------------------------------------------------------------------'

  Symbol MS_10       = 10   * FREQ_MULTIPLIER   ; 10ms
  Symbol MS_20       = 20   * FREQ_MULTIPLIER   ; 20ms
  Symbol MS_100      = 100  * FREQ_MULTIPLIER   ; 100ms
  Symbol MS_500      = 500  * FREQ_MULTIPLIER   ; 500ms
  Symbol MS_1000     = 1000 * FREQ_MULTIPLIER   ; 1000ms = 1 second

; .---------------------------------------------------------------------------.
; | Timeout constants                                                         |
; `---------------------------------------------------------------------------'

  Symbol MAX_TIMEOUT = MS_1000          ; 1000ms = 1 second
  Symbol MIN_TIMEOUT = MS_500           ; 500ms  = 1/2th second
  Symbol DEC_TIMEOUT = MS_20

; .---------------------------------------------------------------------------.
; | PICAXE Type Header                                                         |
; `---------------------------------------------------------------------------'

;   .-------------------- 0 = M2/X2
;   |
;   |             .------ 0 = M2, 1 = X2
;   |             |
; .-----------------.
; | t n n n n n n t |
; `-----------------'
;     | | | | | |
;     n n n n n n 0 = size of chip
; 
;     0 0 0 1 0 0   =  8-pin. 
;     0 0 0 1 1 1   = 14-pin. 
;     0 0 1 0 1 0   = 20-pin. 
;     0 0 1 1 1 0   = 28-pin. 
;     0 1 0 1 0 0   = 40-pin. 
     
  Symbol TYPE_M2 = $00
  Symbol TYPE_X2 = $01
  Symbol TYPE_aa = $80
  Symbol TYPE_bb = $81

  #IfDef _08M2
    Symbol TYPE_PICAXE = 08 | TYPE_M2
    #Define _isOK
  #EndIf

  #IfDef _14M2
    Symbol TYPE_PICAXE = 14 | TYPE_M2
    #Define _isOK
  #EndIf

  #IfDef _18M2
    Symbol TYPE_PICAXE = 18 | TYPE_M2
    #Define _isOK
  #EndIf

  #IfDef _20M2
    Symbol TYPE_PICAXE = 20 | TYPE_M2
    #Define _isOK
  #EndIf

  #IfDef _20X2
    Symbol TYPE_PICAXE = 20 | TYPE_X2
    #Define _isOK
  #EndIf

  #IfDef _28X2
    Symbol TYPE_PICAXE = 28 | TYPE_X2
    #Define _isOK
  #EndIf

  #IfDef _40X2
    Symbol TYPE_PICAXE = 40 | TYPE_X2
    #Define _isOK
  #EndIf

  #IfDef _isOK
    #Undefine _isOK
  #Else
    #Error No type header for PICAXE type
  #EndIf

; .---------------------------------------------------------------------------.
; | Analogue inputs available                                                 |
; `---------------------------------------------------------------------------'

   #IfDef _08M2
     ;                  CCCCCCCCBBBBBBBB
     ;                  7654321076543210
     Symbol MASK_CB  = %0001011000000000
   #EndIf

   #IfDef _14M2
     ;                  CCCCCCCCBBBBBBBB
     ;                  7654321076543210
     Symbol MASK_CB  = %0011111000010001
   #EndIf

   #IfDef _18M2
     ;                  CCCCCCCCBBBBBBBB
     ;                  7654321076543210
     Symbol MASK_CB  = %0000011111111110
   #EndIf

   #IfDef _20M2
     ;                  CCCCCCCCBBBBBBBB
     ;                  7654321076543210
     Symbol MASK_CB  = %1000111001111111
   #EndIf

   #IfDef _20X2
     ;                  CCCCCCCCBBBBBBBB                      DDDDDDDDAAAAAAAA
     ;                  7654321076543210                      7654321076543210
     Symbol MASK_CB  = %1000011101111111 : Symbol MASK_DA  = %0000000000000000
   #EndIf

   #IfDef _28X2
     ;                  CCCCCCCCBBBBBBBB                      DDDDDDDDAAAAAAAA
     ;                  7654321076543210                      7654321076543210
     Symbol MASK_CB  = %1111110000111111 : Symbol MASK_DA  = %0000000000001111
   #EndIf

   #IfDef _40X2
     ;                  CCCCCCCCBBBBBBBB                      DDDDDDDDAAAAAAAA
     ;                  7654321076543210                      7654321076543210
     Symbol MASK_CB  = %1111110000111111 : Symbol MASK_DA  = %1111111111101111
   #EndIf

; *****************************************************************************
; *                                                                           *
; * Variables                                                                 *
; *                                                                           *
; *****************************************************************************

; .---------------------------------------------------------------------------.
; | Define the basic variables used and their component parts                 |
; `---------------------------------------------------------------------------'

  Symbol reserveW0   = w0 ; b1:b0       ; Command value / General purpose
  Symbol reserveW1   = w1 ; b3:b2       ; Command parameter
  Symbol reserveW2   = w2 ; b5:b4       ; Command paramater / Return result

  Symbol w0.lsb      = b0
  Symbol w0.msb      = b1

  Symbol w1.lsb      = b2
  Symbol w1.msb      = b3

  Symbol w2.lsb      = b4
  Symbol w2.msb      = b5

; .---------------------------------------------------------------------------.
; | Define additional variables and their component parts                     |
; `---------------------------------------------------------------------------'

  Symbol timeout     = w3 ; b7:b6       ; Command timeout period

  Symbol adcMaskCB   = w4 ; b9:b8       ; Mask of ADC pins enabled (C:B)

  Symbol adcMaskB    = b8
  Symbol adcMaskC    = b9

  #IfDef _isX2

    Symbol adcMaskDA = w5 ; b11:b10     ; Mask of ADC pins enabled (D:A)

    Symbol adcMaskA  = b10
    Symbol adcMaskD  = b11

  #EndIf

  Symbol BPTR_START  = 12

; .---------------------------------------------------------------------------.
; | Define received packets                                                   |
; `---------------------------------------------------------------------------'

;         b0   w1msb w1lsb w2msb w2lsb
; .-----.-----.-----.-----.-----.-----.
; | ">" | "?" |  0  |  0  |  0  |  0  | "?" - S2P Polling
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "@" |  0  |  0  |  0  |  0  | "@" - Blockly Polling
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "A" |  0  | pin |  0  |  0  | "A" - ReadAdc10 pin,result
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "C" |  0  | pin |   period  | "C" - Count pin,period,result
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "D" |  0  | pin |  0  | chr | "D" - LCD Display char
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "D" |  0  | pin | cmd | chr | "D" - LCD Display 254,cmd then char
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "G" |  0  | pin |  0  |  0  | "G" - Let result=pinX
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "H" |  0  | pin |  0  |  0  | "H" - High pin
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "I" |  0  | pin | dev | cmd | "I" - IrOut pin,dev,cmd
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "L" |  0  | pin |  0  |  0  | "L" - Low pin
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "M" |  0  | $m0 |  0  |  0  | "M" - Motor Halt M
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "M" |  0  | $m1 |  0  |  0  | "M" - Motor Forward M
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "M" |  0  | $m2 |  0  |  0  | "M" - Motor Backward M
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "P" |  0  | pin |  period   | "P" - PulsOut pin,period
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "R" |  0  |  0  |  0  |  0  | "R" - Reset
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "S" |  0  | pin | not | dur | "S" - Sound pin,(note,duration)
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "T" |  0  | pin |  0  |  0  | "T" - Toggle pin
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "V" |  0  | pin |  0  | pos | "V" - Servo pin, pos
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "W" |   duty    | pin | per | "W" - PwmOut pin,period,duty
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "X" |  0  |  0  |  0  |  0  | "X" - Reset Outputs
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "a" |  0  | pin |  0  | typ | "a" - Set Pin As
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "b" | rdb |  0  |  0  |  0  | "b" - I2C read rdb bytes
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "b" | rdb |  1  | byt |  0  | "b" - I2C write 1 byte, read rdb bytes
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "b" | rdb |  2  | by1 | by2 | "b" - I2C write 2 bytes,read rdb bytes
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "g" |  0  | adr |  0  |  0  | "g" - Read EEPROM adr,result
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "h" |  0  | pin |  0  |  0  | "h" - ReadTemp12 pin,result
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "i" |  0  | pin |  0  |  0  | "i" - Wait for IrIn pin
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "i" |  0  | pin |  timeout  | "i" - Wait for IrIn pin with timeout
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "p" |  0  | adr |  0  | byt | "p" - Write EEPROM adr,byte
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "r" |    adr    |  0  |  0  | "r" - Read I2C adr,(result)
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "s" |  0  |  0  |  0  |  0  | "s" - I2C off
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "s" |  0  | dev |  0  |  0  | "s" - I2C dev,slow,byte
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "s" |  0  | dev |  0  |  1  | "s" - I2C dev,slow,word
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "s" |  0  | dev |  1  |  0  | "s" - I2C dev,fast,byte
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "s" |  0  | dev |  1  |  1  | "s" - I2C dev,fast,word
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "t" |  0  | pin |  0  |  0  | "t" - Touch pin,result
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "u" |  0  | pin |  0  |  0  | "u" - Ultra pin,result
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "v" | pinT|pinE |  0  |  0  | "v" - Ultra 2 pin,result
; `-----^-----^-----^-----^-----^-----'
; .-----.-----.-----.-----.-----.-----.
; | ">" | "w" |    adr    |  0  | byt | "w" - Write I2c byte
; `-----^-----^-----^-----^-----^-----'

; .---------------------------------------------------------------------------.
; | Define reply packet                                                       |
; `---------------------------------------------------------------------------'

; .-----.
; | "[" |       Start of packet marker
; `-----|-----.
;       | len | Length of packet ( inc this length itself, exc "[" and "]" )
;       |-----|
;       | typ | PICAXE type : 18 for 18-pin | type $00=M2, $01=X2
;       |-----|
;       | cmd | Which command being replied to
;       |-----|
;       | xxx | Actual reply bytes
;       | ::: |
;       | yyy |
; .-----|-----'
; | "]" |       End of packet marker
; `-----'

; .---------------------------------------------------------------------------.
; | Bits when adcMaskCB for C (msb) and B (lsb) loaded into w0                |
; `---------------------------------------------------------------------------'

  Symbol bitB.0      = bit0
  Symbol bitB.1      = bit1
  Symbol bitB.2      = bit2
  Symbol bitB.3      = bit3
  Symbol bitB.4      = bit4
  Symbol bitB.5      = bit5
  Symbol bitB.6      = bit6
  Symbol bitB.7      = bit7

  Symbol bitC.0      = bit8
  Symbol bitC.1      = bit9
  Symbol bitC.2      = bit10
  Symbol bitC.3      = bit11
  Symbol bitC.4      = bit12
  Symbol bitC.5      = bit13
  Symbol bitC.6      = bit14
  Symbol bitC.7      = bit15

; .---------------------------------------------------------------------------.
; | Bits when adcMaskCB for D (msb) and A (lsb) loaded into w0                |
; `---------------------------------------------------------------------------'

  #IfDef _isX2

    Symbol bitA.0    = bit0
    Symbol bitA.1    = bit1
    Symbol bitA.2    = bit2
    Symbol bitA.3    = bit3
    Symbol bitA.4    = bit4
    Symbol bitA.5    = bit5
    Symbol bitA.6    = bit6
    Symbol bitA.7    = bit7

    Symbol bitD.0    = bit8
    Symbol bitD.1    = bit9
    Symbol bitD.2    = bit10
    Symbol bitD.3    = bit11
    Symbol bitD.4    = bit12
    Symbol bitD.5    = bit13
    Symbol bitD.6    = bit14
    Symbol bitD.7    = bit15

  #EndIf

; .---------------------------------------------------------------------------.
; | Bits for w1 - Makes it easier to know which bit is being referenced       |
; `---------------------------------------------------------------------------'

  Symbol w1.bit0     = bit16
  Symbol w1.bit1     = bit17
  Symbol w1.bit2     = bit18
  Symbol w1.bit3     = bit19
  Symbol w1.bit4     = bit20
  Symbol w1.bit5     = bit21
  Symbol w1.bit6     = bit22
  Symbol w1.bit7     = bit23

  Symbol w1.bit8     = bit24
  Symbol w1.bit9     = bit25
  Symbol w1.bit10    = bit26
  Symbol w1.bit11    = bit27
  Symbol w1.bit12    = bit28
  Symbol w1.bit13    = bit29
  Symbol w1.bit14    = bit30
  Symbol w1.bit15    = bit31

; *****************************************************************************
; *                                                                           *
; * Power on reset                                                            *
; *                                                                           *
; *****************************************************************************

PowerOnReset:

; .---------------------------------------------------------------------------.
; | Set the operating frequency of the chip                                   |
; `---------------------------------------------------------------------------'

  SetFreq FREQ

; .---------------------------------------------------------------------------.
; | Delay and send some ignored characters to clear any corruption            |
; `---------------------------------------------------------------------------'

  For b0 = 1 To 10
    Pause MS_10
    SerTxd( 0 )
  Next

; *****************************************************************************
; *                                                                           *
; * Fake a power on reset                                                     *
; *                                                                           *
; *****************************************************************************

FakeReset:

; .---------------------------------------------------------------------------.
; | Set the operating frequency of the chip                                   |
; `---------------------------------------------------------------------------'

  SetFreq FREQ

; .---------------------------------------------------------------------------.
; | All pins inputs, outputs low
; `---------------------------------------------------------------------------'

  #IfDef _isM2

    pinsB = 0
    pinsC = 0

    dirsB = 0
    dirsC = 0

  #Else

    pinsB = 0
    pinsC = 0
    pinsA = 0
    pinsD = 0

    dirsB = 0
    dirsC = 0
    dirsA = 0
    dirsD = 0

  #EndIf

; .---------------------------------------------------------------------------.
; | All ADC off
; `---------------------------------------------------------------------------'

  adcMaskCB = $0000

  #IfDef _isX2
    adcMaskDA = $0000
  #EndIf

  adcSetup = $0000

  #IfDef _28X2
    adcSetup2 = $0000
  #EndIf

  #IfDef _40X2
    adcSetup2 = $0000
  #EndIf

; .---------------------------------------------------------------------------.
; | Initialise the timeout                                                    |
; `---------------------------------------------------------------------------'

  timeout = MAX_TIMEOUT

; *****************************************************************************
; *                                                                           *
; * Send a reset packet                                                              *
; *                                                                           *
; *****************************************************************************

SendReset:

  ; .-----.
  ; | len | Length of packet (5)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "*" | Reset flag
  ; |-----|
  ; | maj | Version number
  ; | min |
  ; `-----'

  SerTxd( "[", 5, TYPE_PICAXE, "*", VERSION_MAJOR, VERSION_MINOR )


; *****************************************************************************
; *                                                                           *
; * Wait for a command to be received                                         *
; *                                                                           *
; *****************************************************************************

WaitForCommand:

  ; Add the end of packet marker

  SerTxd( "]" )

  ; Wait for a command to come in ( 6 bytes )
  
  ; .-------.--------.--------.--------.--------.--------.
  ; |  ">"  |   b0   | w1.msb | w1.lsb | w2.msb | w2.lsb |
  ; `-------^--------^--------^--------^--------^--------'

  'SerRxd [timeout,TimedOut], (">"), b0, w1.msb, w1.lsb, w2.msb, w2.lsb
  SerRxd (">"), b0, w1.msb, w1.lsb, w2.msb, w2.lsb
  ; Start with start of packet marker

  SerTxd( "[" )

  ; Handle the actual command
  
  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "H" |  0  | pin |  0  |  0  | "H" - High pin
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "I" |  0  | pin | dev | cmd | "I" - IrOut pin,dev,cmd
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "L" |  0  | pin |  0  |  0  | "L" - Low pin
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "P" |  0  | pin |  period   | "P" - PulsOut pin,period
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "R" |  0  |  0  |  0  |  0  | "R" - Reset
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "S" |  0  | pin | not | dur | "S" - Sound pin,(note,duration)
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "T" |  0  | pin |  0  |  0  | "T" - Toggle pin
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "V" |  0  | pin |  0  | pos | "V" - Servo pin,pos
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "W" |   duty    | pin | per | "W" - PwmOut pin,period,duty
  ; `-----^-----^-----^-----^-----^-----'

  Select Case b0

    Case "?" : Goto    S2pPolling
    Case "@" : Goto    BlocklyPolling
    Case "A" : Goto    AdcCommand
    Case "C" : Goto    CountCommand
    Case "D" : Goto    DisplayOnLcdCommand
    Case "G" : Goto    GetPinCommand
    Case "H" : High    w1
    Case "I" : IrOut   w1, w2.msb, w2.lsb
    Case "L" : Low     w1
    Case "M" : Goto    MotorCommand
    Case "P" : PulsOut w1, w2
    Case "R" : Goto    FakeReset
    Case "S" : Sound   w1, ( w2.msb, w2.lsb )
    Case "T" : Toggle  w1
    Case "V" : Servo   w1, w2
    Case "W" : PwmOut  w2.msb, w2.lsb, w1 ; Note order is reversed
    Case "X" : Goto    ResetOutputs

    Case "a" : Goto    SetPinAs
    Case "b" : Goto    I2cBlockCommand
    Case "g" : Goto    ReadEeprom         ; "get eeprom"
    Case "h" : Goto    ReadTempCommand
    Case "i" : Goto    IrInCommand
    Case "p" : Goto    WriteEeprom        ; "put eeprom"
    Case "r" : Goto    I2cEepromRead
    Case "s" : Goto    I2cEepromSetup
    Case "t" : Goto    TouchCommand
    Case "u" : Goto    UltraCommand
    Case "v" : Goto    UltraCommand2Pin
    Case "w" : Goto    I2cEepromWrite

    Else     : Goto    InvalidCommand

  End Select

; *****************************************************************************
; *                                                                           *
; * Poll the ports                                                            *
; *                                                                           *
; *****************************************************************************

BlocklyPolling:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "@" |  0  |  0  |  0  |  0  | "@" - Blockly Polling
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "@" | Which command being replied to
  ; |-----|
  ; | $0x | Bit mask of data supplied %0000ABCD
  ; |-----|
  ; |	A | pinsA if in bit mask
  ; | drA | dirsA
  ; |-----|
  ; | pnB | pinsB if in bit mask
  ; | drB | dirsB
  ; |-----|
  ; | pnC | pinsC if in bit mask
  ; | drC | dirsC
  ; |-----|
  ; | pnD | pinsD if in bit mask
  ; | drD | dirsD
  ; `-----'

  #IfDef _08M2
    SerTxd( 6, TYPE_PICAXE, "@", %0010, pinsC, dirsC )
    #Define _isOK
  #EndIf

  #IfDef _14M2
    SerTxd( 8, TYPE_PICAXE, "@", %0110, pinsB, dirsB, pinsC, dirsC )
    #Define _isOK
  #EndIf

  #IfDef _18M2
    SerTxd( 8, TYPE_PICAXE, "@", %0110, pinsB, dirsB, pinsC, dirsC )
    #Define _isOK
  #EndIf

  #IfDef _20M2
    SerTxd( 8, TYPE_PICAXE, "@", %0110, pinsB, dirsB, pinsC, dirsC )
    #Define _isOK
  #EndIf

  #IfDef _20X2
    SerTxd( 8, TYPE_PICAXE, "@", %0110, pinsB, dirsB, pinsC, dirsC )
    #Define _isOK
  #EndIf

  #IfDef _28X2
    SerTxd( 12, TYPE_PICAXE, "@", %1111, pinsA, dirsA, pinsB, dirsB, _
                                         pinsC, dirsC, pinsD, dirsD )
    #Define _isOK
  #EndIf

  #IfDef _40X2
    SerTxd( 12, TYPE_PICAXE, "@", %1111, pinsA, dirsA, pinsB, dirsB, _
                                         pinsC, dirsC, pinsD, dirsD )
    #Define _isOK
  #EndIf

  #IfDef _isOK
    #Undefine _isOK
  #Else
    #Error No polling information for PICAXE type
  #EndIf

  Goto WaitForCommand

; *****************************************************************************
; *                                                                           *
; * Full poll the ports                                                       *     *
; *                                                                           *
; *****************************************************************************
; *                                                                           *
; * THIS CAN BE IGNRED / REMOVED FOR BLOCKLY - IS ONLY USED BY S2P            *
; *                                                                           *
; *****************************************************************************

S2pPolling:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "?" |  0  |  0  |  0  |  0  |
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "?" | Full polling report ( old S2P )
  ; |-----|
  ; | $0x | Bit mask of data supplied %0000ABCD
  ; |-----|
  ; | pnA | pinsA if in bit mask
  ; | drA | dirsA
  ; : - - :
  ; | pnD | pinsD if in bit mask
  ; | drD | dirsD
  ; : - - :                   .-----------------.-----------------.
  ; | msb | Analogue inputs   | 0 p p p x x n n | n n n n n n n n |
  ; | lsb |                   `-----------------^-----------------'
  ; `-----'                       `---' `-' `-------------------'
  ;                                pin  port  10-bit ADC reading
  ;                                     |
  ;                                     `-- 00=A, 01=B, 10=C, 11=D

  bPtr = BPTR_START

  #IfDef _08M2
    @bPtrInc = %0010
    @bPtrInc = pinsC
    @bPtrInc = dirsC

    w0.msb = adcMaskC &/ dirsC ; Adc on pins C

    If w0.msb = 0 Then SendPollPacket

    If bitC.1 = 1 Then : ReadAdc10 C.1, w2 : @bPtrInc = $18 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.2 = 1 Then : ReadAdc10 C.2, w2 : @bPtrInc = $28 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.4 = 1 Then : ReadAdc10 C.4, w2 : @bPtrInc = $48 | w2.msb : @bPtrInc = w2.lsb : End If

    #Define _isOK
  #EndIf

  #IfDef _14M2
    @bPtrInc = %0110
    @bPtrInc = pinsB
    @bPtrInc = dirsB
    @bPtrInc = pinsC
    @bPtrInc = dirsC

    w0.lsb = adcMaskB &/ dirsB ; Adc on pins B
    w0.msb = adcMaskC &/ dirsC ; Adc on pins C

    If w0 = 0 Then SendPollPacket

    If bitB.1 = 1 Then : ReadAdc10 B.1, w2 : @bPtrInc = $14 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.2 = 1 Then : ReadAdc10 B.2, w2 : @bPtrInc = $24 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.3 = 1 Then : ReadAdc10 B.3, w2 : @bPtrInc = $34 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.4 = 1 Then : ReadAdc10 B.4, w2 : @bPtrInc = $44 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.5 = 1 Then : ReadAdc10 B.5, w2 : @bPtrInc = $54 | w2.msb : @bPtrInc = w2.lsb : End If

    If bitC.0 = 1 Then : ReadAdc10 C.0, w2 : @bPtrInc = $08 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.4 = 1 Then : ReadAdc10 C.4, w2 : @bPtrInc = $48 | w2.msb : @bPtrInc = w2.lsb : End If

    #Define _isOK
  #EndIf

  #IfDef _18M2
    @bPtrInc = %0110
    @bPtrInc = pinsB
    @bPtrInc = dirsB
    @bPtrInc = pinsC
    @bPtrInc = dirsC

    w0.lsb = adcMaskB &/ dirsB ; Adc on pins B
    w0.msb = adcMaskC &/ dirsC ; Adc on pins C

    If w0 = 0 Then SendPollPacket

    If bitB.1 = 1 Then : ReadAdc10 B.1, w2 : @bPtrInc = $14 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.2 = 1 Then : ReadAdc10 B.2, w2 : @bPtrInc = $24 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.3 = 1 Then : ReadAdc10 B.3, w2 : @bPtrInc = $34 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.4 = 1 Then : ReadAdc10 B.4, w2 : @bPtrInc = $44 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.5 = 1 Then : ReadAdc10 B.5, w2 : @bPtrInc = $54 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.6 = 1 Then : ReadAdc10 B.6, w2 : @bPtrInc = $64 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.7 = 1 Then : ReadAdc10 B.7, w2 : @bPtrInc = $74 | w2.msb : @bPtrInc = w2.lsb : End If

    If bitC.0 = 1 Then : ReadAdc10 C.0, w2 : @bPtrInc = $08 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.1 = 1 Then : ReadAdc10 C.1, w2 : @bPtrInc = $18 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.2 = 1 Then : ReadAdc10 C.2, w2 : @bPtrInc = $28 | w2.msb : @bPtrInc = w2.lsb : End If


    #Define _isOK
  #EndIf

  #IfDef _20M2
    @bPtrInc = %0110
    @bPtrInc = pinsB
    @bPtrInc = dirsB
    @bPtrInc = pinsC
    @bPtrInc = dirsC

    w0.lsb = adcMaskB &/ dirsB ; Adc on pins B
    w0.msb = adcMaskC &/ dirsC ; Adc on pins C

    If w0 = 0 Then SendPollPacket

    If bitB.0 = 1 Then : ReadAdc10 B.0, w2 : @bPtrInc = $04 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.1 = 1 Then : ReadAdc10 B.1, w2 : @bPtrInc = $14 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.2 = 1 Then : ReadAdc10 B.2, w2 : @bPtrInc = $24 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.3 = 1 Then : ReadAdc10 B.3, w2 : @bPtrInc = $34 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.4 = 1 Then : ReadAdc10 B.4, w2 : @bPtrInc = $44 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.5 = 1 Then : ReadAdc10 B.5, w2 : @bPtrInc = $54 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.6 = 1 Then : ReadAdc10 B.6, w2 : @bPtrInc = $64 | w2.msb : @bPtrInc = w2.lsb : End If

    If bitC.1 = 1 Then : ReadAdc10 C.1, w2 : @bPtrInc = $18 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.2 = 1 Then : ReadAdc10 C.2, w2 : @bPtrInc = $28 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.3 = 1 Then : ReadAdc10 C.3, w2 : @bPtrInc = $38 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.7 = 1 Then : ReadAdc10 C.7, w2 : @bPtrInc = $78 | w2.msb : @bPtrInc = w2.lsb : End If

    #Define _isOK
  #EndIf

  #IfDef _20X2
    @bPtrInc = %0110
    @bPtrInc = pinsB
    @bPtrInc = dirsB
    @bPtrInc = pinsC
    @bPtrInc = dirsC

    w0.lsb = adcMaskB &/ dirsB ; Adc on pins B
    w0.msb = adcMaskC &/ dirsC ; Adc on pins C

    If w0 = 0 Then SendPollPacket

    If bitB.0 = 1 Then : ReadAdc10 B.0, w2 : @bPtrInc = $04 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.1 = 1 Then : ReadAdc10 B.1, w2 : @bPtrInc = $14 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.2 = 1 Then : ReadAdc10 B.2, w2 : @bPtrInc = $24 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.3 = 1 Then : ReadAdc10 B.3, w2 : @bPtrInc = $34 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.4 = 1 Then : ReadAdc10 B.4, w2 : @bPtrInc = $44 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.5 = 1 Then : ReadAdc10 B.5, w2 : @bPtrInc = $54 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.6 = 1 Then : ReadAdc10 B.6, w2 : @bPtrInc = $64 | w2.msb : @bPtrInc = w2.lsb : End If

    If bitC.1 = 1 Then : ReadAdc10 C.1, w2 : @bPtrInc = $18 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.2 = 1 Then : ReadAdc10 C.2, w2 : @bPtrInc = $28 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.3 = 1 Then : ReadAdc10 C.3, w2 : @bPtrInc = $38 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.7 = 1 Then : ReadAdc10 C.7, w2 : @bPtrInc = $78 | w2.msb : @bPtrInc = w2.lsb : End If

    #Define _isOK
  #EndIf

  #IfDef _28X2
    @bPtrInc = %1111
    @bPtrInc = pinsA
    @bPtrInc = dirsA
    @bPtrInc = pinsB
    @bPtrInc = dirsB
    @bPtrInc = pinsC
    @bPtrInc = dirsC
    @bPtrInc = pinsD
    @bPtrInc = dirsD

    w0.lsb = adcMaskA &/ dirsA ; Adc on pins A

    If w0.lsb <> 0 Then

    If bitA.0 = 1 Then : ReadAdc10 A.0, w2 : @bPtrInc = $00 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitA.1 = 1 Then : ReadAdc10 A.1, w2 : @bPtrInc = $10 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitA.2 = 1 Then : ReadAdc10 A.2, w2 : @bPtrInc = $20 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitA.3 = 1 Then : ReadAdc10 A.3, w2 : @bPtrInc = $30 | w2.msb : @bPtrInc = w2.lsb : End If

    End If

    w0.lsb = adcMaskB &/ dirsB ; Adc on pins B
    w0.msb = adcMaskC &/ dirsC ; Adc on pins C

    If w0 = 0 Then SendPollPacket

    If bitB.0 = 1 Then : ReadAdc10 B.0, w2 : @bPtrInc = $04 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.1 = 1 Then : ReadAdc10 B.1, w2 : @bPtrInc = $14 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.2 = 1 Then : ReadAdc10 B.2, w2 : @bPtrInc = $24 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.3 = 1 Then : ReadAdc10 B.3, w2 : @bPtrInc = $34 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.4 = 1 Then : ReadAdc10 B.4, w2 : @bPtrInc = $44 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.5 = 1 Then : ReadAdc10 B.5, w2 : @bPtrInc = $54 | w2.msb : @bPtrInc = w2.lsb : End If

    If bitC.2 = 1 Then : ReadAdc10 C.2, w2 : @bPtrInc = $28 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.3 = 1 Then : ReadAdc10 C.3, w2 : @bPtrInc = $38 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.4 = 1 Then : ReadAdc10 C.4, w2 : @bPtrInc = $48 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.5 = 1 Then : ReadAdc10 C.5, w2 : @bPtrInc = $58 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.6 = 1 Then : ReadAdc10 C.6, w2 : @bPtrInc = $68 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.7 = 1 Then : ReadAdc10 C.7, w2 : @bPtrInc = $78 | w2.msb : @bPtrInc = w2.lsb : End If

    #Define _isOK
  #EndIf

  #IfDef _40X2
    @bPtrInc = %1111
    @bPtrInc = pinsA
    @bPtrInc = dirsA
    @bPtrInc = pinsB
    @bPtrInc = dirsB
    @bPtrInc = pinsC
    @bPtrInc = dirsC
    @bPtrInc = pinsD
    @bPtrInc = dirsD

    w0.lsb = adcMaskA &/ dirsA ; Adc on pins A
    w0.msb = adcMaskD &/ dirsD ; Adc on pins D

    If w0 <> 0 Then

    If bitA.0 = 1 Then : ReadAdc10 A.0, w2 : @bPtrInc = $00 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitA.1 = 1 Then : ReadAdc10 A.1, w2 : @bPtrInc = $10 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitA.2 = 1 Then : ReadAdc10 A.2, w2 : @bPtrInc = $20 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitA.3 = 1 Then : ReadAdc10 A.3, w2 : @bPtrInc = $30 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitA.5 = 1 Then : ReadAdc10 A.5, w2 : @bPtrInc = $50 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitA.6 = 1 Then : ReadAdc10 A.6, w2 : @bPtrInc = $60 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitA.7 = 1 Then : ReadAdc10 A.7, w2 : @bPtrInc = $70 | w2.msb : @bPtrInc = w2.lsb : End If

    If bitD.0 = 1 Then : ReadAdc10 D.0, w2 : @bPtrInc = $0C | w2.msb : @bPtrInc = w2.lsb : End If
    If bitD.1 = 1 Then : ReadAdc10 D.1, w2 : @bPtrInc = $1C | w2.msb : @bPtrInc = w2.lsb : End If
    If bitD.2 = 1 Then : ReadAdc10 D.2, w2 : @bPtrInc = $2C | w2.msb : @bPtrInc = w2.lsb : End If
    If bitD.3 = 1 Then : ReadAdc10 D.3, w2 : @bPtrInc = $3C | w2.msb : @bPtrInc = w2.lsb : End If
    If bitD.4 = 1 Then : ReadAdc10 D.4, w2 : @bPtrInc = $4C | w2.msb : @bPtrInc = w2.lsb : End If
    If bitD.5 = 1 Then : ReadAdc10 D.5, w2 : @bPtrInc = $5C | w2.msb : @bPtrInc = w2.lsb : End If
    If bitD.6 = 1 Then : ReadAdc10 D.6, w2 : @bPtrInc = $6C | w2.msb : @bPtrInc = w2.lsb : End If
    If bitD.7 = 1 Then : ReadAdc10 D.7, w2 : @bPtrInc = $7C | w2.msb : @bPtrInc = w2.lsb : End If

    End If

    w0.lsb = adcMaskB &/ dirsB ; Adc on pins B
    w0.msb = adcMaskC &/ dirsC ; Adc on pins C

    If w0 = 0 Then SendPollPacket

    If bitB.0 = 1 Then : ReadAdc10 B.0, w2 : @bPtrInc = $04 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.1 = 1 Then : ReadAdc10 B.1, w2 : @bPtrInc = $14 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.2 = 1 Then : ReadAdc10 B.2, w2 : @bPtrInc = $24 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.3 = 1 Then : ReadAdc10 B.3, w2 : @bPtrInc = $34 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.4 = 1 Then : ReadAdc10 B.4, w2 : @bPtrInc = $44 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitB.5 = 1 Then : ReadAdc10 B.5, w2 : @bPtrInc = $54 | w2.msb : @bPtrInc = w2.lsb : End If

    If bitC.2 = 1 Then : ReadAdc10 C.2, w2 : @bPtrInc = $28 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.3 = 1 Then : ReadAdc10 C.3, w2 : @bPtrInc = $38 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.4 = 1 Then : ReadAdc10 C.4, w2 : @bPtrInc = $48 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.5 = 1 Then : ReadAdc10 C.5, w2 : @bPtrInc = $58 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.6 = 1 Then : ReadAdc10 C.6, w2 : @bPtrInc = $68 | w2.msb : @bPtrInc = w2.lsb : End If
    If bitC.7 = 1 Then : ReadAdc10 C.7, w2 : @bPtrInc = $78 | w2.msb : @bPtrInc = w2.lsb : End If

    #Define _isOK
  #EndIf

  #IfDef _isOK
    #Undefine _isOK
  #Else
    #Error No full polling information for PICAXE type
  #EndIf

SendPollPacket:

  b0 = bPtr - BPTR_START + 3

  SerTxd( b0, TYPE_PICAXE, "?" )

  bPtr = BPTR_START
  Do
    SerTxd( @bPtrInc )
    b0 = b0 - 1
  Loop While b0 > 3

  Goto WaitForCommand

; *****************************************************************************
; *                                                                           *
; * Timed out                                                                 *
; *                                                                           *
; *****************************************************************************

TimedOut:

  ; .-----.
  ; | len | Length of packet (3)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "!" | Timed out flag
  ; `-----'

  SerTxd( "[", 3, TYPE_PICAXE, "!" )

  Goto WaitForCommand

; *****************************************************************************
; *                                                                           *
; * Invalid Command                                                                 *
; *                                                                           *
; *****************************************************************************

InvalidCommand:

  ; .-----.
  ; | len | Length of packet (3)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "~" | Invalid Command Flag
  ; `-----'

  SerTxd( 3, TYPE_PICAXE, "~" )

  Goto WaitForCommand

; *****************************************************************************
; *                                                                           *
; * "A" - ADC                                                                 *
; *                                                                           *
; *****************************************************************************

AdcCommand:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "A" |  0  | pin |  0  |  0  |
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet (6)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "A" | Command
  ; |-----|
  ; | $xn | Pin, eg $C5 = C.5
  ; |-----|
  ; | msb | Result
  ; | lsb |
  ; `-----'

  #IfDef _isX2
    Gosub GetAdcChannelNumber
    If bit7 <> 0 Then InvalidCommand
    ReadAdc10 b0, w2
  #Else
    ReadAdc10 w1, w2
  #EndIf

  SerTxd( 6, TYPE_PICAXE, "A" )

  Goto SendPinInW1PlusResultInW2

; *****************************************************************************
; *                                                                           *
; * "C" - Count                                                               *
; *                                                                           *
; *****************************************************************************

CountCommand:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "C" |  0  | pin |   period  |
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet (6)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "C" | Command
  ; |-----|
  ; | $xn | Pin, eg $C5 = C.5
  ; |-----|
  ; | msb | Result
  ; | lsb |
  ; `-----'

  SetFreq M4
  Count w1, w2, w2
  SetFreq FREQ

  SerTxd( 6, TYPE_PICAXE, "C" )

  Goto SendPinInW1PlusResultInW2

; *****************************************************************************
; *                                                                           *
; * "D" - Display On Lcd                                                      *
; *                                                                           *
; *****************************************************************************
; *                                                                           *
; *  Parameter w1 is pin, w2.msb/w2.lsb are the bytes to send -               *
; *                                                                           *
; *  128 xxx - Set position then send character byte to LCD                   *
; *    0 xxx - Sent as a character byte to the LCD                            *
; *                                                                           *
; *****************************************************************************

DisplayOnLcdCommand:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "D" |  0  | pin |  0  | chr | Display char
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "D" |  0  | pin | cmd | chr | Display 254,cmd then char
  ; `-----^-----^-----^-----^-----^-----'

  If w2.msb <> 0 Then
    SerOut w1, FREQ_N2400, ( 254, w2.msb )
  End If
  SerOut w1, FREQ_N2400, ( w2.lsb )

  Goto BlocklyPolling

; *****************************************************************************
; *                                                                           *
; * "G" - Get Pin                                                             *
; *                                                                           *
; *****************************************************************************

GetPinCommand:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "G" |  0  | pin |  0  |  0  |
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet (6)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "G" | Command
  ; |-----|
  ; | $xn | Pin, eg $C5 = C.5
  ; |-----|
  ; | msb | Result
  ; | lsb |
  ; `-----'

; .---------------------------------------------------------------------------.
; | Determine which port and pin we are looking at if an M2                   |
; `---------------------------------------------------------------------------'

  #IfDef _isM2
    #IfDef _08M2
      w2 = pinsC
    #Else
      Lookup w1.bit3, ( pinsB, pinsC ), w2
    #EndIf
    b0 = w1 & 7
    Read b0, b0
    w2 = w2 & b0 Max 1
  #EndIf

; .---------------------------------------------------------------------------.
; | Determine which port and pin we are looking at if an X2                   |
; `---------------------------------------------------------------------------'

  #IfDef _isX2
    b0 = w1 >> 3 & 3
    LookUp b0, ( pinsB, pinsC, pinsA, pinsD ), w2
    b0 = w1 & 7
    w2 = 1 << b0 & w2 Max 1
  #EndIf

; .---------------------------------------------------------------------------.
; | Return the result                                                         |
; `---------------------------------------------------------------------------'

  SerTxd( 6, TYPE_PICAXE, "G" )

  Goto SendPinInW1PlusResultInW2

; *****************************************************************************
; *                                                                           *
; * "M" - Motor                                                               *
; *                                                                           *
; *****************************************************************************

MotorCommand:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "M" |  0  | $m0 |  0  |  0  | Halt M
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "M" |  0  | $m1 |  0  |  0  | Forward M
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "M" |  0  | $m2 |  0  |  0  | Backward M
  ; `-----^-----^-----^-----^-----^-----'

  #IfDef _08M2
    Goto InvalidCommand
    #Define _isOK
  #EndIf

  #IfDef _14M2
    Select Case w1
      Case $A0 : Halt     A
      Case $A1 : Forward  A
      Case $A2 : Backward A
      Else     : Goto InvalidCommand
    End Select
    #Define _isOK
  #EndIf

  #IfDef _18M2
    Select Case w1
      Case $A0 : Halt     A
      Case $A1 : Forward  A
      Case $A2 : Backward A
      Case $B0 : Halt     B
      Case $B1 : Forward  B
      Case $B2 : Backward B
      Else     : Goto InvalidCommand
    End Select
    #Define _isOK
  #EndIf

  #IfDef _20M2
    Select Case w1
      Case $A0 : Halt     A
      Case $A1 : Forward  A
      Case $A2 : Backward A
      Case $B0 : Halt     B
      Case $B1 : Forward  B
      Case $B2 : Backward B
      Else     : Goto InvalidCommand
    End Select
    #Define _isOK
  #EndIf

  #IfDef _20X2
    Select Case w1
      Case $A0 : Halt     A
      Case $A1 : Forward  A
      Case $A2 : Backward A
      Case $B0 : Halt     B
      Case $B1 : Forward  B
      Case $B2 : Backward B
      Else     : Goto InvalidCommand
    End Select
    #Define _isOK
  #EndIf

  #IfDef _28X2
    Select Case w1
      Case $A0 : Halt     A
      Case $A1 : Forward  A
      Case $A2 : Backward A
      Case $B0 : Halt     B
      Case $B1 : Forward  B
      Case $B2 : Backward B
      Else     : Goto InvalidCommand
    End Select
    #Define _isOK
  #EndIf

  #IfDef _40X2
    Select Case w1
      Case $A0 : Halt     A
      Case $A1 : Forward  A
      Case $A2 : Backward A
      Case $B0 : Halt     B
      Case $B1 : Forward  B
      Case $B2 : Backward B
      Case $C0 : Halt     C
      Case $C1 : Forward  C
      Case $C2 : Backward C
      Case $D0 : Halt     D
      Case $D1 : Forward  D
      Case $D2 : Backward D
      Else     : Goto InvalidCommand
    End Select
    #Define _isOK
  #EndIf

  #IfDef _isOK
    #Undefine _isOK
  #Else
    #Error No MotorCommand routine for PICAXE type
  #EndIf

  Goto BlocklyPolling

; *****************************************************************************
; *                                                                           *
; * "X" - Reset Outputs                                                       *
; *                                                                           *
; *****************************************************************************

ResetOutputs:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "X" |  0  |  0  |  0  |  0  |
  ; `-----^-----^-----^-----^-----^-----'

  #IfDef _isM2

    pinsB = 0
    pinsC = 0

  #Else

    pinsB = 0
    pinsC = 0
    pinsA = 0
    pinsD = 0

  #EndIf

  Goto BlocklyPolling

; *****************************************************************************
; *                                                                           *
; * "a" - Set Pin As                                                          *
; *                                                                           *
; *****************************************************************************

; .---------------------------------------------------------------------------.
; |                                                                           |
; |---------------------------------------------------------------------------|
; |                                                                           |
; |   ' 0------- = not configured
; |   ' 1------- = configured
; |   ' -0------ = input
; |   ' -1------ = output
; |   ' --0----- = digital
; |   ' --1----- = analogue
; |   ' ----nnnn = type
; |
; |   ' 00000000 = unconfigured
; |   ' 11000001 = output
; |   ' 10000010 = switch
; |   ' 10100011 = analogue
; |   ' 10000100 = temperature
; |   ' 10000101 = unltrasonic
; |   ' 10000110 = infrared
; |   ' 10000111 = touch
; |   ' 10001000 = infrared+1
; |                                                                           |
; `---------------------------------------------------------------------------'

SetPinAs:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "a" |  0  | pin |  0  | typ |
  ; `-----^-----^-----^-----^-----^-----'

  b0 = w2
  If bit7 = 0 Then              ; 0------- Unconfigured
    Input w1
    Gosub ClradcMaskBitSub
  Else
    If bit6 = 1 Then            ; 11------ Output
      Output w1
      Gosub ClradcMaskBitSub
    Else
      Input w1
      If bit5 = 0 Then          ; 100----- Input - Digital
        Gosub ClradcMaskBitSub
      Else
        Gosub SetadcMaskBitSub  ; 101----- Input - Analogue
      End If
    End If
  End If

  Goto BlocklyPolling

; *****************************************************************************
; *                                                                           *
; * "b" - I2c Block                                                           *
; *                                                                           *
; *****************************************************************************

; .---------------------------------------------------------------------------.
; | I2C Block Commands                                                        |
; |---------------------------------------------------------------------------|
; |                                                                           |
; | This allows bytes to be written and read from an I2C device               |
; |                                                                           |
; | SendToPicaxe( "b", rxCount, txCount, tx1data, tx2data )                   |
; |                                                                           |
; |                b0  w1.msb   w1.lsb   w2.msb   w2.lsb                      |
; |                                                                           |
; | Send 1 byte, no read : SendToPicaxe( "b", 0, 1, $t1, 0   )                |
; | Send 2 byte, no read : SendToPicaxe( "b", 0, 2, $t1, $t2 )                |
; |                                                                           |
; | Send 0 byte, read N  : SendToPicaxe( "b", N, 0, 0,   0   )                |
; | Send 1 byte, read N  : SendToPicaxe( "b", N, 1, $t1, 0   )                |
; | Send 2 byte, read N  : SendToPicaxe( "b", N, 2, $t1, $t2 )                |
; |                                                                           |
; | The reply packet will have the format of -                                |
; |                                                                           |
; |     [READI2C <w0>,<w1>,<w2>]                                              |
; |                                                                           |
; | Where -                                                                   |
; |                                                                           |
; |     w0.lsb = 1st data byte    w0.msb = 4th data byte                      |
; |     w1.lsb = 2nd data byte    w1.msb = 5th data byte                      |
; |     w2.lsb = 3rd data byte    w2.msb = 6th data byte                      |
; |                                                                           |
; `---------------------------------------------------------------------------'

I2cBlockCommand:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "b" | rdb |  0  |  0  |  0  | "b" - I2C read rdb bytes
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "b" | rdb |  1  | byt |  0  | "b" - I2C write 1 byte, read rdb bytes
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "b" | rdb |  2  | by1 | by2 | "b" - I2C write 2 bytes,read rdb bytes
  ; `-----^-----^-----^-----^-----^-----'

  ; When no bytes read...
  ;
  ; .-----.
  ; | len | Length of packet (3)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "b" | Command
  ; `-----'

  ; When one or more bytes read ...
  ;
  ; .-----.
  ; | len | Length of packet (9)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "b" | Command
  ; |-----|
  ; | $xx | b0
  ; | $xx | b1
  ; | $xx | b2
  ; | $xx | b3
  ; | $xx | b4
  ; | $xx | b5
  ; `-----'

  SetFreq M4
  Select Case w1.lsb
    Case 1 : HI2cOut( w2.msb )
    Case 2 : HI2cOut( w2.msb, w2.lsb )
  End Select
  SetFreq FREQ

  If w1.msb = 0 Then

    SerTxd( 3, TYPE_PICAXE, "b" )

  Else

    w0 = w1.msb
    w1 = 0
    w2 = 0

    SetFreq M4
    Select Case w0
      Case 1 : HI2cIn( b0                     )
      Case 2 : HI2cIn( b0, b1                 )
      Case 3 : HI2cIn( b0, b1, b2             )
      Case 4 : HI2cIn( b0, b1, b2, b3         )
      Case 5 : HI2cIn( b0, b1, b2, b3, b4     )
      Case 6 : HI2cIn( b0, b1, b2, b3, b4, b5 )
    End Select
    SetFreq FREQ

    SerTxd( 9, TYPE_PICAXE, "b", b0, b1, b2, b3, b4, b5 )

  End If

  Goto WaitForCommand

; *****************************************************************************
; *                                                                           *
; * "g" - Read Eeprom / "get eeprom"                                          *
; *                                                                           *
; *****************************************************************************

ReadEeprom:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "g" |  0  | adr |  0  |  0  |
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet (5)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "g" | Command
  ; |-----|
  ; | num | Address
  ; |-----|
  ; | num | Result
  ; `-----'

  Read w1, w2

  SerTxd( 5, TYPE_PICAXE, "g", w1, w2 )

  Goto WaitForCommand

; *****************************************************************************
; *                                                                           *
; * "h" - Read Temperature                                                    *
; *                                                                           *
; *****************************************************************************

ReadTempCommand:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "h" |  0  | pin |  0  |  0  | "h" - ReadTemp12 pin,result
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet (6)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "h" | Command
  ; |-----|
  ; | $xn | Pin, eg $C5 = C.5
  ; |-----|
  ; | msb | Result
  ; | lsb |
  ; `-----'

  ReadTemp12 w1, w2

  SerTxd( 6, TYPE_PICAXE, "h" )

  Goto SendPinInW1PlusResultInW2

; *****************************************************************************
; *                                                                           *
; * "i" - IrIn                                                                *
; *                                                                           *
; *****************************************************************************

IrInCommand:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "i" |  0  | pin |  0  |  0  | Wait for IrIn pin
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "i" |  0  | pin |  timeout  | Wait for IrIn pin with timeout
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet (6)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "i" | Command
  ; |-----|
  ; | $xn | Pin, eg $C5 = C.5
  ; |-----|
  ; | msb | Result
  ; | lsb |
  ; `-----'

  If w2 = 0 Then
    IrIn w1, w2
  Else
    b0 = 128
    IrIn [w2], w1, b0
    w2 = b0
  End If

  SerTxd( 6, TYPE_PICAXE, "i" )

  Goto SendPinInW1PlusResultInW2

; *****************************************************************************
; *                                                                           *
; * "p" - Write Eeprom / "put eeprom"                                         *
; *                                                                           *
; *****************************************************************************

WriteEeprom:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "p" |  0  | adr |  0  | byt |
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet (5)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "w" | Command
  ; |-----|
  ; | num | Address
  ; |-----|
  ; | num | Result
  ; `-----'

  Write w1, w2

  Read  w1, w2

  SerTxd( 5, TYPE_PICAXE, "w", w1, w2 )

  Goto BlocklyPolling

; *****************************************************************************
; *                                                                           *
; * "r" - I2c Eeprom Read                                                     *
; *                                                                           *
; *****************************************************************************

I2cEepromRead:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "r" |    adr    |  0  |  0  |
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet (6)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "r" | Command
  ; |-----|
  ; | msb | Address
  ; | lsb |
  ; |-----|
  ; | num | Result
  ; `-----'

  SetFreq M4
  HI2cIn w1, ( w2 )
  SetFreq FREQ

  SerTxd( 6, TYPE_PICAXE, "r", w1.msb, w1.lsb, w2  )

  Goto WaitForCommand

; *****************************************************************************
; *                                                                           *
; * "s" - I2c Eeprom Setup                                                    *
; *                                                                           *
; *****************************************************************************

I2cEepromSetup:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "s" |  0  |  0  |  0  |  0  | "s" - I2C off
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "s" |  0  | dev |  0  |  0  | "s" - I2C dev,slow,byte
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "s" |  0  | dev |  0  |  1  | "s" - I2C dev,slow,word
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "s" |  0  | dev |  1  |  0  | "s" - I2C dev,fast,byte
  ; `-----^-----^-----^-----^-----^-----'
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "s" |  0  | dev |  1  |  1  | "s" - I2C dev,fast,word
  ; `-----^-----^-----^-----^-----^-----'

  If w1 <> 0 Then
    If w2.msb = 0 Then
      w2.msb = I2CSLOW
    Else
      w2.msb = I2CFAST
    End If
    HI2cSetup I2CMASTER, w1, w2.msb, w2.lsb
  Else
    HI2cSetup OFF
  End If

  Goto BlocklyPolling

; *****************************************************************************
; *                                                                           *
; * "t" - Touch                                                               *
; *                                                                           *
; *****************************************************************************

TouchCommand:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "t" |  0  | pin |  0  |  0  |
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet (6)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "t" | Command
  ; |-----|
  ; | $xn | Pin, eg $C5 = C.5
  ; |-----|
  ; | msb | Result
  ; | lsb |
  ; `-----'

  #IfDef _20X2

    Goto InvalidCommand

  #Else

    #IfDef _isX2
      Gosub GetAdcChannelNumber
      If bit7 <> 0 Then InvalidCommand
      Touch b0, w2
    #Else
      Touch w1, w2
    #EndIf

    SerTxd( 6, TYPE_PICAXE, "t" )

    Goto SendPinInW1PlusResultInW2

  #EndIf

  Goto WaitForCommand

; *****************************************************************************
; *                                                                           *
; * "u" - Ultra                                                               *
; *                                                                           *
; *****************************************************************************

UltraCommand:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "u" |  0  | pin |  0  |  0  |
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet (6)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "u" | Command
  ; |-----|
  ; | $xn | Pin, eg $C5 = C.5
  ; |-----|
  ; | msb | Result
  ; | lsb |
  ; `-----'

  SetFreq FREQ_DEFAULT
  Ultra w1, w2
  SetFreq FREQ

  SerTxd( 6, TYPE_PICAXE, "u" )

  Goto SendPinInW1PlusResultInW2
  
; *****************************************************************************
; *                                                                           *
; * "v" - Ultra 2 pin                                                              *
; *                                                                           *
; *****************************************************************************

UltraCommand2Pin:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "v" | pinT|pinE |  0  |  0  | "v" - Ultra 2 pin,result
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet (6)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "v" | Command
  ; |-----|
  ; | $xn | PinE, eg $C5 = C.5
  ; |-----|
  ; | msb | Result
  ; | lsb |
  ; `-----'

  SetFreq FREQ_DEFAULT
  Ultra w1.msb, w1.lsb, w2
  SetFreq FREQ

  SerTxd( 6, TYPE_PICAXE , "v")
	
  Goto SendPinInW1PlusResultInW2:

; *****************************************************************************
; *                                                                           *
; * "w" - I2c Eeprom Write                                                    *
; *                                                                           *
; *****************************************************************************

I2cEepromWrite:

  ;         b0   w1msb w1lsb w2msb w2lsb
  ; .-----.-----.-----.-----.-----.-----.
  ; | ">" | "w" |    adr    |  0  | byt |
  ; `-----^-----^-----^-----^-----^-----'

  ; .-----.
  ; | len | Length of packet (6)
  ; |-----|
  ; | typ | PICAXE type
  ; |-----|
  ; | "w" | Command
  ; |-----|
  ; | msb | Address
  ; | lsb |
  ; |-----|
  ; | num | Result
  ; `-----'

  SetFreq M4
  HI2cOut w1, ( w2 )
  SetFreq FREQ

  Pause MS_20

  SetFreq M4
  HI2cIn w1, ( w2 )
  SetFreq FREQ

  SerTxd( 6, TYPE_PICAXE, "w", w1.msb, w1.lsb, w2  )

  Goto WaitForCommand

; *****************************************************************************
; *                                                                           *
; * Send Pin (w1) and Result (w2)                                             *
; *                                                                           *
; *****************************************************************************

SendPinInW1PlusResultInW2:

  ; |-----|
  ; | $xn | Pin, eg $C5 = C.5
  ; |-----|
  ; | msb | Result
  ; | lsb |
  ; `-----'

  #IfDef _isM2
    #IfDef _08M2
      b0 = $C0
    #Else
      LookUp w1.bit3, ( $B0, $C0 ), b0
    #EndIf
  #EndIf

  #IfDef _isX2
    #IfDef _20X2
      LookUp w1.bit3, ( $B0, $C0 ), b0
    #Else
      b0 = w1 >> 3 & 3
      Lookup b0, ( $B0, $C0, $A0, $D0 ), b0
    #EndIf
  #EndIf

  b0 = w1 & 7 | b0

  SerTxd( b0, w2.msb, w2.lsb )

  Goto WaitForCommand

; *****************************************************************************
; *                                                                           *
; * ADC Handling                                                              *
; *                                                                           *
; *****************************************************************************

; .---------------------------------------------------------------------------.
; | Set a particular pin for ADC use                                          |
; |---------------------------------------------------------------------------|
; | The pin number is set in w1 0..15 which is used to set the appropriate    |
; | bit in adcMaskCB od adcMaskDA.                                            |
; `---------------------------------------------------------------------------'

SetAdcMaskBitSub:
  #IfDef _isM2
    If w1 < 8 Then
      Read w1, w0
    Else
      w0 = w1 & 7
      Read w0, w0.msb : w0.lsb = 0
    End If
    adcMaskCB = w0 | adcMaskCB & MASK_CB
  #Else
    If w1 <= 15 Then
      adcMaskCB = 1 << w1 | adcMaskCB & MASK_CB
    Else
      w0 = w1 & 15
      adcMaskDA = 1 << w0 | adcMaskDA & MASK_DA
    End If
  #EndIf

SetAdcSetupBitSub:
  #IfDef _isM2
    #IfDef _08M2
      adcSetup = adcSetup | adcMaskC
    #Else
      adcSetup = adcSetup | adcMaskCB
    #EndIf
  #Else
    Gosub GetAdcChannelNumber
    If bit7 = 0 Then
      #IfDef _20X2
        adcSetup = 1 << w0 | adcSetup
      #Else
        If w0 < 16 Then
          adcSetup = 1 << w0 | adcSetup
        Else
          w0 = w0 & 15
          adcSetup2 = 1 << w0 | adcSetup2
        End If
      #EndIf
    End If
  #EndIf
  Return

; .---------------------------------------------------------------------------.
; | Clear a pin after ADC use ( ie, make it digital )                         |
; |---------------------------------------------------------------------------|
; | The pin number is set in w1 0..15 which is used to clear the appropriate  |
; | bit in adcMaskCB or adcMaxkDA.                                            |
; `---------------------------------------------------------------------------'

ClrAdcMaskBitSub:
  #IfDef _isM2
    If w1 < 8 Then
      Read w1, w0
    Else
      w0 = w1 & 7
      Read w0, w0.msb : w0.lsb = 0
    End If
    adcMaskCB = w0 ^ $FFFF & adcMaskCB & MASK_CB
  #Else
    If w1 <= 15 Then
      adcMaskCB = 1 << w1 ^ $FFFF & adcMaskCB & MASK_CB
    Else
      w0 = w1 & 15
      adcMaskDA = 1 << w0 ^ $FFFF & adcMaskDA & MASK_DA
    End If
  #EndIf

ClrAdcSetupBitSub:
  #IfDef _isM2
    #IfDef _08M2
      adcSetup = adcSetup & adcMaskC
    #Else
      adcSetup = adcSetup & adcMaskCB
    #EndIf
  #Else
    Gosub GetAdcChannelNumber
    If bit7 = 0 Then
      #IfDef _20X2
        w0 = 1 << w0
        adcSetup = adcSetup &/ w0
      #Else
        If w0 < 16 Then
          w0 = 1 << w0
          adcSetup = adcSetup &/ w0
        Else
          w0 = w0 & 15
          w0 = 1 << w0
          adcSetup2 = adcSetup2 &/ w0
        End If
      #EndIf
    End If
  #EndIf
  Return

GetAdcChannelNumber:
  w0 = $FF
  #IfDef _20X2
    '        ADC = 0    1    2    3    4    5    6    7    8    9    10
    LookDown w1, ( B.0, B.1, C.7, B.2, B.3, B.4, C.3, C.2, C.1, B.5, B.6 ), w0
  #EndIf
  #IfDef _28X2
    '        ADC = 0    1    2    3    4    5    6    7    8    9    10   11   12   13   14   15   16   17   18   19
    LookDown w1, ( A.0, A.1, A.2, A.3, C.3, $FF, $FF, $FF, B.2, B.3, B.1, B.4, B.0, B.5, C.2, $FF, C.4, C.5, C.6, C.7 ), w0
  #EndIf
  #IfDef _40X2
    '        ADC = 0    1    2    3    4    5    6    7    8    9    10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27
    LookDown w1, ( A.0, A.1, A.2, A.3, C.3, A.5, A.6, A.7, B.2, B.3, B.1, B.4, B.0, B.5, C.2, $FF, C.4, C.5, C.6, C.7, D.0, D.1, D.2, D.3, D.4, D.5, D.6, D.7 ), w0
  #EndIf
  Return

; *****************************************************************************
; *                                                                           *
; * Eeprom data                                                               *
; *                                                                           *
; *****************************************************************************
; *                                                                           *
; * For the M2 parts we use the Eeprom Data to provide a fast lookup table    *
; * of bit masks; 0->$01, 1->$02, up to 7->$80.                               *
; *                                                                           *
; * For the X2 we don't use Eeprom Data so we use a #No_Data to save having   *
; * to download it.                                                           *
; *                                                                           *
; *****************************************************************************

  #IfDef _isM2

    Eeprom 0, ( $01, $02, $04, $08, $10, $20, $40, $80 )

  #Else

    #No_data

  #EndIf

; .---------------------------------------------------------------------------.
; | We add a copyright notice even if that is not downloaded                  |
; `---------------------------------------------------------------------------'

  Eeprom ( "Copyright (C) Revolution Education Limited" )

; *****************************************************************************
; *                                                                           *
; * End of Program                                                            *
; *                                                                           *
; *****************************************************************************

