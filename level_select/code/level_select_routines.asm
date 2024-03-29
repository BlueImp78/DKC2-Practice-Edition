;TODO: comment this whole file 

lv_sel_input_handler:
	LDA screen_brightness
	CMP #$000F
	BNE .done
	LDA player_active_pressed
	BIT #$0400
	BEQ .check_up
	LDA !lv_sel_cursor_pos
	STA !lv_sel_previous_cursor_pos		;save previous cursor position
	CLC
	ADC #$0010
	CMP #$0080
	BNE .move_cursor
	LDA #$0020
.move_cursor:
	STA !lv_sel_cursor_pos		
	%lda_sound(6, menu_move)
	JSL play_high_priority_sound
.done:
	RTL


.check_up:
	BIT #$0800
	BEQ .check_left
	LDA !lv_sel_cursor_pos
	STA !lv_sel_previous_cursor_pos		;save previous cursor position
	SEC
	SBC #$0010
	CMP #$0010
	BNE .move_cursor
	LDA #$0070
	BRA .move_cursor
	

.check_left:
	BIT #$0200
	BEQ .check_right
	LDA !lv_sel_cursor_pos
	CMP #$0070
	BNE .idk1
	INC !lv_sel_music_changed

.idk1:
	CMP #$0020
	BNE +
	STZ !lv_sel_level
+:
	CMP #$0040
	BCS .play_sound
	STZ !lv_sel_entrance

.play_sound:
	%lda_sound(6, menu_move)
	JSL play_high_priority_sound
	JSR get_selection_index
	LDA !lv_sel_cursor_pos
	CMP #$0040
	BNE .dec_once
	JSR hud_check_if_rickety
	BCC .dec_once
	DEC $1A04,x	

.dec_once:
	DEC $1A04,x
	BMI .wrap_value_right
	BRA .done

.check_right:
	BIT #$0100
	BEQ .check_start
	LDA !lv_sel_cursor_pos
	CMP #$0070
	BNE .idk2
	INC !lv_sel_music_changed

.idk2:
	CMP #$0040
	BCS .not_on_entrance
	STZ !lv_sel_entrance
.not_on_entrance:
	CMP #$0020
	BNE ++
	STZ !lv_sel_level
++:
	%lda_sound(6, menu_move)
	JSL play_high_priority_sound
	JSR get_selection_index
	LDA !lv_sel_cursor_pos
	CMP #$0040
	BNE .inc_once
	JSR hud_check_if_rickety
	BCC .inc_once
	INC $1A04,x	

.inc_once:
	INC $1A04,x
	LDA $1A04,x
	CMP !lv_sel_selection_cap
	BCS .wrap_value_left
	BRL .done


.check_start:
	BIT #$1000
	BEQ .done_trampoline
	%lda_sound(6, menu_select)
	JSL play_high_priority_sound
	JSR init_level
	JSR set_ingame_kong_palette
	STZ current_song
.done_trampoline:
	BRL .done


.wrap_value_right:
	LDA !lv_sel_selection_cap
	DEC
	JSR hud_check_if_rickety
	BCC +++
	DEC
+++:
	STA $1A04,x
	BRL .done

.wrap_value_left:
	STZ $1A04,x
	BRL .done


get_selection_index:
	LDA !lv_sel_cursor_pos
	AND #$00F0
	LSR A
	LSR A
	LSR A
	LSR A
	DEC
	DEC
	ASL A
	TAX
	LDA.l selection_cap_values,x
	LDY !lv_sel_cursor_pos
	CPY #$0040
	BNE +
	JSR get_entrance_cap
+:
	CPY #$0030
	BNE .done
	LDY !lv_sel_world
	CPY #$0002
	BEQ .set_07
	CPY #$0003
	BEQ .set_07
	CPY #$0006
	BNE .done
	LDA #$0002
	BRA .done

.set_07:
	LDA #$0007
.done:
	STA !lv_sel_selection_cap
	RTS


