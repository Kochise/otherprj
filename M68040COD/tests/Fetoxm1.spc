#testing fetoxm1-- e to the (source)power -1
#		-- converts the source operand to extended precision (if
#		-- necessary) and calculates e to the power of that number.
#		-- then, subtracts one from that value.
#		-- stores the result in the destination floating-point data
#		-- register.


#test fetoxm1 of +0

fetoxm1.d 0000_0000_0000_0000 rn x = 000000000000000000000000(0) ~N Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetoxm1 of -0

fetoxm1.d 8000_0000_0000_0000 rn x = 800000000000000000000000(0) N Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetoxm1 of inf

fetoxm1.d 7ff0_0000_0000_0000 rn x = 7fff00000000000000000000(inf) ~N ~Z I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetoxm1 of -inf

fetoxm1.d fff0_0000_0000_0000 rn x = bfff00008000000000000000(-1) N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetoxm1 of +qnan

fetoxm1.d 7fff_ffff_ffff_ffff rn x = 7fff00007ffffffffffff800(nan0xffffffff) ~N ~Z ~I NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetoxm1 of -qnan

fetoxm1.d ffff_ffff_ffff_ffff rn x = ffff00007ffffffffffff800(-nan0xffffffff) N ~Z ~I NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetoxm1 of +snan

fetoxm1.d 7ff7_ffff_ffff_ffff rn x snan = 7fff0000c0ffeefacadec0da(nan0x81ffddf5) ~N ~Z ~I NAN ~BSUN SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL TNAN ~TUNIMP ~TUNSUP

#test fetoxm1 of -snan

fetoxm1.d fff7_ffff_ffff_ffff rn x snan = 7fff0000c0ffeefacadec0da(nan0x81ffddf5) N ~Z ~I NAN ~BSUN SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL TNAN ~TUNIMP ~TUNSUP

#test fetoxm1 of positive denorm numbers

fetoxm1.d 0000_0000_0000_0001 rn x  = 3bcd00008000000000000000(0) ~N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP
fetoxm1.d 0008_0000_0000_0000 rn x  = 3c0000008000000000000000(0) ~N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP
fetoxm1.d 0000_0000_8000_0000 rn x  = 3bec00008000000000000000(0) ~N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetoxm1 of negative denorm numbers

fetoxm1.d 8000_0000_0000_0001 rn x  = bbcd00008000000000000000(0) N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP
fetoxm1.d 8008_0000_0000_0000 rn x  = bc0000008000000000000000(0) N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP
fetoxm1.d 8000_0000_8000_0000 rn x  = bbec00008000000000000000(0) N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP
