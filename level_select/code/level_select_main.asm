level_select_init:
	JSL disable_screen			;$8097CD  \
	PHK					;$8097D1   |
	PLB					;$8097D2   |
	JSR clear_VRAM				;$8097D3   |
	JSL init_registers_global		;$8097D6   |
	JSL clear_noncritical_wram		;$8097DA   |
	JSR render_sprites			;stops text from glitching after leaving a level with too much onscreen
	JSL set_all_oam_offscreen		;$8097DE   |
	LDX #$001E				;$8097E5   |
	LDA #$0000				;$8097E8   |
idk1:						;	   |
	STA $32,x				;$8097EB   |
	DEX					;$8097ED   |
	DEX					;$8097EE   |
	BPL idk1				;$8097EF   |
	LDA #$0001				;$8097F1   |
	STA PPU.layer_mode			;$8097F4   |
	LDA #$0213				;$8097F7   |
	STA PPU.screens				;$8097FA   |
	LDA #$0015				;$8097FD   |
	STA PPU.layer_all_tiledata_base		;$809800   |
	LDA #$7C74				;$80981D   |
	STA PPU.layer_1_2_tilemap_base		;$809820   |
	STZ PPU.layer_1_scroll_x		;$809823   |
	STZ PPU.layer_1_scroll_x		;$809826   |
	SEP #$20				;$809829   |
	LDA #$FF				;$80982B   |
	STZ PPU.layer_1_scroll_y
	STA PPU.layer_2_scroll_y		;$809833   |
	STA PPU.layer_2_scroll_y		;$809836   |
	STZ PPU.layer_2_scroll_x		;$809839   |
	STZ PPU.layer_2_scroll_x		;$80983C   |
	LDX #$3001				;$809890   |
	STX HDMA[2].settings			;$809893   |
	LDX #$8012				;$809896   |
	STX HDMA[2].source			;$809899   |
	LDA #$7E				;$80989C   |
	STA HDMA[2].source_bank			;$80989E   |
	STZ HDMA[2].indirect_source_bank	;$8098A1   |
	REP #$20	
	

;clear animal ids
	STZ $6E			
	STZ $6C

	STZ !lv_sel_level_started
	LDA !lv_sel_toggle
	BNE .already_on				;if not entering this menu from file select, preserve settings
	INC !lv_sel_toggle
	JSL set_default_settings
	LDA #$0040
	STA !lv_sel_previous_cursor_pos
.already_on:		
	LDX #level_select_bg1_tiledata
	LDY.w #level_select_bg1_tiledata>>16
	LDA #$0000
	JSL decompress_data
	LDA #$5000
	STA PPU.vram_address
	LDX #$007F
	LDA #$0000
	LDY #$14A0
	JSL DMA_to_VRAM

	LDX #level_select_bg1_tilemap
	LDY.w #level_select_bg1_tilemap>>16
	LDA #$0000
	JSL decompress_data
	LDA #$7400
	STA PPU.vram_address
	LDX #$007F
	LDA #$0000
	LDY #$0700
	JSL DMA_to_VRAM		


		
	LDX #DATA_EC83A0			;$8098A6   |
	LDY.w #DATA_EC83A0>>16			;$8098A9   |
	LDA #$0000				;$8098AC   |
	JSL decompress_data			;$8098AF   |
	LDA #$1000				;$8098B3   |
	STA PPU.vram_address			;$8098B6   |
	LDX #$007F				;$8098D9   |
	LDA #$0000				;$8098DC   |
	LDY #$8000				;$8098DF   |
	JSL DMA_to_VRAM				;$8098E2   |
	LDA #$0020				;$8098E6   |
	STA PPU.vram_address			;$8098E9   |
	LDX.w #DATA_FC0660>>16			;$8098EC   |
	LDA #DATA_FC0660			;$8098EF   |
	LDY #$1E00				;$8098F2   |
	JSL DMA_to_VRAM				;$8098F5   |
	LDX #DATA_EC7CF0			;$8098F9   |
	LDY.w #DATA_EC7CF0>>16			;$8098FC   |
	LDA #$0000				;$8098FF   |
	JSL decompress_data			;$809902   |
	LDA #$7C00				;$809906   |
	STA PPU.vram_address			;$809909   |
	LDX #$007F				;$80990C   |
	LDA #$0000				;$80990F   |
	LDY #$0800				;$809912   |
	JSL DMA_to_VRAM				;$809915   |


	LDY #$0000				;$809985   |
	LDX #$0040				;$809988   |
	LDA #level_select_bg2_pal		;$80998B   |
	JSL DMA_palette				;$80998E   |


	LDY #$0080				;$809992   |
	LDX #$0004				;$809995   |
	LDA #$00AA				;$809998   |
	JSL DMA_global_palette			;$80999B   |


