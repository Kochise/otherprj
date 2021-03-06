;****************************************************************
;		Pr�paration de l'�cran.
;****************************************************************
;----------------------------------------------------------------
;		Initialisation de l'�cran.
;----------------------------------------------------------------
Scr_init:	move		ccr,-(sp)
		movem.l		d0-d7/a0-a6,-(sp)

		jsr		Set_super

		lea		Scr_inf_buf,a6
		movea.l		(scr_inf.pb_addr.w,a6),a5 ; Adresse du bloc de param�tres.

;		Si l'�cran a d�j� �t� initialis�, on le lib�re.
		move.l		(scr_inf.fgs.w,a6),d7
		btst.l		#scr_inf_init_fg,d7
		beq.s		Scr_init_ok00
		bsr		Scr_free
Scr_init_ok00:

;		Type de moniteur actuellement connect�.
		moveq		#0,d0
		move.b		$ff8006,d0
		lsr.b		#6,d0
		move.w		d0,(scr_inf.monitor.a6)



;		Efface les �crans.
		btst.l		#scr_pb_cls_fg,d6 ; Doit-on effacer les �crans ?
		beq.s		Init_scr_ok1
		movea.l		Screens,a0
		move.l		Scr_size,d0
		move.w		(scr_pb.nb.w,a6),d1
		bra.s		Init_scr_lp_ok1
Init_scr_lp1:	bsr		Cls
		adda.l		d0,a0
Init_scr_lp_ok1: dbf		d1,Init_scr_lp1
Init_scr_ok1:


;		Initialisation du scrolling.
		btst.l		#scr_pb_set_scroll_fg,d6
		beq.s		Init_scr_ok3
		bsr		Init_scroll
Init_scr_ok3:

		move.l		d7,Scr_fgs

Init_scr_end:	movem.l		(sp)+,d0-d7/a0-a6
		bset		#2,(1.w,sp)
		rtr
Init_scr_err:	movem.l		(sp)+,d0-d7/a0-a6
		bclr		#2,(1.w,sp)
		rtr

;----------------------------------------------------------------
;		Positionne l'�cran.
;----------------------------------------------------------------
Set_scr:	movem.l		d0-d7/a0-a6,-(sp)

;		Positionne l'adresse de l'�cran et change la r�solution avec les routines syst�mes.
		VsetScreen	d5,#3,Physic_scr,Logic_scr
		move.l		Physic_scr,d0
		bsr		Set_scr_addr ; A cause d'NVDI.

;		Affichage de la palette.
		btst.l		#scr_pb_pal_fg,d6
		beq.s		Init_scr_ok2
		move.l		(scr_pb.pal_addr.w,a6),a0 ; Adresse de la palette.
		moveq		#0,d0 ; Commence � l'entr�e 0.
		moveq		#0,d1 ; Toutes les entr�es possibles.
		bsr		Set_pal
		bset.l		#scr_pb_pal_fg,d7
Init_scr_ok2:

		movem.l		(sp)+,d0-d7/a0-a6
		rts

;----------------------------------------------------------------
;		Routine de calcul et de r�servation de la m�moire n�cessaire
;�/aux �cran(s).
; -a6: pointe sur une structure scr_pb.
;----------------------------------------------------------------
Reserve_scr:	move		ccr,-(sp)
		movem.l		d0-d7/a0-a6,-(sp)

		move.l		Scr_fgs,d7
		move.l		(scr_pb.fgs.w,a6),d6

;		V�rifie si des �crans ont d�j� �t� reserv�s. Si c'est le cas,
;la m�moire est lib�r�e.
		btst.l		#scr_pb_reserve_fg,d7
		beq.s		Reserve_scr_ok0
		bsr		Free_scr
Reserve_scr_ok0: 


;		Calcul de la taille m�moire � r�server.
		moveq		#0,d1 ; Taille � 0.

