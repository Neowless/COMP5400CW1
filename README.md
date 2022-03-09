# COPM5400 Coursework1

## Question 1 

### Fitness Plot of the Mice as a Function of the Genertion Count 
<div align=center><img width="500" src="https://raw.githubusercontent.com/Neowless/COMP5400CW1/e1373e0b9de5c8d6b2b86aaf0ce66d0b625631d2/Question1/0-400.svg"/></div>

<div align=center><text>Figure 1. Average and Best Fitness versus Generation Count</text></div>

The simulation results are exported in the [`Question1/Mice.pop`](https://github.com/Neowless/COMP5400CW1/blob/main/Question1/Mice.pop), the data is extracted in [`Question1/question_1.mat`](https://github.com/Neowless/COMP5400CW1/blob/main/Question1/question_1.mat), the plots are generated by MATLAB 2021b, the scripts for generating the plots is [`Question1/Question1.m`](https://github.com/Neowless/COMP5400CW1/blob/main/Question1/Question1.m).
***
### Reasons Why Choosing This Range

The simulation was terminated after 3,000 generations to obtain enough data. [Figure 2](https://raw.githubusercontent.com/Neowless/COMP5400CW1/e1373e0b9de5c8d6b2b86aaf0ce66d0b625631d2/Question1/0-3000.svg) shows the whole range of the data.


<div align=center><img width="500" src="https://raw.githubusercontent.com/Neowless/COMP5400CW1/e1373e0b9de5c8d6b2b86aaf0ce66d0b625631d2/Question1/0-3000.svg"/></div>

<div align=center><text>Figure 2. Average and Best Fitness Versus Generation Count Whole Range</text></div>

* For the generation count range. In the generation domain from 0 to 150, the values of average fitness are highly irregular. In the range of 150-400, the average fitness numbers increase non-linearly. After 400 generations, the average fitness of the mice becomes stable around 0.008. The best fitness value also has similar characteristics. The generation range for both fitness are **0-400**
* For the fitness range. Considering the noise level and representive generation range. 

## Question 2

The mice evolves fatser, smarter and more efficient seeking the cheese over evolutionary time. The specific behaviours in explained in [Table 1]()

| Generation Count | Behaviour | 
| ---  | --- |
| 0    | The mice move randomly and slowly, most of them are circling, only a few of the mice are moving at a relative faster speed in a relative straight line. The mice rarely obtain the cheese.| 
|   300   | The mice increase the speed. A few of mice’s movement show regular rules aiming at the cheese. However, the whole specie’s behaviours are irregular. After finishing one cheese, the mice just keep the previous direction. Some of the mice obtain the cheese. | 
|    500   | The behaviour does not change a lot, but the moving speed of the mice increase a little. Some of the mice are competing for one cheese.|
| 1000 | All of the mice are moving at a relative high speed, the mice are divided into many groups, each group usually competing for one cheese, after finishing one cheese, the mice are really sensitive to the nearest cheese and change its direction to obtain another cheese. | 
| 4000 | The mice started to rotate on the spot to evaluate the distances of the cheese around it which is a more efficient way to decide the behaviour. |

<div align=center><text>Table 1. Mice Behaviours in Different Generations</text></div>

## Question 3

### Discrition of the Fitness Function Used by the Mice

The fitness used by the Mice is in [`Question1/mouse.cc`](https://github.com/Neowless/COMP5400CW1/blob/main/Question1/mouse.cc) line 136-143.

``` C++
	// The EvoMouse's fitness is the amount of cheese collected, divided by
	// the power usage, so a mouse is penalised for simply charging around
	// as fast as possible and randomly collecting cheese - it needs to find
	// its target carefully.
	virtual float GetFitness()const
	{
		return This.cheesesFound > 0 ? static_cast<float>(This.cheesesFound) / This.DistanceTravelled.as<float>() : 0;
	}
}
```
The fitness of each mouse is obtained this `GetFitness()` function. There are two vairables in this function, `This.cheesesFound` indicates the cheeses found by the mouse in this generation simulation, and `This.DistanceTravelled.as` represents the distance the mouse travled in this generation.

If the mouse found the cheese, its fitness value equals to the amount of the cheese divided by the distance it travled, or the fitness value equals to 0.
ß
In order to train the mice forming a efficient way to find the cheese, the distance travled by the mouse determins the power consumption influencing the fitness value.
*** 

### Experiment with Different Fitness Functions Case 1

In case 1, the cheese number and the travled distance were changed irrelevant to the fitness function.

``` C++
	virtual float GetFitness()const
	{
		return This.cheesesFound > 0 ? 0: 0;
	}
}
```
When the simulation started, the behaviour of the mice is similar to the original fitness function ones.

With the increment of the simulation generation count, the behaviour becomes more random and caotic. The performance of the mice deteriorated.

### Experiment with Different Fitness Functions Case 2

In case 2, the fitness value and the amount of the cheese collected has first order linear relationship. The fitnesee equals to the amount of the cheese divided by 100.

``` C++
	virtual float GetFitness()const
	{
		return This.cheesesFound > 0 ? static_cast<float>(This.cheesesFound)/100 /: 0;
	}
}
```
When the simulation started, the behaviour of the mice is similar to the original fitness function ones.

With the increment of the simulation generation count, the behaviour becomes similar to the original fitness function, but the evololution speed decrease a lot. The performance of the mice deteriorated.

### Experiment with Different Fitness Functions Case 3

In case 3, the fitness value and the travled distance has first order linear relationship. The fitnesee equals to the travled distance of the mouse divided by 1000.

``` C++
	virtual float GetFitness()const
	{
		return This.cheesesFound > 0 ? This.DistanceTravelled.as<float>()/10000 /: 0;
	}
}
```
When the simulation started, the behaviour of the mice is similar to the original fitness function ones.

With the increment of the simulation generation count, speed of the mice increased a lot, and the mice just move directly rather than change its direction. The performance of the mice deteriorated.

The fitness function determines the **trend** and **efficiency** of the evolution.


*** 
### Parameters in Genetic Algorithm

The fitness used by the Mice is in [`Question1/mouse.cc`](https://github.com/Neowless/COMP5400CW1/blob/main/Question1/mouse.cc) line 159-185.

``` C++
class MouseSimulation : public Simulation
{
	GeneticAlgorithm<EvoMouse> theGA;
	Population<EvoMouse> theMice;
//	Group<Mouse> theMice;
	Group<Cheese> theCheeses;

public:
	MouseSimulation():
	theGA(0.7f, 0.05f),	// Crossover probability of 0.7, mutation probability of 0.05
//	theMice(30),		// 30 mice are in the population.
	theMice(30, theGA), // 30 mice are in the population.
	theCheeses(30)		// 30 cheeses are around at one time.
	{
		// We're using a rank selection method. Consult the BEAST
		// documentation for GeneticAlgorithm, the ar23 course slides or
		// a good book on GAs for more details.
		This.theGA.SetSelection(GA_RANK);
		// The ranking selection pressure is set to 2.
		This.theGA.SetParameter(GA_RANK_SPRESSURE, 2.0);

		This.SetTimeSteps(100);

		This.Add("Mice", This.theMice);
		This.Add("Cheeses", This.theCheeses);
	}
};
```

|  Parameters |  Source Code |  Influence |
|---|---|---|
|  Crossover Probability | `theGA(0.7f, 0.05f)`  | The core in the evolution of nature is played by the crossover of biological genes. Similarly, The core in genetic algorithms is played by the crossover operator of genetic operations. A crossover is an operation in which parts of the structure of two parent individuals are replaced and recombined to create a new individual. By crossover, the search power of genetic algorithms is improved by leaps and bounds.  |
| Mutation Probability  |  `theGA(0.7f, 0.05f)` |  The mutation operator is applied to change the value of a gene at some locus of a string of individuals in a population. When a genetic algorithm has approached the neighbourhood of the optimal solution through the crossover operator, this local stochastic search capability of the variation operator can be used to accelerate convergence to the optimal solution. The variation operator maintains population diversity to prevent immature convergence. |
| Selection Option |  `This.theGA.SetSelection(GA_RANK)` |  The rank proportional selection of the invidual is used, preventing one or twooverwhelmingly fit individuals in a population from dominating the nextgeneration. So if in a population of 3 individuals you had scores of(2, 3, 400), rank selection would convert these to (0.167, 0.333, 0.5). |
|  Ranking Selection Pressure | `This.theGA.SetParameter(GA_RANK_SPRESSURE, 2.0)`  |  When the pressure is low, we have relatively few randomly selected individuals, so that each individual faces less competitive pressure and thus has a higher probability of being selected. |
|  Simulation Time |  `This.SetTimeSteps(100)` | The simulation time determines the amount of the total behaviours in each generation  |

<div align=center><text>Table 2. Parameters in Genetic Algorithms</text></div>

## Question 4

### Performance Criterions and Evaluation

The fitness function should be evaluated in different aspects, the evolution time and final performance.

In this section, the original fitness function is the original fitness function applied in the [`Question4/mouse.cc`](https://github.com/Neowless/COMP5400CW1/blob/main/Question4/mouse.cc) line 136-143. The fitness equals to the amount of cheese collected, divided by the distance it traveld.

``` C++
	// The EvoMouse's fitness is the amount of cheese collected, divided by
	// the power usage, so a mouse is penalised for simply charging around
	// as fast as possible and randomly collecting cheese - it needs to find
	// its target carefully.
	virtual float GetFitness()const
	{
		return This.cheesesFound > 0 ? static_cast<float>(This.cheesesFound) / This.DistanceTravelled.as<float>() : 0;
	}
}
```

The new fitness function refers to [`Question4/mouse_new.cc`](https://github.com/Neowless/COMP5400CW1/blob/main/Question4/mouse_new.cc) line 136-14. The fitness equals to the amount of cheese collected.

``` C++
	// The EvoMouse's fitness is the amount of cheese collected.
	virtual float GetFitness()const
	{
		return This.cheesesFound > 0 ? static_cast<float>(This.cheesesFound) : 0;
	}
}
```

**Evolution Time**

Evolution time is defined as the generation count the simulation took to make  the fitness value stable. Less generation amount it takes, better the fitness function it will be.

<div align=center><img width="500" src="https://raw.githubusercontent.com/Neowless/COMP5400CW1/8bfcf0359dbbc4b6d3d22aa16622ab200e2b5546/Question4/Converge_Compare.svg"/></div>

<div align=center><text>Figure 3. Convergenge of Different Fitness Function Comapre </text></div>

**Stability of Average Fitness Value**

This is defined by the average fitness value's stability and noise level. Healthier specie has more stable average fitness value.



**Cheese Allocation**

This is defined by the  which defined by the standard deviation of all the fitness values after 1000 generations of evolution. Smaller standart deviation indicates the fitness function has better performance

***



### 


*** 
### Experiment with Different Sensor Configurations




*** 
### Reasons Behind Experiment