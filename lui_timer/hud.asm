handle_displays_global:
	JSR handle_displays
	RTL

handle_displays:
	SEP #$20
	LDA !timer_started
	BNE .active
	LDA !fade_type
	BNE +
	
.start:
	INC !timer_started
	BRA .update
	
.active:
	LDA !fade_type
	BMI .skip_update
	LDA !timer_stopped
	BNE +
	
.update:
	LDA !timer_frames
	STA !timer_disp_frames
	LDA !timer_seconds
	STA !timer_disp_seconds
	LDA !timer_minutes
	STA !timer_disp_minutes
	
.skip_update:
	; checking here lets the timer tick on the first frame you hit the goal
	; to properly account for lag frames
	LDA !level_state
	CMP #$A0
	BNE +
	INC !timer_stopped
+:
	REP #$20
	RTS

draw_timer_global:
	JSR draw_timer
	RTL

draw_timer:
	; starting x position
	LDX #!timer_x
	; starting y position
	LDA #!timer_y
	STA $32
	
	LDA !timer_disp_minutes
	JSR CODE_BEC81F ;draw digit
	; 2 pixels padding
	INX
	INX
	; tens
	LDA !timer_disp_seconds
	LSR #4
	JSR CODE_BEC81F ;draw digit
	; units
	LDA !timer_disp_seconds
	AND #$000F
	JSR CODE_BEC81F ;draw digit
	INX
	INX
	; tens
	LDA !timer_disp_frames
	LSR #4
	JSR CODE_BEC81F ;draw digit
	; units
	LDA !timer_disp_frames
	AND #$000F
	JSR CODE_BEC81F ;draw digit
.done:
	RTS 		;no lag counter until i figure out a fix 
	
draw_dropped_frames:
	; starting x position
	LDX #!dropped_frames_x
	; starting y position
	LDA #!dropped_frames_y
	STA $32
	
	; check hundreds
	LDA !dropped_frames
	CMP #$0999
	BCC .no_cap
	LDA #$0009
	JSR CODE_BEC81F ;draw digit
	LDA #$0009
	JSR CODE_BEC81F ;draw digit
	LDA #$0009
	BRA .last
	
.no_cap:
	; hundreds
	XBA
	AND #$00FF
	JSR CODE_BEC81F ;draw digit
	; tens
	LDA !dropped_frames
	LSR #4
	AND #$000F
	JSR CODE_BEC81F ;draw digit
	; units
	LDA !dropped_frames
	AND #$000F
.last:
	JSR CODE_BEC81F ;draw digit
	RTS
		