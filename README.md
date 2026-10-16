# Password-Based Digital Door Lock System Using Verilog HDL

## Project objective
Design and verify a serial password-based digital door lock using
Verilog HDL, with SKY130 standard-cell synthesis and static timing analysis.

## Password operation
- Correct password: 1011
- Incorrect password tested: 1001
- Input: serial_in
- Outputs: unlock
- Clock: clk
- Reset: active-low rst_n

## Verification
RTL simulation passed for the correct and incorrect password test cases.

## Synthesis results
- Technology library: SKY130 HD
- Mapped standard cells: 11
- Sequential cells: 6
- Reported mapped cell area: 178.9216 square micrometres

See `reports/synthesis.log` for the synthesis log.

## Static timing analysis
- Clock period constraint: 20 ns
- Worst reported maximum slack: 18.68 ns
- Reported minimum-path hold slack: 0.35 ns

See `reports/sta.log` and `reports/sta.tcl`.

These are pre-layout results. Full RTL-to-GDS implementation,
routed timing, DRC and LVS have not yet been verified.

## Multi-corner pre-layout STA

All three separate STA runs completed successfully.

| Timing corner | Maximum slack (ns) | Minimum slack (ns) |
|---|---:|---:|
| TT, 25°C, 1.80 V | 18.68 | 0.35 |
| SS, 100°C, 1.60 V | 18.34 | 0.71 |
| FF, -40°C, 1.95 V | 18.80 | 0.22 |

The analysis used a 20 ns clock period and the SKY130 HD timing
library. These are pre-layout results; routed parasitics and
signoff timing have not been verified.