;dma palettes for BG1 cursors
	LDY #$0020
	LDX #$0016
	LDA #level_select_bg1_pal_dark_full
	JSL DMA_palette

;dma palettes for sprite text
	LDY #$0090
	LDX #$001A
	LDA #level_select_sprite_pal_dark_full
	JSL DMA_palette


	JSL get_icon_palette	
	LDA #$0300				
	JSR set_fade				
	LDA !lv_sel_song
	CMP current_song
	BEQ idk2				;if jukebox song is same from level we came from, dont restart
	SEP #$20				
	LDA #$01				
	STA.l CPU.enable_interrupts		
	REP #$20				
	LDA !lv_sel_song
	JSL play_song_with_transition
	
idk2:					
	STZ $36					
	SEP #$20				
	LDA CPU.irq_flag			
	LDA #$80				
	STA PPU.oam_address_high		
	LDA #$01				
	STA CPU.rom_speed			
	REP #$20				
	JSR prepare_oam_dma_channel		
        LDA.W #level_select_main            	
	JMP set_and_wait_for_nmi           	


level_select_main:
	LDX #stack				
	TXS					
	STZ PPU.oam_address			
	LDA #$0401				
	STA CPU.enable_dma			
	SEP #$20				
	LDA screen_brightness			
	STA PPU.screen				
	REP #$20	
	JSR set_unused_oam_offscreen


	;THESE PALETTE AND OAM ROUTINES HAPPEN ON VBLANK HERE, DONT. FUCKING. MOVE. THEM.
	JSL get_icon_palette			
	JSL get_cursor_palette			
	JSL update_all_oam
	JSR fade_screen		
	INC global_frame_counter	
	JSL song_handler
	JSR intro_controller_read
	JSL lv_sel_input_handler
	LDA !lv_sel_level_started
	BEQ set_lv_sel_nmi
	LDA screen_brightness
	BNE set_lv_sel_nmi
	JSL CODE_BBC0A0				;clears some variables so mainbrace BG scroll doesn't freak out
	JML CODE_B5D47A	


set_lv_sel_nmi:
	JSR prepare_oam_dma_channel			
	LDA #level_select_main            	  
	JMP set_and_wait_for_nmi                                               


init_bonus_handle_animal:
	LDA !lv_sel_world
	ASL A
	TAX
	LDY level_number
	JSR (bonus_animal_table,x)
	RTL


bonus_animal_table:
	dw check_w1
	dw check_w2
	dw check_w3
	dw check_w4
	dw check_w5
	dw check_w6
	dw check_w7
	dw check_w8


check_w1:
	CPY #$0070
	BEQ mount_rambi
	CPY #$0081
	BEQ mount_enguarde
	JMP no_animal


check_w2:
	CPY #$001C
	BEQ mount_squitter
	CPY #$0077
	BEQ mount_rambi
	CPY #$00A9
	BEQ mount_squawks
	JMP no_animal


check_w3:
	CPY #$007F
	BEQ transform_rattly
	CPY #$0073
	BEQ transform_rattly
	CPY #$00A0
	BEQ mount_squawks
	JMP no_animal


check_w4:
	CPY #$00B2
	BEQ transform_rambi
	JMP no_animal


check_w5:
	CPY #$00A4
	BEQ transform_squitter
	CPY #$00BC
	BEQ transform_squitter
	JMP no_animal


check_w6:
	CPY #$0093
	BEQ transform_enguarde
	CPY #$00B7
	BEQ mount_rambi
	CPY #$0092
	BEQ mount_enguarde
	CPY #$00A5
	BEQ transform_squitter
	JMP no_animal

check_w7:
	JMP no_animal

check_w8:
	CPY #$009D
	BEQ transform_squitter
	JMP no_animal






mount_rambi:
	LDA #$019C
set_mount:
	STA $6E
	LDA #$0E9E
	STA $6C
	RTS



mount_enguarde:
	LDA #$01A0
	JMP set_mount


mount_squitter:
	LDA #$0190
	JMP set_mount


mount_rattly:
	LDA #$0194
	JMP set_mount


mount_squawks:
	LDA #$0198
	JMP set_mount



transform_rambi:
	LDA #$019C
set_transform:
	STZ $6C
	STA $6E
	RTS


transform_enguarde:
	LDA #$01A0
	JMP set_transform


transform_squitter:
	LDA #$0190
	JMP set_transform


transform_rattly:
	LDA #$0194
	JMP set_transform


transform_squawks:
	LDA #$0198
	JMP set_transform




no_animal:
	STZ $6C
	STZ $6E
	RTS