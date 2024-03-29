selection_cap_values:
        dw $0008        ;worlds
        dw $0006        ;levels
        dw $0005        ;entrances
        dw $0004        ;kong order
        dw $0002        ;color
        dw $0020        ;songs


level_sel_cap_values:
        dw $0006
        dw $0006
        dw $0007
        dw $0007
        dw $0006
        dw $0006
        dw $0002
        dw $0006


levels_table:
w1_levels:
        dw $0003        ;pirate panic
        dw $000C        ;mainbrace mayhem
        dw $0004        ;gangplank galley
        dw $0015        ;lockjaw's locker
        dw $000B        ;topsail trouble
        dw $0009        ;krow's nest

w2_levels:
        dw $0007        ;hot-head-hop
        dw $0025        ;kannon's klaim
        dw $0014        ;lava lagoon
        dw $0008        ;red hot ride
        dw $0024        ;squawk's shaft
        dw $0021        ;kleever's kiln

w3_levels:
        dw $0028        ;barrel bayou
        dw $0001        ;glimmer's galleon
        dw $0029        ;krochead klamber
        dw $0005        ;rattle battle
        dw $000A        ;slime climb
        dw $002D        ;bramble blast
        dw $0063        ;kudgel's kontest

w4_levels:
        dw $0011        ;hornet hole
        dw $000E        ;target terror
        dw $002E        ;bramble scramble
        dw $000F        ;rickety race
        dw $002C        ;mudhole marsh
        dw $0002        ;rambi rumble
        dw $0060        ;king-zing sting

w5_levels:
        dw $0019        ;ghostly grove
        dw $0010        ;haunted hall
        dw $0018        ;gusty glade
        dw $0013        ;parrot chute panic
        dw $0017        ;web woods
        dw $000D        ;kreepy krow

w6_levels:
        dw $006C        ;arctic abyss
        dw $0023        ;windy well
        dw $0062        ;castle crush
        dw $008F        ;clapper's cavern
        dw $006D        ;chain-link chamber
        dw $006E        ;toxic tower

w7_levels:
        dw $002F        ;screech's sprint
        dw $0061        ;k.rool duel

w8_levels:
        dw $0099        ;jungle jinx
        dw $0096        ;black ice battle
        dw $0080        ;klobber karnage
        dw $0016        ;fiery furnace
        dw $009A        ;animal antics
        dw $006B        ;krocodile kore

boss_level_table:
        dw $0009        ;krow
        dw $0021        ;kleever
        dw $0063        ;kudgel
        dw $0060        ;king zing
        dw $000D        ;kreepy krow
        dw !null_pointer
        dw $0061        ;krool 1
        dw $006B        ;krool 2

world_offset_values_table:
        dw $0000
        dw $000C
        dw $0018
        dw $0026
        dw $0034
        dw $0040
        dw $004C
        dw $0050


;how much to subtract from the base entrance cap, always subtract max from boss levels
entrance_cap_table:
        dw $0001        ;pirate panic           2 bonuses
        dw $0000        ;mainbrace mayhem       3 bonuses
        dw $0001        ;gangplank galley       2 bonuses
        dw $0002        ;lockjaw's locker       1 bonus
        dw $0001        ;topsail trouble        2 bonuses
        dw $0004        ;krow's nest            
        dw !null_pointer

        dw $0000        ;hot-head hop           3 bonuses
        dw $0000        ;kannon's klaim         3 bonuses
        dw $0002        ;lava lagoon            1 bonus
        dw $0001        ;red-hot ride           2 bonuses
        dw $0000        ;squawks shaft          3 bonuses
        dw $0004        ;kleever's kiln
        dw !null_pointer

        dw $0001        ;barrel bayou           2 bonuses
        dw $0001        ;glimmers galleon       2 bonuses
        dw $0002        ;krochead klamber       1 bonus
        dw $0000        ;rattle battle          3 bonuses
        dw $0001        ;slime climb            2 bonuses
        dw $0001        ;bramble blast          2 bonuses
        dw $0004        ;kudgel's kontest
        dw !null_pointer

        dw $0000        ;hornet hole            3 bonuses
        dw $0001        ;target terror          2 bonuses
        dw $0002        ;bramble scramble       1 bonus
        dw $0001        ;rickety race           1 bonus
        dw $0001        ;mudhole marsh          2 bonuses
        dw $0001        ;rambi rumble           2 bonuses
        dw $0004        ;king-zing sting
        dw !null_pointer

        dw $0001        ;ghostly grove          2 bonuses
        dw $0000        ;haunted hall           3 bonuses
        dw $0001        ;gusty glade            2 bonuses
        dw $0001        ;parrot-chute panic     2 bonuses
        dw $0001        ;web woods              2 bonuses
        dw $0004        ;kreepy krow
        dw !null_pointer

        dw $0001        ;arctic abyss           2 bonuses
        dw $0001        ;windy well             2 bonuses
        dw $0001        ;castle crush           2 bonuses
        dw $0001        ;clapper's cavern       2 bonuses
        dw $0001        ;chain-link chamber     2 bonuses
        dw $0002        ;toxic tower            1 bonus
        dw !null_pointer

        dw $0002        ;screech's sprint       1 bonus
        dw $0004        ;k.rool duel
        dw !null_pointer

        dw $0002        ;jungle jinx            1 bonus
        dw $0002        ;black ice battle       1 bonus
        dw $0002        ;klobber karnage        1 bonus
        dw $0002        ;fiery furnace          1 bonus
        dw $0002        ;animal antics          1 bonus
        dw $0004        ;krocodile kore


;=====================================================================================================
;=====================================================================================================



;null pointers are to offset not all levels having consistent bonus numbers. thanks rare.
;the ones after the boss null pointer were added to fix my terrible math :)