; Calcul de la taille de la table de lignes.
		btst.l		#scr_pb_ln_tbl_fg,d6 ; Doit-on utiliser une table de lignes.
		beq.s		Reserve_scr_ok1
		move.w		Yrez,d1 ; Nombre de lignes.
		lsl.l		#2,d1 ; *4: taille de la table de lignes.
		bset.l		#scr_pb_ln_tbl_fg,d7 ; Ok pour la table.
Reserve_scr_ok1:

; Calcul de la taille des �crans.
		btst.l		#scr_pb_reserve_fg,d6
		beq.s		Reserve_scr_ok2

		move.l		Scr_size,d4 ; Taille de l'�cran.
		move.w		(scr_pb.nb.w,a6),d3 ; Nombre d'�crans.
		move.w		d3,Scr_nb
		ext.l		d3
		beq.s		Reserve_scr_ok2 ; Si 0, pas d'�cran.
		move.l		d4,d5
		mulu.l		d3,d5 ; Taille totale des �crans.
		add.l		d5,d1 ; Taille totale avec table de lignes.
Reserve_scr_ok2:

; R�servation de la m�moire.
		moveq		#0,d0 ; Pour l'adresse Screens.
		tst.l		d1 ; Il y a-t-il qelque chose � r�server?
		beq.s		Reserve_scr_ok3
		Malloc		d1 ; R�servation.
		tst.l		d0
		bmi		Reserve_scr_err
		bset.l		#scr_pb_reserve_fg,d7
Reserve_scr_ok3:


;		Fixe les adresses.
		move.l		d0,Screens ; Adresses des �crans.
; Ecran logique.
		move.l		d0,d1
		add.l		d4,d1
		move.l		d1,Logic_scr ; Adresse de l'�cran logique.
		cmpi.w		#2,d3 ; 2 ou moins de 2 �crans?
		bge.s		Reserve_scr_ok40
		move.l		d0,Logic_scr ; Adresse de l'�cran logique=adresse de l'�cran physique.
Reserve_scr_ok40:
; Ecran physique.
		move.l		d0,Physic_scr ; Adresse de l'�cran physique.
		cmpi.w		#1,d3 ; 1 ou pas d'�cran?
		bge.s		Reserve_scr_ok41
		move.l		Sav_physic_scr,Physic_scr ; Adresse de l'�cran physique.
		move.l		Sav_logic_scr,Logic_scr
Reserve_scr_ok41:

; Table de lignes.
		btst.l		#scr_pb_ln_tbl_fg,d7
		beq.s		Reserve_scr_ok42
		add.l		d5,d0
		move.l		d0,Ln_tbl ; Adresse de la table de lignes.

;		Calcul des offsets des lignes par rapport au d�but de l'�cran.
		movea.l		d0,a0 ; Adresse de la table.
		moveq		#0,d0 ; Offset � 0.
		move.l		Ln_size,d1 ; Taille d'une ligne.
		move.w		Yrez,d2 ; Nombre de lignes.
		bra.s		Reserve_scr_lp_ok
Reserve_scr_lp: move.l		d0,(a0)+
		add.l		d1,d0
Reserve_scr_lp_ok: dbf		d2,Reserve_scr_lp
Reserve_scr_ok42:

Reserve_scr_end: move.l		d7,Scr_fgs
		movem.l		(sp)+,d0-d7/a0-a6
		bset		#2,(1.w,sp) ; Z=1: OK.
		rtr
Reserve_scr_err: move.l		d7,Scr_fgs
		movem.l		(sp)+,d0-d7/a0-a6
		bclr		#2,(1.w,sp) ; Z=0: erreur.
		rtr

;----------------------------------------------------------------
;		Changement de r�solution.
;----------------------------------------------------------------

;Set_rez:	move		ccr,-(sp)
;		movem.l		d0-d7/a0,-(sp)

; Fixe VC0.
;		move.w		Pixel_width,d0
;		bmi.s		.Set_rez_err
;		cmpi.w		#2,d0
;		bgt.s		.Set_rez_err
;		move.w		d0,d1
;		lsl.w		#2,d1
;		tst.b		Interlace_fg
;		beq.s		.Set_rez_VCO0
;		ori.w		#%10,d1 ; Interlace Mode.
;.Set_rez_VCO0:	tst.b		Ln_double_fg
;		beq.s		.Set_rez_VCO1
;		ori.w		#%1,d1
;		move.w		d1,VCO
;.Set_rez_VCO1:

