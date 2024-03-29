every_map_frame:
		STZ !dropped_frames
		STZ !real_frames_elapsed
		STZ !timer_frames
		STZ !timer_seconds
		STZ !timer_minutes
		STZ !timer_frames_mirror
		STZ !timer_seconds_mirror
		STZ !timer_minutes_mirror
		STZ !timer_disp_frames
		STZ !timer_disp_seconds
		STZ !timer_disp_minutes
		STZ !timer_stopped
		STZ !timer_started
		LDA !counter_60hz
		STA !previous_60hz
		RTL



