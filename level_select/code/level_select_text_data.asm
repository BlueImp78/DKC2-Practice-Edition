prac_menu_text:
	dw prac_menu
        dw !null_pointer

prac_menu:
        db "PRACTICE MENU", $00


world_text_table:
	dw gangplank_galleon
        dw crocodile_cauldron
        dw krem_quay
        dw krazy_kremland
        dw gloomy_gulch
        dw krools_keep
        dw flying_kroc
        dw lost_world
        

gangplank_galleon:
	db "GANGPLANK GALLEON", $00

crocodile_cauldron:
	db "CROCDILE CAULDRON", $00

krem_quay:
	db "KREM QUAY", $00

krazy_kremland:
	db "KRAZY KREMLAND", $00

gloomy_gulch:
	db "GLOOMY GULCH", $00

krools_keep:
	db "KROOL'S KEEP", $00

flying_kroc:
	db "FLYING KROC", $00

lost_world:
        db "LOST WORLD", $00




level_text:
        dw pirate_panic
        dw mainbrace_mayhem
        dw gangplank_galley
        dw lockjaws_locker
        dw topsail_trouble
        dw krows_nest
        dw hot_head_hop
        dw kannons_klaim
        dw lava_lagoon
        dw red_hot_ride
        dw squawks_shaft
        dw kleevers_kiln
        dw barrel_bayou
        dw glimmers_galleon
        dw krochead_klamber
        dw rattle_battle
        dw slime_climb
        dw bramble_blast
        dw kudgels_kontest
        dw hornet_hole
        dw target_terror
        dw bramble_scramble
        dw rickety_race
        dw mudhole_marsh
        dw rambi_rumble
        dw king_zing_sting
        dw ghostly_grove
        dw haunted_hall
        dw gusty_glade
        dw parrot_chute_panic
        dw web_woods
        dw kreepy_krow
        dw arctic_abyss
        dw windy_well
        dw castle_crush
        dw clappers_cavern
        dw chain_link_chamber
        dw toxic_tower
        dw screechs_sprint
        dw krool_duel
        dw jungle_jinx
        dw black_ice_battle
        dw klobber_karnage
        dw fiery_furnace
        dw animal_antics
        dw krocodile_kore


pirate_panic:
	db "PIRATE PANIC", $00

mainbrace_mayhem:
	db "MAINBRACE MAYHEM", $00

gangplank_galley:
	db "GANGPLANK GALLEY", $00

lockjaws_locker:
	db "LOCKJAW'S LOCKER", $00

topsail_trouble:
	db "TOPSAIL TROUBLE", $00

krows_nest:
	db "KROW'S NEST", $00

hot_head_hop:
	db "HOT-HEAD HOP", $00

kannons_klaim:
        db "KANNON'S KLAIM", $00

lava_lagoon:
        db "LAVA LAGOON", $00

red_hot_ride:
        db "RED-HOT RIDE", $00

squawks_shaft:
        db "SQUAWK'S SHAFT", $00

kleevers_kiln:
        db "KLEEVER'S KILN", $00

barrel_bayou:
        db "BARREL BAYOU", $00

glimmers_galleon:
        db "GLIMMER'S GALLEON", $00

krochead_klamber:
        db "KROCHEAD KLAMBER", $00

rattle_battle:
        db "RATTLE BATTLE", $00

slime_climb:
        db "SLIME CLIMB", $00

bramble_blast:
        db "BRAMBLE BLAST", $00

kudgels_kontest:
        db "KUDGEL'S KONTEST", $00

hornet_hole:
        db "HORNET HOLE", $00

target_terror:
        db "TARGET TERROR", $00

bramble_scramble:
        db "BRAMBLE SCRAMBLE", $00

rickety_race:
        db "RICKETY RACE", $00

mudhole_marsh:
        db "MUDHOLE MARSH", $00

rambi_rumble:
        db "RAMBI RUMBLE", $00

king_zing_sting:
        db "KING ZING STING", $00

ghostly_grove:
        db "GHOSTLY GROVE", $00

haunted_hall:
        db "HAUNTED HALL", $00

gusty_glade:
        db "GUSTY GLADE", $00

parrot_chute_panic:
        db "PARROT CHUTE PNC", $00

web_woods:
        db "WEB WOODS", $00

kreepy_krow:
        db "KREEPY KROW", $00

arctic_abyss:
        db "ARCTIC ABYSS", $00

windy_well:
        db "WINDY WELL", $00

castle_crush:
        db "CASTLE CRUSH", $00

clappers_cavern:
        db "CLAPPER'S CAVERN", $00

chain_link_chamber:
        db "CHAIN LINK CHAMBER", $00

toxic_tower:
        db "TOXIC TOWER", $00

screechs_sprint:
        db "SCREECH'S SPRINT", $00

krool_duel:
        db "K.ROOL DUEL", $00

jungle_jinx:
        db "JUNGLE JINX", $00

black_ice_battle:
        db "BLACK ICE BATTLE", $00

klobber_karnage:
        db "KLOBBER KARNAGE", $00

fiery_furnace:
        db "FIERY FURNACE", $00

animal_antics:
        db "ANIMAL ANTICS", $00

krocodile_kore:
        db "KROCODILE KORE", $00



numbers_table:
        dw one
        dw two
        dw three
        dw four
        dw five

one:
        db "1", $00

two:
        db "2", $00

three:
        db "B1", $00

four:
        db "B2", $00

five:
        db "B3", $00