;		move.w		Physic_Xrez,d1
;		bmi.s		.Set_rez_err
; Fixe HHT.
;		tst.b		VGA_fg
;		beq.s		Set_rez_HHT0
;		lea		Video_datas_VGA,a0 ; Donn�es video VGA.
;		bra.s		.Set_rez_HHT2
;Set_rez_HHT0:	tst.b		PAL_fg
;		beq.s		Set_rez_HHT1
;		lea		Video_datas_PAL,a0 ; Donn�es video PAL.
;		bra.s		.Set_rez_HHT2
;Set_rez_HHT1:	lea		Video_datas_NTSC,a0 ; Donn�es video NTSC.
;.Set_rez_HHT2:	
		

;		movem.l		(sp)+,d0-d7/a0
;		bset		#2,(1.w,sp)
;		rtr
;.Set_rez_err:	movem.l		(sp)+,d0-d7/a0
;		bclr		#2,(1.w,sp)
;		rtr
;****************************************************************


;****************************************************************
;		Sauvegarde et restauration de l'�cran.
;****************************************************************
;----------------------------------------------------------------
;		Sauvegarde de l'�cran.
;----------------------------------------------------------------
Save_scr:	movem.l		d0-d7/a0-a6,-(sp)
		Physbase
		move.l		d0,Sav_physic_scr ; Sauve l'adresse de l'�cran physique.

		Logbase
		move.l		d0,Sav_logic_scr ; Sauve l'adresse de l'�cran logique.

		VsetMode	#-1
		move.w		d0,Sav_scr_mode ; Sauve le mode �cran.

		movem.l		$ff8240,d0-d7 ; Sauve palette ST.
		movem.l		d0-d7,Sav_pal16

		lea		$ff9800,a0 ; Sauve palette FALCON.
		lea		Sav_pal256,a1
		move.w		#256-1,d7
.Sav_pal256_lp:	move.l		(a0)+,(a1)+
		dbf		d7,.Sav_pal256_lp

		st		Scr_saved ; Ecran sauvegard�.
		movem.l		(sp)+,d0-d7/a0-a6
		rts

;----------------------------------------------------------------
;		Restoration de l'�cran.
;----------------------------------------------------------------
Restore_scr:	movem.l		d0-d7/a0-a6,-(sp)
		VsetScreen	Sav_scr_mode,#3,Sav_logic_scr,Sav_physic_scr

		bsr		Free_scr

		movem.l		Sav_pal16,d0-d7 ; R�tablit palette ST.
		movem.l		d0-d7,$ff8240

		lea		$ff9800,a0 ; R�tablit palette FALCON.
		lea		Sav_pal256,a1
		move.w		#256-1,d7
.Rstr_pal256_lp: move.l		(a1)+,(a0)+
		dbf		d7,.Rstr_pal256_lp

		dc.w		$a009
		movem.l		(sp)+,d0-d7/a0-a6
		rts

;		Lib�ration de la m�moire des �crans.
Free_scr:	movem.l		d0-d7/a0-a6,-(sp)
		Mfree		Screens
		move.l		Scr_fgs,d0
		bclr.l		#scr_pb_reserve_fg,d0
		bclr.l		#scr_pb_cls_fg,d0
		bclr.l		#scr_pb_ln_tbl_fg,d0
		bclr.l		#scr_pb_reserve_fg,d0
		move.l		d0,Scr_fgs
		movem.l		(sp)+,d0-d7/a0-a6
		rts

;----------------------------------------------------------------
;		Sauvegarde des param�tres de l'�cran.
;----------------------------------------------------------------
Sav_pal16:	ds.w		16
Sav_pal256:	ds.l		256
Sav_physic_scr:	dc.l		0
Sav_logic_scr:	dc.l		0
Sav_scr_mode:	dc.w		0
Scr_saved:	dc.b		0 ; Si $ff, atteste la sauvegarde de l'�cran.
		even
