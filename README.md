

# Plan

# Step 1: Small open source module implementation
- Write systolic array simulator in Cpp
- Write systolic array in RTL
- Synthesize with Yosys
- Implement with Librelane
- Extra features?
	- DRC?
	- LVS?
	- LEC?
	- DFT?
- How do the tools work? What issues do we encounter? What can be improved?

# Next steps:
- Improve open source flow?
- Design a more complex / interesting module?

-----

# Tools
Synthesis: Yosys

Implementation: OpenROAD/OpenLane2/Librelane

Signoff/Verification: Magic/Klayout


## Tool explanations

### Yosys

[answer here]

#### What does it do?

[answer here]

#### How do we use it?

[answer here]

### Implementation

Investigate OpenROAD, OpenLane2, and LibreLane.

#### Explain the differences between each toolset

[answer here]

#### Which one should we use? Do we need to use more than one?

[answer here]

### Extra Features

#### What do Magic and Klayout do?

[answer here]

#### How do we use them?

[answer here]

#### Are they necessary for what we're doing?

[answer here]


## Challenge/extension:

_Cadence is a proprietary suite of tools we use in SiliconJackets. See if you can compile a list of Cadence tools that you think would be necessary to take a design from RTL to GDSII_

[answer here]

_Explain what each of the following acronyms mean:_

**RTL:** [answer here]

**GDSii:** [answer here]

**DFT:** [answer here]

**ATPG:** [answer here]

**DRC:** [answer here]

**LVS:** [answer here]

**LEC:** [answer here]

**STA:** [answer here]


----

# Tasks

- Cpp Simulator
- Systolic Array RTL
- RTL Verification
- Open source sapr
- Proprietary sapr
