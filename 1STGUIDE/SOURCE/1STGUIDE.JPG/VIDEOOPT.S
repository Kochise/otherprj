          .IMPORT    screen_rgb
          .IMPORT    plane_size
          .IMPORT    nplanes
          .IMPORT    dithermatrix

          .EXPORT    rgb16_put_pixel_rows
          .EXPORT    rgb24_put_pixel_rows
          .EXPORT    rgb32_put_pixel_rows
          .EXPORT    rgb3_put_pixel_rows
          .EXPORT    rgb8_put_pixel_rows

          .MODULE rgb16_put_pixel_rows

T000000:   MOVEM.L   D3-D4/A2-A6,-(A7)
T000004:   MOVEA.L   (A1)+,A2
T000006:   MOVEA.L   (A1)+,A3
T000008:   MOVEA.L   (A1),A1
T00000A:   LEA.L     screen_rgb,A4
           LEA.L     $0400(A4),A5
           LEA.L     $0800(A4),A6
T000010:   MOVE.W    D0,D2
T000012:   CLR.W     D3
T000014:   MOVE.B    (A2)+,D3
T000016:   LSL.W     #2,D3
T000018:   MOVE.W    (A4,D3.W),D3
T00001C:   CLR.W     D4
T00001E:   MOVE.B    (A3)+,D4
T000020:   LSL.W     #2,D4
T000026:   OR.W      (A5,D4.W),D3
T00002A:   CLR.W     D4
T00002C:   MOVE.B    (A1)+,D4
T00002E:   LSL.W     #2,D4
T000034:   OR.W      (A6,D4.W),D3
T000038:   MOVE.W    D3,(A0)+
T00003A:   SUBQ.W    #1,D2
T00003C:   BGT.B     T000012
T00003E:   SUB.W     D0,D2
T000040:   AND.W     #$000F,D2
T000044:   ADDA.W    D2,A2
T000046:   ADDA.W    D2,A3
T000048:   ADDA.W    D2,A1
T00004A:   ADD.W     D2,D2
T00004C:   ADDA.W    D2,A0
T00004E:   SUBQ.W    #1,D1
T000050:   BGT.B     T000010
T000052:   MOVEM.L   (A7)+,D3-D4/A2-A6
T000056:   RTS

          .ENDMOD

          .MODULE rgb24_put_pixel_rows

T000000:   MOVEM.L   D3-D4/A2-A6,-(A7)
T000004:   MOVEA.L   (A1)+,A2
T000006:   MOVEA.L   (A1)+,A3
T000008:   MOVEA.L   (A1),A1
T00000A:   LEA.L     screen_rgb,A4
           LEA.L     $0400(A4),A5
           LEA.L     $0800(A4),A6
T000010:   MOVE.W    D0,D2
T000012:   CLR.W     D3
T000014:   MOVE.B    (A2)+,D3
T000016:   LSL.W     #2,D3
T000018:   MOVE.L    (A4,D3.W),D3
T00001C:   CLR.W     D4
T00001E:   MOVE.B    (A3)+,D4
T000020:   LSL.W     #2,D4
T000026:   OR.L      (A5,D4.W),D3
T00002A:   CLR.W     D4
T00002C:   MOVE.B    (A1)+,D4
T00002E:   LSL.W     #2,D4
T000034:   OR.L      (A6,D4.W),D3
           ROL.L     #8,D3
T000042:   MOVE.B    D3,(A0)+
           ROL.L     #8,D3
T000044:   MOVE.B    D3,(A0)+
           ROL.L     #8,D3
T000046:   MOVE.B    D3,(A0)+
T000048:   SUBQ.W    #1,D2
T00004A:   BGT.B     T000012
T00004C:   SUB.W     D0,D2
T00004E:   AND.W     #$000F,D2
T000052:   ADDA.W    D2,A2
T000054:   ADDA.W    D2,A3
T000056:   ADDA.W    D2,A1
T000058:   ADDA.W    D2,A0
T00005A:   ADD.W     D2,D2
T00005C:   ADDA.W    D2,A0
T00005E:   SUBQ.W    #1,D1
T000060:   BGT.B     T000010
T000062:   MOVEM.L   (A7)+,D3-D4/A2-A6
T000066:   RTS

          .ENDMOD

          .MODULE rgb32_put_pixel_rows

T000000:   MOVEM.L   D3-D4/A2-A6,-(A7)
T000004:   MOVEA.L   (A1)+,A2
T000006:   MOVEA.L   (A1)+,A3
T000008:   MOVEA.L   (A1),A1
T00000A:   LEA.L     screen_rgb,A4
           LEA.L     $0400(A4),A5
           LEA.L     $0800(A4),A6
