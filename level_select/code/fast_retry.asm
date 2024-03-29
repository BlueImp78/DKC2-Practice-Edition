;TODO: clean this up. using a diff bullet time value may not be needed
fast_retry:
        LDA !lv_sel_is_bonus
        BEQ +
	LDA !fast_retry_is_bonus
	BEQ +
	STZ !fast_retry_is_bonus
	LDA #$0080
	BRA ++
+:
	LDA #$000F
++:
	LDY #$002C
	JSL enable_bullet_time_global		;enable bullet time
	LDA #$0013
	LDX follower_kong	;set follower kong to dummy behavior
	STA $2E,x
	LDX main_kong
	LDA #$0080		;set main kong to custom dummy behaviour
	STA $2E,x	
	JSR reset_kremcoin_cheat_progress			
	LDA #$830F				
	JSL set_fade_global			
	LDA #$0002				
	TSB $08C2
        LDA current_song
        CMP #$000F
        LDA !lv_sel_is_bonus
        BEQ .done
+++:
       	LDA #$0001
	STA !fast_retry_is_bonus 
.done:
        STZ !bonus_intro_started
        LDA !level_number_mirror        ;check if mainbrace
        CMP #$000C
        BNE .done2
        JSL CODE_BBC0A0		        ;if so, clear some variables so the BG scroll doesn't freak out
.done2
        RTL


preserve_menu_player_status:
        LDA $08C2
        STA !menu_extra_kong_flag_mirror
        LDA $08A4
        STA !menu_kong_order_mirror
        LDA $0902
        STA !menu_kong_letters_mirror
        LDA $6C                        
        STA !menu_mount_animal_index_mirror
        LDA $6E
        STA !menu_current_animal_mirror
.done:
        RTL

restore_menu_player_status:
        LDA !menu_extra_kong_flag_mirror
        STA $08C2
        LDA !menu_kong_order_mirror
        STA $08A4
        LDA !menu_kong_letters_mirror
        STA $0902
        LDA !menu_current_animal_mirror
        STA $6E
        LDA !menu_mount_animal_index_mirror
        ; BNE +
        ; LDA #$0E9E
        STA $6C
+:
        RTL


preserve_player_status:
        LDA $08C2
        STA !ingame_extra_kong_flag_mirror
        LDA $08A4
        STA !ingame_kong_order_mirror
        LDA $0902
        STA !ingame_kong_letters_mirror
        LDA $6C                        
        STA !ingame_mount_animal_index_mirror
        LDA $6E
        STA !ingame_current_animal_mirror
        LDA $08A6
        STA !ingame_entrance_mirror
.done:
        RTL


restore_player_status:
        LDA !ingame_extra_kong_flag_mirror
        STA $08C2
        LDA !ingame_kong_order_mirror
        STA $08A4
        LDA !ingame_kong_letters_mirror
        STA $0902
        LDA !ingame_current_animal_mirror
        STA $6E
        LDA !ingame_entrance_mirror
        STA $08A6
        LDA !ingame_mount_animal_index_mirror
        BEQ +
        LDA #$0E9E
        STA $6C
+:
        RTL