get_entrance_cap:
	PHA
	PHX
	JSR get_lv_number		;this is just to read from world_offset_values_table more easily
	LDA !lv_sel_world
	CLC
	ADC !lv_sel_level
	ASL A 
	ADC !lv_sel_world_index_offset
	TAX
	LDA.l entrance_cap_table,x
	STA $3E
	PLA
	INC
	SEC
	SBC $3E
	PLX
	DEX
	RTS


init_level:
	JSL every_map_frame		;clear lui timer vars
	LDA !lv_sel_entrance
	STA $08A6
	CMP #$0002
	BCC +
	JSR get_bonus_number
	BRA ++
+:
	JSR get_lv_number
	STZ !lv_sel_is_bonus
	STZ !fast_retry_is_bonus
++:
	STZ !bonus_intro_started
	INC !lv_sel_level_started
	JSR set_player_items
	JSR set_kong_order
	JSR init_level_handle_animal
	JSL preserve_menu_player_status
	JSL preserve_player_status
	LDA #$0082
	STA screen_fade_speed
	RTS


get_lv_number:
	LDA !lv_sel_world
	ASL A 
	TAX 
	LDA.l world_offset_values_table,x
	STA !lv_sel_world_index_offset
	LDA !lv_sel_level
	ASL A
	CLC
	ADC !lv_sel_world_index_offset
	TAX
	LDA.l levels_table,x
	STA level_number
	STA !level_number_mirror
	RTS


;this routine kinda sucks lol
get_bonus_number:
	JSR get_lv_number		;to get our world offset value
	LDA !lv_sel_world_index_offset
	LSR A
	LDY !lv_sel_world		;if world index is 00 don't ADD
	BEQ +
	ADC !lv_sel_world_index_offset
	DEC
	DEC
+:
	STA $40
	LDA !lv_sel_level
	ASL A
	CLC
	ADC !lv_sel_level		;multiply our level index by 3
	ADC $40				;add our calculated world offset 
	PHA
	LDA !lv_sel_entrance		;use our entrance -2 to pick which bonus room from the level we should go to
	DEC
	DEC
	STA $42
	PLA
	ADC $42
	ASL A
	TAX
	LDA.l bonus_room_table,x
	STA level_number
	STA !level_number_mirror
	STZ $08A6
	STZ !fast_retry_is_bonus
	LDA #$0001
	STA !lv_sel_is_bonus
	RTS


set_kong_order:
	LDA !lv_sel_kong_order
	BEQ .solo_diddy
	CMP #$0001
	BEQ .diddy_and_dixie
	CMP #$0002
	BEQ .solo_dixie
	CMP #$0003
	BEQ .dixie_and_diddy
.done:
	RTS


.solo_diddy:
	STZ $08A4
-:
	LDA #$4000
	TRB $08C2
	BRA .done

.solo_dixie
	INC $08A4
	BRA -

.diddy_and_dixie:
	STZ $08A4
--:
	LDA #$4000
	TSB $08C2
	BRA .done

.dixie_and_diddy:
	INC $08A4
	BRA --

init_level_handle_animal:
	LDX !lv_sel_entrance
	CPX #$0002
	BCC +
	JSL init_bonus_handle_animal
	RTS
+
	LDX level_number
	CPX #$0005
	BEQ .set_rattly
	CPX #$0017
	BEQ .set_squitter
	CPX #$006C
	BEQ .set_enguarde
	CPX #$009A
	BEQ .set_animal_antics_squitter_room
++:
-:
	RTS 

.set_rattly:
	LDA !lv_sel_entrance
	BEQ -
	LDA #$0194
.store_animal:
	STA $6E
	BRA -

.set_squitter:
	LDA !lv_sel_entrance
	BEQ -
	LDA #$0190
	BRA .store_animal

.set_enguarde:
	LDA !lv_sel_entrance
	BEQ -
	LDA #$01A0
	BRA .store_animal

