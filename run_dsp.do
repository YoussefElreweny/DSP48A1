vlib work
vlog Project1.v DSP_tb.v
vsim -voptargs=+acc work.DSP48A1_tb
add wave -position insertpoint  \
sim:/DSP48A1_tb/A \
sim:/DSP48A1_tb/B \
sim:/DSP48A1_tb/C \
sim:/DSP48A1_tb/D \
sim:/DSP48A1_tb/clk \
sim:/DSP48A1_tb/RSTA \
sim:/DSP48A1_tb/RSTB \
sim:/DSP48A1_tb/RSTC \
sim:/DSP48A1_tb/RSTD
add wave -position insertpoint  \
sim:/DSP48A1_tb/uut/genblk1/f1/out
add wave -position insertpoint  \
sim:/DSP48A1_tb/uut/genblk2/f2/out
add wave -position insertpoint  \
sim:/DSP48A1_tb/uut/genblk3/f3/out
add wave -position insertpoint  \
sim:/DSP48A1_tb/uut/genblk4/f4/out
add wave -position insertpoint  \
sim:/DSP48A1_tb/uut/genblk6/A2_reg_f/out
add wave -position insertpoint  \
sim:/DSP48A1_tb/uut/genblk7/B1_reg_f/out
add wave -position insertpoint  \
sim:/DSP48A1_tb/uut/genblk8/Mreg_f/out
add wave -position insertpoint  \
sim:/DSP48A1_tb/uut/M_reg_in
add wave -position insertpoint  \
sim:/DSP48A1_tb/uut/M_reg_out
add wave -position insertpoint  \
sim:/DSP48A1_tb/uut/x_out \
sim:/DSP48A1_tb/uut/z_out
add wave -position insertpoint  \
sim:/DSP48A1_tb/uut/genblk5/opmode_f/out
add wave -position insertpoint  \
sim:/DSP48A1_tb/uut/Opmode_reg
add wave -position insertpoint  \
sim:/DSP48A1_tb/uut/PCOUT \
sim:/DSP48A1_tb/uut/P \
sim:/DSP48A1_tb/uut/cout_past_adder \
sim:/DSP48A1_tb/uut/sum_past_adder
add wave -position insertpoint  \
sim:/DSP48A1_tb/CARRYOUT \
sim:/DSP48A1_tb/CARRYOUTF
run -all
#quit -sim