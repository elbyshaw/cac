# Tool explanations

## Yosys

Yosys is essentially a compiler for Hardware Description Languages. It takes high-level code written in Verilog and turns it into a bitstream that is hardware-implementable 

### What does it do?

It handles synthesis for HDL code, which converts the code to a gate-level netlist

### How do we use it?

Calling Yosys on a file converts it into a netlist which is readable by OpenROAD which does the physical design (place and route) to map the GDSII layout. 

## Implementation

Investigate OpenROAD, OpenLane2, and LibreLane.

### Explain the differences between each toolset

OpenRoad is the base for RTL to GDSII, where Openlane2 and Librelane are flows built on top of OpenRoad, using Yosys for synthesis. 
Openlane2 is the precursor to Librelane, which is a flow built using Openlane2's codebase that offers enhanced modularity on top of Openroad2's ability to fully customize flows. 
Librelane is also fully open source and community built. 

### Which one should we use? Do we need to use more than one?

Librelane is the most up-to-date flow tool. Technically by using Librelane we are using all three tools. 

## Extra Features

### What do Magic and Klayout do?

Magic is a tool used by Librelane to do verification for a chip design. 
Klayout is another tool used by Librelane for viewing chip layouts and debugging parts of the design. 

### How do we use them?

Magic and Klayout are not used seperate from Librelane, they are integrated into the Librelane flow for their intended purposes and run automatically. 

### Are they necessary for what we're doing?

Verification of designs is most important step of a flow, and the use of Magic is absolutely integral to that. Magic as well as Klayout are built into librelane 
and are generally not used seperate from the flow. 


# Challenge/extension:

_Cadence is a proprietary suite of tools we use in SiliconJackets. See if you can compile a list of Cadence tools that you think would be necessary to take a design from RTL to GDSII_

Cadence uses Xcelium as a logic simulator, which isn't necessary for creating designs but is helpful
Genus is used for synthesis -- YOSYS in Librelane
Modus is used for DFT -- Difetto in Librelane, also handles ATPG
Innovus is used for place and route -- OpenROAD in Librelane, FastRoute for global routing
Tempus is used for timing analysis -- OpenSTA in Librelane
Voltus is used for power analysis
Quantus is used to calculate parasitic RLC for more accurate performance predicitons. 

_Explain what each of the following acronyms mean:_

**RTL:** Register-Transfer Level is an abstraction level for describing how data flows between registers in an IC design. 

**GDSii:** Graphic Data System II is the industry standard for displaying IC layout data. 

**DFT:** Design For Testability involves adding logic and structures to Verilog code before synthesis that make it easier to test a design

**ATPG:** Automatic Test Pattern Generation is an EDA method that creates test patterns to find defects in chip design, like shorts or open circuits. 

**DRC:** Design Rule Checking is the process that verifies a chip layout against foundry manufacturing rules to make sure the design is actually manufacturable and reliable. 

**LVS:** Layout Versus Schematic is a verification step in the design process that the physical layout matches the schematic or netlist derived from the RTL design. 

**LEC:** Logic Equivalence Checking is a verification method that checks that a generated netlist's output matches the intended logical function from the RTL code. 

**STA:** Static Timing Analysis is used to verify a chip's speed by checking all signal paths for possible timing violations. 