;****************************************************************


;****************************************************************
;		Routines secondaires.
;****************************************************************
;----------------------------------------------------------------
;		Positionne l'adresse de l'�cran � l'adresse contenue dans d0.
;----------------------------------------------------------------
Set_scr_addr:	move.l		d1,-(sp)
		move.l		d0,d1
		swap		d1
		move.b		d1,$ff8201
		swap		d1
		lsr.l		#8,d1
		move.b		d1,$ff8203
		move.b		d0,$ff820d
		move.l		(sp)+,d1
		rts

;----------------------------------------------------------------
;		Modification de la palette de couleurs.
; -a0: adresse de la palette � afficher.
; -d0: num�ro de la premi�re entr�e de la palette � changer.
; -d1: nombre d'entr�es de la palette � changer.
; Le nombre d'entr�es varie selon la r�solution: il est �gal � 2^n o� n est
;le nombre de plans. Les num�ros des entr�es sont compris entre 0 et 2^n-1.
; Si le nombre d'entr�es est �gal ou inf�rieur � 0, toutes les entr�es
;possibles dans la r�solution actuelle seront chang�es.
;----------------------------------------------------------------
Set_pal:	movem.l		d0-d7/a0-a6,-(sp)

		move.l		Scr_mode_status_fgs,d7
		lea		$ff9800,a1 ; Adresse hardware Falcon.
		move.w		#255,d2 ; Nombre d'entr�es maximum=256.
		btst.l		#scr_st_comp_fg,d7 ; Mode compatible?
		beq.s		Set_pal_ok0
		lea		$ff8240,a1 ; Adresse hardware ST.
		moveq		#15,d2 ; Nombre d'entr�es maximum=16.
Set_pal_ok0:

; Si le nombre d'entr�es est inf�rieur ou �gal � 0, on met le nombre max d'entr�es
;disponibles dans la r�solution.
		subq.w		#1,d1
		bmi.s		Set_pal_ok1
		move.w		d2,d1
Set_pal_ok1:

; Clipping du nombre d'entr�es � afficher.
		cmp.w		d2,d1 ; Plus d'entr�e � changer
		bgt.s		Set_pal_ok2 ; que possible?
		move.w		d2,d1 ; Alors met le max.
Set_pal_ok2:	sub.w		d0,d2 ; Diff�rence entre le nbr d'entr�es
		cmp.w		d2,d1 ; max et la premi�re entr�e.
		ble.s		Set_pal_ok3 ; Si >,
		move.w		d2,d1 ; alors met le max.
Set_pal_ok3:

; Affichage de la palette.
		lea		(a1,d0.w*4),a1
Set_pal_lp:	btst.l		#scr_st_comp_fg,d7 ; Conversion de l'entr�e Falcon
		beq.s		Set_pal_lp_ok0 ; en entr�e ST?
		move.l		(a0)+,d0
		bsr		Conv_to_ST_pal ; Concersion.
		move.w		d0,(a1)+ ; Change l'entr�e ST.
		bra.s		Set_pal_lp_ok
Set_pal_lp_ok0:	move.l		(a0)+,(a1)+ ; Change l'entr�e Falcon.
Set_pal_lp_ok:	dbf		d1,Set_pal_lp

Set_pal_end:	movem.l		(sp)+,d0-d7/a0-a6
		rts

;----------------------------------------------------------------
;		Lecture de la palette de couleurs au format Falcon.
; -a0: adresse du buffer pour recevoir la palette.
; -d0: num�ro de la premi�re entr�e de la palette � changer.
; -d1: nombre d'entr�es de la palette � lire.
; Si le nombre d'entr�es est �gal ou inf�rieur � 0, toutes les entr�es
;possibles dans la r�solution actuelle seront lues.
;----------------------------------------------------------------
Get_pal:	movem.l		d0-d7/a0-a6,-(sp)

		move.l		Scr_mode_status_fgs,d7
		lea		$ff9800,a1 ; Adresse hardware Falcon.
		move.w		#255,d2 ; Nombre d'entr�es maximum=256.
		btst.l		#scr_st_comp_fg,d7 ; Mode compatible?
		beq.s		Get_pal_ok0
		lea		$ff8240,a1 ; Adresse hardware ST.
		moveq		#15,d2 ; Nombre d'entr�es maximum=16.