.set_animal_antics_squitter_room:
	LDA !lv_sel_entrance
	BEQ -
	LDA #$009B
	STA level_number
	STA !level_number_mirror
	STZ $08A6
	BRA .set_squitter	


level_check_if_rickety_or_boss:
	LDA level_number
	CMP #$000F
	BEQ .yes
	LDA !lv_sel_world
	ASL A 
	TAX
	LDA.l boss_level_table,x
	CMP level_number
	BEQ .yes
	CLC
	RTS

.yes:
	SEC
	RTS

;using Y here for convenience
hud_check_if_rickety:
	SEP #$20
	LDY !lv_sel_world
	STY $1A30
	LDY !lv_sel_level
	STY $1A31
	REP #$20
	LDY $1A30
	CPY #$0303
	BEQ .yes
.done:
	CLC 
	RTS 

.yes:
	SEC
	RTS




set_ingame_kong_palette:
	LDA !lv_sel_color
	BEQ .default_colors
	LDA #$64C0
	STA !lv_sel_diddy_pal
	LDA #$65B0
	STA !lv_sel_dixie_pal
	BRA .done

.default_colors:
	LDA #$6484
	STA !lv_sel_diddy_pal
	LDA #$6574
	STA !lv_sel_dixie_pal
.done:
	RTS


set_default_settings:
	LDA #$0020
	STA !lv_sel_cursor_pos	
	LDA #$0004
	STA !lv_sel_song
	LDA #$6484
	STA !lv_sel_diddy_pal
	LDA #$6574
	STA !lv_sel_dixie_pal
	STZ !lv_sel_music_changed
	STZ !lv_sel_world
	STZ !lv_sel_level
	STZ !lv_sel_entrance
	STZ !lv_sel_color
	STZ !lv_sel_kong_order
	STZ !lv_sel_is_bonus
	STZ !fast_retry_is_bonus
	JSR reset_kremcoin_cheat_progress
	RTL


update_all_oam:
	JSR upload_prac_menu_text
	JSR update_text_oam
	JSR update_kong_oam
	RTL

upload_prac_menu_text:
	LDA !prac_menu_text_done_uploading
	BNE .done
	LDX #$0000
	STX next_oam_slot
	LDA #$1080
	STA !text_oam_offset
	LDA.l prac_menu_text,x
	STA $3A
	LDA #$3002
	STA !text_pal_index_offset
	LDA #<:prac_menu_text
	JSR upload_text_oam
.done:
	RTS


update_text_oam:
;world
	LDA !lv_sel_world
	ASL A
	TAX
	LDA #$0060
	STA next_oam_slot
	LDA #$3A95
	STA !text_oam_offset
	LDA.l world_text_table,x
	STA $3A
	LDA #$3202
	STA !text_pal_index_offset
	LDA #<:world_text_table
	JSR upload_text_oam

;level
	LDA !lv_sel_world
	ASL A 
	TAX 
	LDA.l world_offset_values_table,x
	STA $1A80
	LDA !lv_sel_level
	ASL A
	CLC
	ADC $1A80
	TAX
	LDA #$00E0
	STA next_oam_slot
	LDA #$5195
	STA !text_oam_offset
	LDA.l level_text,x
	STA $3A
	LDA #$3402
	STA !text_pal_index_offset
	LDA #<:level_text
	JSR upload_text_oam

;entrance
	LDA !lv_sel_entrance
	ASL A
	TAX
	LDA #$01C0
	STA next_oam_slot
	LDA #$6AAC
	STA !text_oam_offset
	LDA.l numbers_table,x
	STA $3A
	LDA #$3602
	STA !text_pal_index_offset
	LDA #<:numbers_table
	JSR upload_text_oam

;color
	LDA !lv_sel_color
	ASL A
	TAX
	LDA #$01D0
	STA next_oam_slot
	LDA #$9C94
	STA !text_oam_offset
	LDA.l numbers_table,x
	STA $3A
	LDA #$3A02
	STA !text_pal_index_offset
	LDA #<:numbers_table
	JSR upload_text_oam

