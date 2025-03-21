# XDC for humandata XP68-06
# parts xc7s50-1csga324
# set_property PACKAGE_PIN R7 [get_ports OEA]
# set_property IOSTANDARD LVCMOS33 [get_ports OEA]

# set_property PACKAGE_PIN C13 [get_ports OEB]
# set_property IOSTANDARD LVCMOS33 [get_ports OEB]

################################################################
## Power
################################################################

# V33P PLCC35,36
# GND  PLCC09,10,26,27,43,44,60,61
# L3,P4,U5    VIOA # PLCC45,62 VCCO_34
# C15,F16,J17 VIOB # PLCC11,28 VCCO_15

# IO Bank 14 = 3.3V
# IO Bank 34 = VIOA (= 3.3V)
# IO Bank 15 = VIOB (= 3.3V)

################################################################
## clock
################################################################
#         N15  GCLK50  IO_L12P_T1_MRCC_14
#         G16  GCLK50B  IO_L14P_T2_SRCC_15


set_property PACKAGE_PIN N15 [get_ports CLK]
set_property IOSTANDARD LVCMOS33 [get_ports CLK]
create_clock -period 20.000 -name CLK -waveform {0.000 10.000} -add [get_ports CLK]


################################################################
## Config
################################################################

# PLCC32  D9   TCK  TCK_0
# PLCC37  R9   TDI  TDI_0
# PLCC33  T8   TDO  TDO_0
# PLCC34  T9   TMS  TMS_0

#set_property BITSTREAM.CONFIG.CONFIGRATE 66 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

#         C8   S_CLOCK  CCLK_0
#         M13  S_SELCTn IO_L6P_T0_FCS_B_14
#         K17  S_D0     IO_L1P_T0_D00_MOSI_14
#         K18  S_D1     IO_L1N_T0_D01_DIN_14
#         L14  S_D2     IO_L2P_T0_D02_14
#         M15  S_D3     IO_L2N_T0_D03_14

# set_property PACKAGE_PIN C8  [get_ports S_CLK]
# set_property PACKAGE_PIN M13 [get_ports S_FCSB]
# set_property PACKAGE_PIN K17 [get_ports S_D0]
# set_property PACKAGE_PIN K18 [get_ports S_D1]
# set_property PACKAGE_PIN L14 [get_ports S_D2]
# set_property PACKAGE_PIN M15 [get_ports S_D3]
# set_property IOSTANDARD LVCMOS33 [get_ports {S_*}]
#set_false_path -to [get_ports {S_*}]
#set_false_path -from [get_ports {S_D*}]

################################################################
## on-board LED
################################################################

#         V12  ULED  IO_L24N_T3_D16_14
# set_property PACKAGE_PIN V12 [get_ports ULED]
# set_property IOSTANDARD LVCMOS33 [get_ports ULED]
# set_false_path -to [get_ports ULED]

################################################################

# #CNA 7
# set_property PACKAGE_PIN R7 [get_ports c1]
# set_property IOSTANDARD LVCMOS33 [get_ports c1]
# #set_property PULLDOWN true [get_ports UARTTX]

# #CNA 8
# set_property PACKAGE_PIN L6 [get_ports binarization_out1]
# set_property IOSTANDARD LVCMOS33 [get_ports binarization_out1]

# #CNA 9
# set_property PACKAGE_PIN K6 [get_ports Bounce_Remover_outc1]
# set_property IOSTANDARD LVCMOS33 [get_ports Bounce_Remover_outc1]

# #CNA 10
# set_property PACKAGE_PIN M4 [get_ports mixer_out1]
# set_property IOSTANDARD LVCMOS33 [get_ports mixer_out1]

# #CNA 11
# set_property PACKAGE_PIN L5 [get_ports c2]
# set_property IOSTANDARD LVCMOS33 [get_ports c2]

# #CNA 12
# set_property PACKAGE_PIN L4 [get_ports binarization_out2]
# set_property IOSTANDARD LVCMOS33 [get_ports binarization_out2]

# #CNA 13
# set_property PACKAGE_PIN K4 [get_ports Bounce_Remover_outc2]
# set_property IOSTANDARD LVCMOS33 [get_ports Bounce_Remover_outc2]

# CNA 14
set_property PACKAGE_PIN N3 [get_ports init]
set_property IOSTANDARD LVCMOS33 [get_ports init]