Get_pal_ok0:

; Si le nombre d'entr�es est inf�rieur ou �gal � 0, on met le nombre max d'entr�es
;disponibles dans la r�solution.
		subq.w		#1,d1
		bmi.s		Get_pal_ok1
		move.w		d2,d1
Get_pal_ok1:

; Clipping du nombre d'entr�es � lire.
		cmp.w		d2,d1 ; Plus d'entr�e � lire
		bgt.s		Get_pal_ok2 ; que possible?
		move.w		d2,d1 ; Alors met le max.
Get_pal_ok2:	sub.w		d0,d2 ; Diff�rence entre le nbr d'entr�es
		cmp.w		d2,d1 ; max et la premi�re entr�e.
		ble.s		Get_pal_ok3 ; Si >,
		move.w		d2,d1 ; alors met le max.
Get_pal_ok3:

; Lecture de la palette.
		lea		(a1,d0.w*4),a1
Get_pal_lp:	btst.l		#scr_st_comp_fg,d7 ; Conversion de l'entr�e Falcon
		beq.s		Get_pal_lp_ok0 ; en entr�e ST?
		move.w		(a1)+,d0
		bsr		Conv_to_Flc_pal ; Concersion.
		move.l		d0,(a0)+ ; Change l'entr�e ST.
		bra.s		Get_pal_lp_ok
Get_pal_lp_ok0:	move.l		(a1)+,(a0)+ ; Change l'entr�e Falcon.
Get_pal_lp_ok:	dbf		d1,Get_pal_lp

Get_pal_end:	movem.l		(sp)+,d0-d7/a0-a6
		rts


;----------------------------------------------------------------
;		Convertit une entr�e palette Falcon en entr�e palette ST.
; Input:
; -d0=entr�e au format Falcon � convertir(L).
; Output:
; -d0=entr�e convertit au format ST(W).
;----------------------------------------------------------------
Conv_to_ST_pal:	move.l		d1,-(sp)
		move.l		d0,d1
		lsr.w		#4,d0 ; Composante bleue.
		swap		d1
		lsr.l		#4,d1
		bfins		d1,d0{31-3:4} ; Composante verte.
		lsr.l		#8,d1
		bfins		d1,d0{31-7:4} ; Composante rouge.
		move.l		(sp)+,d1
		rts

;----------------------------------------------------------------
;		Convertit une entr�e palette ST en entr�e palette Falcon.
; Input:
; -d0=entr�e au format ST � convertir(W).
; Output:
; -d0=entr�e convertit au format Falcon(L).
;----------------------------------------------------------------
Conv_to_Flc_pal: move.l		d1,-(sp)
		move.w		d0,d1
		moveq		#0,d0
		bfins		d1,d0{31-7:4}
		lsr.w		#4,d1
		bfins		d1,d0{31-23:4} ; Composante verte.
		lsr.l		#4,d1
		bfins		d1,d0{31-31:4} ; Composante rouge.
		move.l		(sp)+,d1
		rts

;----------------------------------------------------------------
;		Gestion du scrolling: programmation des adresses hardware.
;----------------------------------------------------------------
Set_scroll:	movem.l		d0-d7/a0-a6,-(sp)
;		move.l		Scr_fgs,d7
;		btst.l		#scr_pb_scroll_fg,d7
;		beq		Set_scroll_end

; Clipping X.
		move.w		Scroll_X,d0
		cmp.w		Scroll_Xmin,d0
		bge.s		Set_scroll_ok00
		move.w		Scroll_Xmin,d0
		move.w		d0,Scroll_X