;jukebox
	LDA !lv_sel_song
	ASL A
	TAX
	LDA #$0160
	STA next_oam_slot
	LDA #$B5A0
	STA !text_oam_offset
	LDA.l DATA_809C99,x
	STA $3A
	LDA #$3C02
	STA !text_pal_index_offset
	LDA #<:DATA_809C99
	JSR upload_text_oam	
	RTS


;slightly tweaked vanilla routine to construct text tilemap from ASCII text
upload_text_oam:
	STA $3C					;$809DF1   |
	LDY next_oam_slot			;$809DF3   |
	LDA #$C902				;$809DF6   |
	SEC					;$809DF9   |
	SBC $17C0				;$809DFA   |
	XBA					;$809DFD   |
	CLC					;$809DFE   |
	ADC !text_oam_offset			;$809DFF   |
	BCS .idk1				;$809E02   |
	CMP #$E000				;$809E04   |
	BCC .idk2				;$809E07   |
.idk1:						;	   |
	LDA #$E000				;$809E09   |
.idk2:						;	   |
	STA $32					;$809E0C   |
.idk3:						;	   |
	LDA [$3A]				;$809E0E   |
	AND #$00FF				;$809E10   |
	BEQ .done
	CMP #$0020				;$809E15   |
	BEQ .idk4				;$809E18   |
	SEC					;$809E1A   |
	SBC #$0021				;$809E1B   |
	TAX					;$809E1E   |


	LDA.l DATA_B4C4B3,x			;$809E1F   |
	AND #$00FF				;$809E23   |
	ASL A					;$809E26   |
	CLC					;$809E27   |
	ADC !text_pal_index_offset		;$809E28   |
	STA $34					;$809E2B   |

	
	LDA $32					;$809E2D   |
	STA oam[0].position,y			;$809E2F   |
	LDA $34					;$809E32   |
	STA oam[0].display,y			;$809E34   |
	LDA $32					;$809E37   |
	CLC					;$809E39   |
	ADC #$0800				;$809E3A   |
	STA oam[1].position,y			;$809E3D   |
	INC $34					;$809E40   |
	LDA $34					;$809E42   |
	STA oam[1].display,y			;$809E44   |
	TYA					;$809E47   |
	CLC					;$809E48   |
	ADC #$0008				;$809E49   |
	TAY					;$809E4C   |
.idk4:						;	   |
	INC $3A					;$809E4D   |
	LDA $32					;$809E4F   |
	CLC					;$809E51   |
	ADC #$0008				;$809E52   |
	STA $32					;$809E55   |
	BRA .idk3				;$809E57  /

.done:
	STZ oam_attribute[$00].size		;$809E59  \
	STZ oam_attribute[$02].size		;$809E5C   |
	STZ oam_attribute[$04].size		;$809E5F   |
	STZ oam_attribute[$06].size		;$809E62   |
	STZ oam_attribute[$08].size		;$809E65   |
	STZ oam_attribute[$0A].size		;$809E68   |
	STZ oam_attribute[$0C].size		;$809E6B   |
	STZ oam_attribute[$0E].size		;$809E6E   |
	STZ oam_attribute[$10].size		;$809E71   |
	RTS					;$809E74  /


update_kong_oam:
	LDA !lv_sel_kong_order
	ASL A
	TAX
	JSR (get_kong_icon,x)
	RTS


get_kong_icon:
	dw solo_diddy
	dw diddy_and_dixie
	dw solo_dixie
	dw dixie_and_diddy


solo_diddy:
	LDA #$01E0
	STA next_oam_slot

;setup top half
	LDA #$8786
	STA $32
	LDA #$6076
	STA $34

;setup bottom half
	LDA #$8F86
	STA $36
	LDA #$6086
	STA $38
	JSR update_oam
	RTS

solo_dixie:
	LDA #$01E0
	STA next_oam_slot

;setup top
	LDA #$8786
	STA $32
	LDA #$6078
	STA $34