T000010:   MOVE.W    D0,D2
T000012:   CLR.W     D3
T000014:   MOVE.B    (A2)+,D3
T000016:   LSL.W     #2,D3
T000018:   MOVE.L    (A4,D3.W),D3
T00001C:   CLR.W     D4
T00001E:   MOVE.B    (A3)+,D4
T000020:   LSL.W     #2,D4
T000026:   OR.L      (A5,D4.W),D3
T00002A:   CLR.W     D4
T00002C:   MOVE.B    (A1)+,D4
T00002E:   LSL.W     #2,D4
T000034:   OR.L      (A6,D4.W),D3
T000038:   MOVE.L    D3,(A0)+
T00003A:   SUBQ.W    #1,D2
T00003C:   BGT.B     T000012
T00003E:   SUB.W     D0,D2
T000040:   AND.W     #$000F,D2
T000044:   ADDA.W    D2,A2
T000046:   ADDA.W    D2,A3
T000048:   ADDA.W    D2,A1
T00004A:   LSL.W     #2,D2
T00004C:   ADDA.W    D2,A0
T00004E:   SUBQ.W    #1,D1
T000050:   BGT.B     T000010
T000052:   MOVEM.L   (A7)+,D3-D4/A2-A6
T000056:   RTS

          .ENDMOD

          .MODULE rgb3_put_pixel_rows

T000000:   MOVEM.L   D3-D7/A2-A6,-(A7)
T00000E:   MOVE.L    plane_size,D2
T000014:   MOVE.W    nplanes,D3
T00001A:   LEA.L     dithermatrix,A3
           LEA.L     $0100(A3),A6
T000020:   MOVEA.L   (A1)+,A4
T000022:   MOVEA.L   (A1)+,A5
T000024:   MOVEA.L   (A1),A1
T000026:   MOVE.W    D0,D4
T00002A:   MOVE.W    #$8000,D5
T00002E:   MOVE.B    (A3)+,D7
T000030:   CLR.B     D6
T000032:   CMP.B     (A4)+,D7
T000034:   BCC.B     T000038
T000036:   ADDQ.B    #4,D6
T000038:   CMP.B     (A5)+,D7
T00003E:   BCC.B     T000042
T000040:   ADDQ.B    #2,D6
T000042:   CMP.B     (A1)+,D7
T000044:   BCC.B     T000048
T000046:   ADDQ.B    #1,D6
T000048:   SUBQ.B    #7,D6
T00004A:   BEQ.B     T000074
T00004C:   MOVEA.L   A0,A2
T00004E:   ADDQ.B    #7,D6
T000050:   BNE.B     T00005E
T000052:   MOVE.B    D3,D6
T000054:   OR.W      D5,(A2)
T000056:   ADDA.L    D2,A2
T000058:   SUBQ.B    #1,D6
T00005A:   BGT.B     T000054
T00005C:   BRA.B     T000074
T00005E:   LSL.B     #5,D6
T000060:   BPL.B     T000064
T000062:   OR.W      D5,(A2)
T000064:   ADDA.L    D2,A2
T000066:   ADD.B     D6,D6
T000068:   BPL.B     T00006C
T00006A:   OR.W      D5,(A2)
T00006C:   ADD.B     D6,D6
T00006E:   BPL.B     T000074
T000070:   OR.W      D5,(A2,D2.L)
T000074:   SUBQ.W    #1,D4
T000076:   BLE.B     T000084
T000078:   ROR.W     #1,D5
T00007A:   BPL.B     T00002E
T00007C:   LEA.L     -$0010(A3),A3
T000080:   ADDQ.W    #2,A0
T000082:   BRA.B     T00002E
T000084:   ADDQ.W    #2,A0
T000086:   SUB.W     D0,D4
T00008C:   AND.W     #$000F,D4
T00008E:   ADDA.W    D4,A3
T000090:   ADDA.W    D4,A4
T000092:   ADDA.W    D4,A5
T000094:   ADDA.W    D4,A1
T000096:   CMPA.L    A6,A3
T00009C:   BNE.B     T0000A2
T00009E:   LEA.L     -$0100(A3),A3
T0000A2:   SUBQ.W    #1,D1
T0000A6:   BGT       T000026
T0000AC:   MOVEM.L   (A7)+,D3-D7/A2-A6
T0000B0:   RTS

          .ENDMOD

          .MODULE rgb8_put_pixel_rows

T000000:   MOVEM.L   D3-D7/A2-A6,-(A7)
T000006:   MOVEA.W   D0,A5
T00000C:   MOVE.L    plane_size,D2
T000012:   LEA.L     dithermatrix,A3
           LEA.L     $0100(A3),A6