# #CNA 17
# set_property PACKAGE_PIN N2 [get_ports c3]
# set_property IOSTANDARD LVCMOS33 [get_ports c3]

# #CNA 18
# set_property PACKAGE_PIN K3 [get_ports binarization_out3]
# set_property IOSTANDARD LVCMOS33 [get_ports binarization_out3]

# #CNA 19
# set_property PACKAGE_PIN K2 [get_ports Bounce_Remover_outc3]
# set_property IOSTANDARD LVCMOS33 [get_ports Bounce_Remover_outc3]

# #CNA 20
# set_property PACKAGE_PIN P2 [get_ports mixer_out3]
# set_property IOSTANDARD LVCMOS33 [get_ports mixer_out3]

# #CNA 21
# set_property PACKAGE_PIN P1 [get_ports so1]
# set_property IOSTANDARD LVCMOS33 [get_ports so1]

# #CNA 22
# set_property PACKAGE_PIN K1 [get_ports so2]
# set_property IOSTANDARD LVCMOS33 [get_ports so2]

# #CNA 23
# set_property PACKAGE_PIN L1 [get_ports so3]
# set_property IOSTANDARD LVCMOS33 [get_ports so3]

# #CNA 27
# set_property PACKAGE_PIN N1 [get_ports init]
# set_property IOSTANDARD LVCMOS33 [get_ports init]

# #CNA 29
# set_property PACKAGE_PIN R2 [get_ports UARTTX]
# set_property IOSTANDARD LVCMOS33 [get_ports UARTTX]






#CNB 7
set_property PACKAGE_PIN C13 [get_ports c1]
set_property IOSTANDARD LVCMOS33 [get_ports c1]

#CNB 8
set_property PACKAGE_PIN A13 [get_ports dfil_new_out1]
set_property IOSTANDARD LVCMOS33 [get_ports dfil_new_out1]

#CNB 9
set_property PACKAGE_PIN B13 [get_ports Bounce_Remover_outc1]
set_property IOSTANDARD LVCMOS33 [get_ports Bounce_Remover_outc1]

#CNB 10
set_property PACKAGE_PIN A14 [get_ports mixer_out1]
set_property IOSTANDARD LVCMOS33 [get_ports mixer_out1]

#CNB 11
set_property PACKAGE_PIN B14 [get_ports c2]
set_property IOSTANDARD LVCMOS33 [get_ports c2]

#CNB 12
set_property PACKAGE_PIN A15 [get_ports dfil_new_out2]
set_property IOSTANDARD LVCMOS33 [get_ports dfil_new_out2]

#CNB 13
set_property PACKAGE_PIN B15 [get_ports Bounce_Remover_outc2]
set_property IOSTANDARD LVCMOS33 [get_ports Bounce_Remover_outc2]

#CNB 14
set_property PACKAGE_PIN E13 [get_ports mixer_out2]
set_property IOSTANDARD LVCMOS33 [get_ports mixer_out2]

#CNB 17
set_property PACKAGE_PIN F13 [get_ports c3]
set_property IOSTANDARD LVCMOS33 [get_ports c3]

#CNB 18
set_property PACKAGE_PIN E14 [get_ports dfil_new_out3]
set_property IOSTANDARD LVCMOS33 [get_ports dfil_new_out3]

#CNB 19
set_property PACKAGE_PIN E15 [get_ports Bounce_Remover_outc3]
set_property IOSTANDARD LVCMOS33 [get_ports Bounce_Remover_outc3]

#CNB 20
set_property PACKAGE_PIN G15 [get_ports mixer_out3]
set_property IOSTANDARD LVCMOS33 [get_ports mixer_out3]

#CNB 21
set_property PACKAGE_PIN H15 [get_ports so1]
set_property IOSTANDARD LVCMOS33 [get_ports so1]

#CNB 22
set_property PACKAGE_PIN E18 [get_ports so2]
set_property IOSTANDARD LVCMOS33 [get_ports so2]

#CNB 23
set_property PACKAGE_PIN F18 [get_ports so3]
set_property IOSTANDARD LVCMOS33 [get_ports so3]

# #CNB 24
# set_property PACKAGE_PIN G18 [get_ports dfil_new_out1]
# set_property IOSTANDARD LVCMOS33 [get_ports dfil_new_out1]

#CNB 29
set_property PACKAGE_PIN H16 [get_ports UARTTX]
set_property IOSTANDARD LVCMOS33 [get_ports UARTTX]