Set_scroll_ok00: cmp.w		Scroll_Xmax,d0
		ble.s		Set_scroll_ok01
		move.w		Scroll_Xmax,d0
		move.w		d0,Scroll_X
Set_scroll_ok01
; Cipping Y.
		move.w		Scroll_Y,d1
		cmp.w		Scroll_Ymin,d1
		bge.s		Set_scroll_ok10
		move.w		Scroll_Ymin,d1
		move.w		d1,Scroll_Y
Set_scroll_ok10: cmp.w		Scroll_Ymax,d1
		ble.s		Set_scroll_ok11
		move.w		Scroll_Ymax,d1
		move.w		d1,Scroll_Y
Set_scroll_ok11:

;		Programmation des registres.
		move.w		Virtual_Xrez,d3
		move.w		Scr_mode_bpp,d4
		mulu.w		d4,d3
		lsr.l		#4,d3 ; Largeur virtuelle en mots.
		cmp.w		#16,d4
		blt.s		Set_scroll_pln
; True Color.
		clr.w		$ff8264 ; Horizontal Scroll Register.
		bra.s		Set_scroll_ok
; Modes plan.
Set_scroll_pln:	move.w		d0,d2
		andi.w		#$f,d2 ; Modulo 16.
		move.w		d2,$ff8264 ; Horizontal Scroll Register.
		beq.s		Set_scroll_ok
		sub.w		d4,d3
Set_scroll_ok:	move.w		d3,$ff820e ; Line width.

;		Calcul de l'offset sur l'�cran.
		ext.l		d1
		mulu.l		Ln_size,d1
		mulu.w		d4,d0
		lsr.l		#3,d0 ; /8.
		add.l		d1,d0
		move.l		d0,Scroll_scr ; Offset sur l'�cran.

Set_scroll_end:	movem.l		(sp)+,d0-d7/a0-a6
		rts

;----------------------------------------------------------------
;		Initialisation du scrolling.
;�/aux �cran(s).
; -a6: pointe sur une structure scr_pb.
;----------------------------------------------------------------
Init_scroll:	move		ccr,-(sp)
		movem.l		d0-d7/a0-a5,-(sp)

		move.l		Scr_fgs,d7
		move.l		(scr_pb.fgs.w,a6),d6
		btst.l		#scr_pb_set_scroll_fg,d6
		beq.s		Init_scroll_end

; Clipping du scrolling.
		clr.w		Scroll_Xmin
		move.w		Virtual_Xrez,d0
		subq.w		#1,d0
		bmi.s		Init_scroll_err
		move.w		d0,Scroll_Xmax
		lsr.w		#1,d0
		move.w		d0,Scroll_X

		clr.w		Scroll_Ymin
		move.w		Virtual_Yrez,d1
		subq.w		#1,d1
		bmi.s		Init_scroll_err
		move.w		d1,Scroll_Ymax
		lsr.w		#1,d1
		move.w		d1,Scroll_Y

		bsr		Set_scroll
		bset.l		#scr_pb_set_scroll_fg,d7
Init_scroll_end: move.l		d7,Scr_fgs
		movem.l		(sp)+,d0-d7/a0-a5
		bset		#2,(1.w,sp) ; Z=1: OK.
		rtr
Init_scroll_err: move.l		d7,Scr_fgs
		movem.l		(sp)+,d0-d7/a0-a5
		bclr		#2,(1.w,sp) ; Z=0: erreur.
		rtr
;****************************************************************


;****************************************************************
;		Includes pour l'�cran.
;****************************************************************
;----------------------------------------------------------------
;		Structures des donn�es et EQUS.
;----------------------------------------------------------------
		include		"E:\ASSEMBLE\INCLUDE\SCREEN\SCR_INC.S"

;----------------------------------------------------------------
;		Routines graphiques.
;----------------------------------------------------------------
		incdir		"E:\ASSEMBLE\INCLUDE\GRAPHICS\"
		include		"CLS.S"
;		include		"LINE.S"
;		include		"POLY.S"
;		include		"QUADRI.S"
;		include		"BLITTER.S"
;****************************************************************