bonus_room_table:
world_1_bonuses:
        dw $006F                ;pirate panic bonus 1
        dw $0070                ;pirate panic bonus 2
        dw !null_pointer

        dw $0078                ;mainbrace mayhem bonus 1
        dw $0079                ;mainbrace mayhem bonus 2
        dw $007D                ;mainbrace mayhem bonus 3

        dw $00A8                ;gangplank galley bonus 1
        dw $0071                ;gangplank galley bonus 2
        dw !null_pointer

        dw $0081                ;lockjaw's locker bonus 1
        dw !null_pointer
        dw !null_pointer

        dw $007B                ;topsail trouble bonus 1
        dw $007C                ;topsail trouble bonus 2
        dw !null_pointer
        
        dw !null_pointer        ;boss

world_2_bonuses:
        dw $0075                ;hot-head hop bonus 1
        dw $001C                ;hot-head hop bonus 2
        dw $0074                ;hot-head hop bonus 3

        dw $00AB                ;kannon's klaim bonus 1
        dw $00AD                ;kannon's klaim bonus 2
        dw $00AA                ;kannon's klaim bonus 3

        dw $0083                ;lava lagoon bonus 1
        dw !null_pointer
        dw !null_pointer

        dw $0076                ;red-hot ride bonus 1
        dw $0077                ;red-hot ride bonus 2
        dw !null_pointer

        dw $00AC                ;squawk's shaft bonus 1
        dw $00BA                ;squawks's shaft bonus 2
        dw $00A9                ;squawk's shaft bonus 3

        dw !null_pointer        ;boss

        dw !null_pointer
        dw !null_pointer

world_3_bonuses:
        dw $0089                ;barrel bayou bonus 1
        dw $008A                ;barrel bayou bonus 2
        dw !null_pointer

        dw $0084                ;glimmer's galleon bonus 1
        dw $0082                ;glimmer's galleon bonus 2
        dw !null_pointer

        dw $008B                ;krochead klamber bonus 1
        dw !null_pointer
        dw !null_pointer

        dw $0072                ;rattle battle bonus 1
        dw $007F                ;rattle battle bonus 2
        dw $0073                ;rattle battle bonus 3

        dw $007A                ;slime climb bonus 1
        dw $007E                ;slime climb bonus 2
        dw !null_pointer

        dw $00A6                ;bramble blast bonus 1
        dw $00A0                ;bramble blast bonus 2
        dw !null_pointer

        dw !null_pointer        ;boss

        dw !null_pointer
        dw !null_pointer

world_4_bonuses:
        dw $00AE                ;hornet hole bonus 1
        dw $00B3                ;hornet hole bonus 2
        dw $00B0                ;hornet hole bonus 3

        dw $00A1                ;target terror bonus 1
        dw $00C1                ;target terror bonus 2
        dw !null_pointer

        dw $00A2                ;bramble scramble bonus 1
        dw !null_pointer
        dw !null_pointer

        dw $00C3                ;rickety race bonus 1
        dw !null_pointer
        dw !null_pointer

        dw $008C                ;mudhole marsh bonus 1
        dw $008D                ;mudhole marsh bonus 2
        dw !null_pointer

        dw $00B4                ;rambi rumble bonus 1
        dw $00B2                ;rambi rumble bonus 2
        dw !null_pointer        

        dw !null_pointer        ;boss

        dw !null_pointer
        dw !null_pointer

world_5_bonuses:
        dw $0085                ;ghostly grove bonus 1
        dw $0088                ;ghostly grove bonus 2
        dw !null_pointer

        dw $00BD                ;haunted hall bonus 1
        dw $00C2                ;haunted hall bonus 2
        dw $00C0                ;haunted hall bonus 3

        dw $0086                ;gusty glade bonus 1
        dw $0087                ;gusty glade bonus 2
        dw !null_pointer

        dw $00B1                ;parrot chute panic bonus 1
        dw $00AF                ;parrot chute panic bonus 2
        dw !null_pointer

        dw $00A4                ;web woods bonus 1
        dw $00BC                ;web woods bonus 2
        dw !null_pointer

        dw !null_pointer        ;boss

        dw !null_pointer
        dw !null_pointer

world_6_bonuses:
        dw $0093                ;arctic abyss bonus 1
        dw $0095                ;arctic abyss bonus 2
        dw !null_pointer

        dw $00BB                ;windy well bonus 1
        dw $00A3                ;windy well bonus 2
        dw !null_pointer

        dw $00B7                ;castle crush bonus 1
        dw $00B8                ;castle crush bonus 2
        dw !null_pointer

        dw $0091                ;clapper's cavern bonus 1
        dw $0092                ;clapper's cavern bonus 2
        dw !null_pointer

        dw $00B5                ;chain-link chamber bonus 1
        dw $00B6                ;chain-link chamber bonus 2
        dw !null_pointer

        dw $00A5                ;toxic tower bonus 1
        dw !null_pointer
        dw !null_pointer

world_7_bonuses:
        dw $00A7                ;screech's sprint bonus 1
        dw !null_pointer
        dw !null_pointer

        dw !null_pointer        ;boss

        dw !null_pointer
        dw !null_pointer

world_8_bonuses:
        dw $0098                ;jungle jinx bonus 1
        dw !null_pointer
        dw !null_pointer

        dw $0094                ;black ice battle bonus 1
        dw !null_pointer
        dw !null_pointer

        dw $0097                ;klobber karnage bonus 1
        dw !null_pointer
        dw !null_pointer

        dw $009E                ;fiery furnace bonus 1
        dw !null_pointer
        dw !null_pointer

        dw $009D                ;animal antics bonus 1