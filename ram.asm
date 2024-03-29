;as a convention, any unused address will be named UNUSED_<address> and treated as a single byte
;Most addresses shall be assumed 2 bytes unless otherwise noted.  Single byte addresses won't be specifically
;noted as their addresses will carry that point.
;Duplicate addresses imply an address withg multiple contexts.
;Temporaries are named after the address they point to rather than a sequence.
;Temporaries used for any significant context should have local reassignment
;Temporaries are generally any addres used in multi contexts.
spc_transaction = $00

current_song = $1C
stereo_select = $1E
NMI_pointer = $20
UNUSED_22 = $22
UNUSED_23 = $23
gamemode_pointer = $24

temp_26 = $26
temp_27 = $27
temp_28 = $28
temp_29 = $29

global_frame_counter = $2A
active_frame_counter = $2C
rng_result = $2E
rng_seed_1 = $2F
rng_seed_2 = $30
rng_seed_3 = $31

temp_32 = $32
temp_33 = $33
temp_34 = $34
temp_35 = $35
temp_36 = $36
temp_37 = $37
temp_38 = $38
temp_39 = $39
temp_3A = $3A
temp_3B = $3B
temp_3C = $3C
temp_3D = $3D
temp_3E = $3E
temp_3F = $3F
;the amount of temps here I have documented as 30, but I will reserve filling that out pending more evidence
;I suspect the latter are used rare enough that they may effectively be dedicated addresses

oam_size_index = $56


temp_5E = $5E
temp_5F = $5F
temp_60 = $60
temp_61 = $61

current_sprite = $64
UNKNOWN_66 = $66		;This is two bytes for some table at 16B2
alternate_sprite = $68
UNKNOWN_6A = $6A		;same as $66
current_player_mount = $6C

next_oam_slot = $70

nmi_submode = $94
gamemode_submode = $96

level_number = $D3


;;;
;;; End direct page
;;;

stack_end = $0100
stack = $01FF
oam_table = $0200
oam_attribute_table = $0400

;controller logic
;Note there is no released state for active player
player_1_held = $0502
player_1_pressed = $0504
player_1_released = $0506
player_2_held = $0508
player_2_pressed = $050A
player_2_released = $050C
player_active_held = $050E
player_active_pressed = $0510
player_active_pressed_high = $0511

;brightness control
screen_brightness = $0512
screen_fade_speed = $0513
screen_fade_timer = $0514

;level logic (starts at $0515)

main_kong = $0593
follower_kong = $0597

pending_dma_hdma_channels = $059B

active_controller = $060F
file_select_selection = $0611
file_select_action = $0613
file_select_file_to_copy = $0615

language_select = $0617

map_node_number = $06AB
world_number = $06B1

piracy_string_result = $0907
enable_intro_bypass = $090F

intro_sparkle_x_position = $098F
intro_sparkle_y_position = $0991
player_skipped_demo = $099B

aux_sprite_table = $0D84
main_sprite_table = $0DE2
main_sprite_table_end = $0DE2+(sizeof(sprite)*24)

sprite_render_table = $16FE
sprite_render_table_end = $16FE+$30

;;;
;;; End low WRAM region
;;;
wram_base = $7E0000
wram_base_high = $7F0000

sram_file_buffer = $7E56CA


; HDMA buffers
; These buffers will have many overlapping addresses, some with structs, some without
; These may take awhile to get right and could end up fairly volatile until I figure it out

namespace hdma_intro
	bgmode = $7E8012
	color_math = $7E8022
	subscreen = $7E8032
namespace off

namespace hdma_menu
	windowing = $7E8012
namespace off
; end buffers

working_palette = $7E8928
primary_palette = $7E8C28


;===================practice menu/fast retry ram=====================

!lv_sel_toggle = $1A00
!lv_sel_cursor_pos = $1A02
!lv_sel_world = $1A04
!lv_sel_level = $1A06
!lv_sel_entrance = $1A08
!lv_sel_kong_order = $1A0A
!lv_sel_color = $1A0C
!lv_sel_song = $1A0E
!lv_sel_level_started = $1A10
!lv_sel_diddy_pal = $1A12
!lv_sel_dixie_pal = $1A14
!lv_sel_music_changed = $1A16

!lv_sel_is_bonus = $1A18
!fast_retry_is_bonus = $1A1A
!bonus_intro_started = $1A1C


!text_oam_offset = $1A1E
!text_pal_index_offset = $1A20
!prac_menu_text_done_uploading = $1A22

!lv_sel_previous_cursor_pos = $1A24


!menu_kong_order_mirror = $1A26
!menu_extra_kong_flag_mirror = $1A28
!menu_mount_animal_index_mirror = $1A2A
!menu_current_animal_mirror = $1A2C
!menu_kong_letters_mirror = $1A2E

!ingame_kong_order_mirror = $1A34
!ingame_extra_kong_flag_mirror = $1A36
!ingame_mount_animal_index_mirror = $1A38
!ingame_current_animal_mirror = $1A3A
!ingame_kong_letters_mirror = $1A3C
!ingame_entrance_mirror = $1A3E


!level_number_mirror = $1A42

!pause_L_pressed = $1A44


!lv_sel_selection_cap = $1A46
!lv_sel_world_index_offset = $1A48

!already_muted = $1A4A

!menu_options_buffer = $1AA0

;=========================lui timer stuff===========================

;timer constants
!dropped_frames_x = $0008
!dropped_frames_y = $0900
!timer_x = $00CC
!timer_y = $0900


;timer defines
!io_axlr = $050E
!io_byetudlr = $050F
!io_axlr_1f = $0510
!io_byetudlr_1f = $0511
!fade_type = $0513
!pause_flags = $08C2
!level_state = $0AF1

!counter_60hz = $2C


;timer ram
!timer_freeram = $1B00

!timer_freeram_used = 0
macro def_timer_freeram(id, size)
	!<id> := !timer_freeram+!timer_freeram_used
	!timer_freeram_used #= !timer_freeram_used+<size>
endmacro

%def_timer_freeram(previous_60hz, 2)		;1B00

%def_timer_freeram(dropped_frames, 2)		;1B02
%def_timer_freeram(real_frames_elapsed, 2)	;1B04

%def_timer_freeram(timer_frames, 2)		;1B06
%def_timer_freeram(timer_seconds, 2)		;1B08	
%def_timer_freeram(timer_minutes, 2)		;1B0A

%def_timer_freeram(timer_disp_frames, 2)	;1B0C
%def_timer_freeram(timer_disp_seconds, 2)	;1B0E
%def_timer_freeram(timer_disp_minutes, 2)	;1B10

%def_timer_freeram(timer_stopped, 2)		;1B12
%def_timer_freeram(timer_started, 2)		;1B14

%def_timer_freeram(pause_timer_started, 2)	;1B16

;for preserving timer on fast retry/respawn
%def_timer_freeram(timer_frames_mirror, 2)	;1B18
%def_timer_freeram(timer_seconds_mirror, 2)	;1B1A
%def_timer_freeram(timer_minutes_mirror, 2)	;1B1C


assert !timer_freeram+!timer_freeram_used < $2000, "exceeded freeram area"