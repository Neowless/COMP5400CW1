// Vim users: for increased viewing pleasure :set ts=4

#include "neuralanimat.h"
#include "sensor.h"
#include "population.h"

using namespace std;
using namespace BEAST;

// A Cheese is a small, yellow WorldObject which changes position when
// the Eaten method is called on it (i.e. a Mouse collides with it)
class Cheese : public WorldObject
{
public:
	Cheese()
	{
		This.Radius = 2.5f;							 // Cheeses are quite small
		This.SetColour(ColourPalette[COLOUR_YELLOW]);// Cheeses are yellow
		This.InitRandom = true;						 // Cheases are scattered
	}
	virtual ~Cheese(){}

	// When a Cheese is Eaten, it reappears in a random location.
	void Eaten()
	{
		This.Location = This.MyWorld->RandomLocation();
	}
};

// This Mouse uses a simple calculation to forage for cheese.
class Mouse : public Animat
{
public:
	Mouse()
	{
		This.Add("angle", NearestAngleSensor<Cheese>());
		This.InitRandom = true;
	}

	// This incredibly simple control function is all a Mouse needs to
	// forage successfully - can our neural nets do as well?
	virtual void Control()
	{
		double o = This.Sensors["angle"]->GetOutput();
		This.Controls["right"] = 0.5 - (o > 0.0 ? o : 0.0);
		This.Controls["left"] = 0.5 + (o < 0.0 ? o : 0.0);
	}

	// This is called when a Mouse collides with any object in the World.
	// If the object is a Cheese, the Eaten method is called on Cheese.
	virtual void OnCollision(WorldObject* obj)
	{
		Cheese* cheese;

		if (IsKindOf(obj,cheese)) {
			cheese->Eaten();
		}

		Animat::OnCollision(obj);
	}
};

// This mouse uses a FeedForwardNet to locate the nearest cheese using a
// NearestAngleSensor. No GA or other learning algorithm is involved.
class NeuralMouse : Mouse
{
public:
	NeuralMouse(): myBrain(1, 2, 2, false)
	{
		vector<float> ffnConfig;
		ffnConfig.push_back(-1.0f);	// 1st input 1st weight
		ffnConfig.push_back( 0.0f); // 1st input bias
		ffnConfig.push_back( 1.0f); // 2nd input 1st weight
		ffnConfig.push_back( 0.0f); // 2nd input bias

		ffnConfig.push_back( 0.0f); // 1st hidden 1st weight (for input 1)
		ffnConfig.push_back( 1.0f); // 1st hidden 2nd weight (for input 2)
		ffnConfig.push_back(-0.5f); // 1st hidden bias
		ffnConfig.push_back( 1.0f); // 2nd hidden 1st weight (for input 1)
		ffnConfig.push_back( 0.0f); // 2nd hidden 2nd weight (for input 2)
		ffnConfig.push_back(-0.5f); // 2nd hidden bias

		This.myBrain.SetConfiguration(ffnConfig);
	}

	// Here the single sensor output is set as the input for the FFN, the
	// FFN is fired once and the two controls are set to the output values.
	// Note that the original Mouse::Control method is overridden by this one.
	virtual void Control()
	{
		This.myBrain.SetInput(0, This.Sensors["angle"]->GetOutput());

		This.myBrain.Fire();

		This.Controls["left"] = myBrain.GetOutput(0);
		This.Controls["right"] = myBrain.GetOutput(1);
	}

private:
	FeedForwardNet myBrain;
};

// In an ideal world, EvoMouse would inherit from Mouse, thereby getting
// the same OnCollision function and initialisation code as Mouse, but
// it's more convenient to inherit from EvoFFNAnimat which gives us all
// the GA and FFN code. Multiple inheritance would be another option, but
// introduces a host of other unwanted complications.
class EvoMouse : public EvoFFNAnimat
{
public:
	EvoMouse(): cheesesFound(0)
	{
		This.Add("angle", NearestAngleSensor<Cheese>());
// An alternative to the NearestAngleSensor is the Proximity Sensor, which
// gives less precise directional information, but does let the mouse know
// how far away the cheese is.
//		This.Add("proximity", ProximitySensor<Cheese>(PI/8, 80.0, 0.0));
		This.InitRandom = true;
		This.InitFFN(4);
	}

	// This is identical to the OnCollision method for Mouse, except here we
	// are also recording the number of cheeses eaten.
	virtual void OnCollision(WorldObject* obj)
	{
		Cheese* cheese;

		if (IsKindOf(obj,cheese)) {
			cheesesFound++;
			cheese->Eaten();
		}

		EvoFFNAnimat::OnCollision(obj);
	}

	// The EvoMouse's fitness is the amount of cheese collected, divided by
	// the power usage, so a mouse is penalised for simply charging around
	// as fast as possible and randomly collecting cheese - it needs to find
	// its target carefully.
	virtual float GetFitness()const
	{
		return This.cheesesFound > 0 ? static_cast<float>(This.cheesesFound) / This.DistanceTravelled.as<float>() : 0;
	}

	// Overloading the ToString method allows us to output a small amount of
	// information which is visible in the status bar of the GUI when a
	// mouse is clicked on.
	virtual string ToString()const
	{
		ostringstream out;
		out << " Power used: " << This.PowerUsed;
		return out.str();
	}

private:
	int cheesesFound;	// The number of cheeses collected for this run.
};

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

