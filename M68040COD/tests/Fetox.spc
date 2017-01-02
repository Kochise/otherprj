#testing fetox	-- e to the (source)power
#		-- converts the source operand to extended precision (if
#		-- necessary) and calculates e to the power of that number.
#		-- stores the result in the destination floating-point data
#		-- register.


#test fetox of +0

fetox.d 0000_0000_0000_0000 rn x = 3fff00008000000000000000(1) ~N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetox of -0

fetox.d 8000_0000_0000_0000 rn x = 3fff00008000000000000000(1) ~N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetox of inf

fetox.d 7ff0_0000_0000_0000 rn x = 7fff00000000000000000000(inf) ~N ~Z I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetox of -inf

fetox.d fff0_0000_0000_0000 rn x = 000000000000000000000000(0) ~N Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetox of +qnan

fetox.d 7fff_ffff_ffff_ffff rn x = 7fff00007ffffffffffff800(nan0xffffffff) ~N ~Z ~I NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetox of -qnan

fetox.d ffff_ffff_ffff_ffff rn x = ffff00007ffffffffffff800(-nan0xffffffff) N ~Z ~I NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetox of +snan

fetox.d 7ff7_ffff_ffff_ffff rn x snan = 7fff0000c0ffeefacadec0da(nan0x81ffddf5) ~N ~Z ~I NAN ~BSUN SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL TNAN ~TUNIMP ~TUNSUP

#test fetox of -snan

fetox.d fff7_ffff_ffff_ffff rn x snan = 7fff0000c0ffeefacadec0da(nan0x81ffddf5) N ~Z ~I NAN ~BSUN SNAN ~OPERR ~OVFL ~UNFL ~DZ ~INEX2 ~INEX1 AIOP ~AOVFL ~AUNFL ~ADZ ~AINEX Q:00 ~T SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL TNAN ~TUNIMP ~TUNSUP

#test fetox of positive denorm numbers

fetox.d 0000_0000_0000_0001 rn x  = 3fff00008000000000000000(1) ~N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP
fetox.d 0008_0000_0000_0000 rn x  = 3fff00008000000000000000(1) ~N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP
fetox.d 0000_0000_8000_0000 rn x  = 3fff00008000000000000000(1) ~N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP

#test fetox of negative denorm numbers

fetox.d 8000_0000_0000_0001 rn x  = 3fff00008000000000000000(1) ~N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP
fetox.d 8008_0000_0000_0000 rn x  = 3fff00008000000000000000(1) ~N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP
fetox.d 8000_0000_8000_0000 rn x  = 3fff00008000000000000000(1) ~N ~Z ~I ~NAN ~BSUN ~SNAN ~OPERR ~OVFL ~UNFL ~DZ INEX2 ~INEX1 ~AIOP ~AOVFL ~AUNFL ~ADZ AINEX Q:00 ~T ~SIGFPE ~TBSUN ~TINEX ~TDZ ~TUNFL ~TOPERR ~TOVFL ~TNAN ~TUNIMP ~TUNSUP