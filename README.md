# COPM5400 Coursework1

## Question 1 

### Fitness Plot of the Mice as a Function of the Genertion Count
<div align=center><img width="400" src="https://raw.githubusercontent.com/Neowless/COMP5400CW1/e1373e0b9de5c8d6b2b86aaf0ce66d0b625631d2/Question1/0-400.svg"/></div>

<div align=center><text>Fig 1. Average and Best Fitness versus Generation Count from 0-400</text></div>

The simulation results are exported in the Qustion1.pop, opened with Visual Studio Code and pasted in MATLAB to generate the figures.

### Reason Why Choosing This Range

This repository is where you will develop a driver for the Seven Segment Display peripherals on the DE1-SoC.

Please refer to the assignment specification on Minerva for more details.

The following files are provided:
 
| File | Purpose |
| ---  | --- |
| `1-A-SevenSegDisplay/.project`      | Skeleton DS-5 project definition |
| `1-A-SevenSegDisplay/.cproject`     | As above |
| `1-A-SevenSegDisplay/main.c`        | A test program which will allow you to test your solution (**do not modify**). |
| `1-A-SevenSegDisplay/DE1SoC_SevenSeg/DE1SoC_SevenSeg.h` | The header file which defines the interface for the driver (**do not modify**). |
| `1-A-SevenSegDisplay/DE1SoC_SevenSeg/DE1SoC_SevenSeg.c` | The implementation file for the driver. You need to complete this file. |

Please note the project will need configuring in DS-5 before it will compile.

## Driver Functions 

| Function Name  | Introduction
| ---  | --- |
| DE1SoC_SevenSeg_Write         | Low level set function to send a byte value to a selected display.             |
| DE1SoC_SevenSeg_SetSingle     | Set a single seven segment display from a hexadecimal (0x0-0xF) value.    |
| DE1SoC_SevenSeg_SetDoubleHex  | Set a pair of seven segment displays from a hexadecimal (0x00-0xFF) value.  |
| DE1SoC_SevenSeg_SetDoubleDec  | Set a pair of seven segment displays from a decimal (00-99) value.          |

### Required Layouts for the Hexadecimal Numbers 0-F
<div align=center><img width="100" src="https://raw.githubusercontent.com/leeds-embedded-systems/ELEC5620M-Assignment1-Neowless/main/Bit_Layout.png?token=GHSAT0AAAAAABSHGZJDANJKLJSFW45MX2SAYROE3XA"/></div>

<div align=center><text>Fig 1. Bit Mapping Layout</text></div>

<div align=center><img width="500" src="Required_Layouts.png"/></div>

<div align=center><text>Fig 2. Hexadecimal Number Layout</text></div>

### Anode or Cathode?
The 7-Segment displays on the DE-Soc share their **anode**.

<div align=center><img width="500" src="Schematic_Diagram.png"/></div>

<div align=center><text>Fig 2.Schematic Diagram for 7 Segment Displays</text></div>

If the type of the displays have been changed in to cathode version, just replace the mapping table with the commented one in  `DE1SoC_SevenSeg_SetSingle` function in the [`1-A-SevenSegDisplay/DE1SoC_SevenSeg/DE1SoC_SevenSeg.c`](https://github.com/leeds-embedded-systems/ELEC5620M-Assignment1-Neowless/blob/main/1-A-SevenSegDisplay/DE1SoC_SevenSeg/DE1SoC_SevenSeg.c).



```
void DE1SoC_SevenSeg_SetSingle(unsigned int display, unsigned int value) {
    // ToDo: Write the code for driving a single seven segment display here.
    // Your function should turn a real value 0-F into the correctly encoded
    // bits to enable the correct segments on the seven segment display to
    // illuminate. Use the DE1SoC_SevenSeg_Write function you created earlier
    // to set the bits of the display.

	// Mapping_Table array defines the layout of the 7-Segment displays
	//including 0-9 and A-F, which is a mapping or translation between the
	//hex or decimal input and the actual output bit connected to the 7 segment
	//displays.
	
	// Table for 7 segment displays with common Anode.
	char Mapping_Table[]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f,0x77,0x7c,0x39,0x5e,0x79,0x71};
	// Table for 7 segment display with common Cathode.
	//char table[]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90,0x88,0x83,0xc6,0xa1,0x86,0x8e};

	//Call the lower function to display the value.
	DE1SoC_SevenSeg_Write(display, Mapping_Table[value]);
}
```