;setup bottom half
	LDA #$8F86
	STA $36
	LDA #$6088
	STA $38
	JSR update_oam
	RTS


diddy_and_dixie:
	JSR solo_diddy
	LDA #$01F0
	STA next_oam_slot

;setup dixie
;setup top half
	LDA #$8799
	STA $32
	LDA #$6078
	STA $34

;setup bottom half
	LDA #$8F99
	STA $36
	LDA #$6088
	STA $38
	JSR update_oam
	RTS

dixie_and_diddy:
	JSR solo_dixie
	LDA #$01F0
	STA next_oam_slot

;setup top half
	LDA #$8799
	STA $32
	LDA #$6076
	STA $34

;setup bottom half
	LDA #$8F99
	STA $36
	LDA #$6086
	STA $38
	JSR update_oam
	RTS


update_oam:
	LDY next_oam_slot

;upload top half
	LDA $32
	STA oam[0].position,y			
	LDA $34					
	STA oam[0].display,y		
	PHA
	LDA $34
	CMP #$6076
	BNE +	
	pla
	LDX !lv_sel_kong_order
	CPX #$0003
	BEQ .shit_offset
	CLC 
	ADC #$2708
	BRA ++
+:
	PLA
	LDX !lv_sel_kong_order
	CPX #$0001
	BEQ .shit_offset_2
	CLC
	ADC #$2706
-:
++:
	STA oam[1].position,y			
	INC $34					
	LDA $34					
	STA oam[1].display,y		

;upload bottom half
	LDA $36
	STA oam[2].position,y			
	LDA $38					
	STA oam[2].display,y			
	LDA $36
	SEC
	SBC #$0008
	STA oam[3].position,y			
	INC $38					
	LDA $38					
	STA oam[3].display,y	
	RTS

.shit_offset:
	CLC
	ADC #$271B
	BRA -

.shit_offset_2:
	CLC
	ADC #$2719
	BRA -


get_icon_palette:
	LDY #$0080			
	LDX #$0004
	LDA !lv_sel_color
	BNE .p2_colors			
	LDA #level_select_p1_palette	
-:
	JSL DMA_palette	
	RTL

.p2_colors:
	LDA #level_select_p2_palette
	BRA -

get_cursor_palette:
	LDA !lv_sel_cursor_pos
	PHA 
	TAY
	JSR .DMA_bright_cursor_palette
	PLA
	CMP !lv_sel_previous_cursor_pos
	BNE .cursor_changed
.done:
	RTL

.cursor_changed:
	LDY !lv_sel_previous_cursor_pos
	JSR .DMA_dark_cursor_palette
	BRA .done

.DMA_bright_cursor_palette:	
	PHY	
	LDX #$0004			
	LDA #level_select_bg1_pal_bright		
	JSL DMA_palette		
	PLY
	TYA
	CLC
	ADC #$0070
	TAY
	LDA #level_select_sprite_pal_bright
	JSL DMA_palette
	RTS

.DMA_dark_cursor_palette:	
	PHY	
	LDX #$0004			
	LDA #level_select_bg1_pal_dark		
	JSL DMA_palette		
	PLY
	TYA
	CLC
	ADC #$0070
	TAY
	LDA #level_select_sprite_pal_dark
	JSL DMA_palette
	RTS


song_handler:
	LDA !lv_sel_music_changed
	BEQ .not_on_jukebox
	SEP #$20				
	LDA #$01				
	STA.l CPU.enable_interrupts	
	REP #$20				
	LDA !lv_sel_song
	JSL play_song_with_transition
	STZ !lv_sel_music_changed
	JML set_lv_sel_nmi

.not_on_jukebox:
	RTL
	

set_player_items:
	LDA #$0004
	STA $08BE
	STZ $08BC
	STZ $08CA
	STZ $08CC
	STZ $08CE
	STZ $0902
	JSR reset_kremcoin_cheat_progress
.done:
	RTS

reset_kremcoin_cheat_progress:
	STZ $08B8
	STZ $08BA
	STZ $0923
	RTS