T000018:   MOVEA.L   (A1)+,A4
T00001A:   MOVEA.L   (A1)+,A2
T00001C:   MOVEA.L   (A1),A1
T00001E:   MOVE.W    A5,D3
T000022:   MOVE.W    #$8000,D4
T000026:   MOVE.L    D2,D0
T000028:   LSL.L     #3,D0
T00002A:   ADDA.L    D0,A0
T00002C:   MOVE.B    (A3)+,D5
T00002E:   CLR.B     D7
T000030:   CLR.W     D0
T000032:   MOVE.B    (A4)+,D0
T000034:   MOVE.W    D0,D6
T000036:   LSL.W     #2,D6
T000038:   ADD.W     D6,D0
T00003A:   CMP.B     D5,D0
T00003C:   BLS.B     T000040
T00003E:   ADDQ.B    #1,D7
T000040:   ASR.W     #8,D0
T000042:   ADD.B     D0,D7
T000044:   MOVE.B    D7,D6
T000046:   ADD.B     D6,D6
T000048:   ADD.B     D6,D7
T00004A:   ADD.B     D7,D7
T00004C:   CLR.W     D0
T00004E:   MOVE.B    (A2)+,D0
T000050:   MOVE.W    D0,D6
T000052:   LSL.W     #2,D6
T000054:   ADD.W     D6,D0
T000056:   CMP.B     D5,D0
T000058:   BLS.B     T00005C
T00005A:   ADDQ.B    #1,D7
T00005C:   ASR.W     #8,D0
T00005E:   ADD.B     D0,D7
T000060:   MOVE.B    D7,D6
T000062:   ADD.B     D6,D6
T000064:   ADD.B     D6,D7
T000066:   ADD.B     D7,D7
T000068:   CLR.W     D0
T00006A:   MOVE.B    (A1)+,D0
T00006C:   MOVE.W    D0,D6
T00006E:   LSL.W     #2,D6
T000070:   ADD.W     D6,D0
T000072:   CMP.B     D5,D0
T000074:   BLS.B     T000078
T000076:   ADDQ.B    #1,D7
T000078:   ASR.W     #8,D0
T00007A:   ADD.B     D0,D7
T00007C:   SUBA.L    D2,A0
T00007E:   ADD.B     #$20,D7
T000082:   BPL.B     T000086
T000084:   OR.W      D4,(A0)
T000086:   SUBA.L    D2,A0
T000088:   ADD.B     D7,D7
T00008A:   BPL.B     T00008E
T00008C:   OR.W      D4,(A0)
T00008E:   SUBA.L    D2,A0
T000090:   ADD.B     D7,D7
T000092:   BPL.B     T000096
T000094:   OR.W      D4,(A0)
T000096:   SUBA.L    D2,A0
T000098:   ADD.B     D7,D7
T00009A:   BPL.B     T00009E
T00009C:   OR.W      D4,(A0)
T00009E:   SUBA.L    D2,A0
T0000A0:   ADD.B     D7,D7
T0000A2:   BPL.B     T0000A6
T0000A4:   OR.W      D4,(A0)
T0000A6:   SUBA.L    D2,A0
T0000A8:   ADD.B     D7,D7
T0000AA:   BPL.B     T0000AE
T0000AC:   OR.W      D4,(A0)
T0000AE:   SUBA.L    D2,A0
T0000B0:   ADD.B     D7,D7
T0000B2:   BPL.B     T0000B6
T0000B4:   OR.W      D4,(A0)
T0000B6:   SUBA.L    D2,A0
T0000B8:   ADD.B     D7,D7
T0000BA:   BPL.B     T0000BE
T0000BC:   OR.W      D4,(A0)
T0000BE:   SUBQ.W    #1,D3
T0000C0:   BLE.B     T0000D2
T0000C2:   ROR.W     #1,D4
T0000C4:   BPL       T000026
T0000C8:   LEA.L     -$0010(A3),A3
T0000CC:   ADDQ.W    #2,A0
T0000CE:   BRA       T000026
T0000D2:   ADDQ.W    #2,A0
T0000D4:   SUB.W     A5,D3
T0000D8:   AND.W     #$000F,D3
T0000DC:   ADDA.W    D3,A3
T0000DE:   ADDA.W    D3,A4
T0000E0:   ADDA.W    D3,A2
T0000E2:   ADDA.W    D3,A1
T0000E4:   CMPA.L    A6,A3
T0000EA:   BNE.B     T0000F0
T0000EC:   LEA.L     -$0100(A3),A3
T0000F0:   SUBQ.W    #1,D1
T0000F2:   BGT       T00001E
T0000F8:   MOVEM.L   (A7)+,D3-D7/A2-A6
T0000FC:   RTS

          .ENDMOD
