// Vim users: for increased viewing pleasure :set ts=4

#include "neuralanimat.h"
#include "sensor.h"
#include "population.h"

using namespace std;
using namespace BEAST;

// Forward declaration for Prey
class Predator;

// A Prey is a small Animat which can be evolved with a GA, uses a
// feed forward neural network and has two Predator-detecting sensors.
// It records the number of times it has been eaten and the inverse of
// this number becomes its fitness score.
class Prey : public EvoFFNAnimat
{
public:
	// Prey is initialised with 1 for its timesEaten score, since otherwise
	// we might end up dividing by zero in the fitness function.
	Prey(): timesEaten(1)
	{
		// Two Predator-detecting sensors are added.
		Add("right", ProximitySensor<Predator>(PI/1.05, 100.0, -PI/2));
		Add("left", ProximitySensor<Predator>(PI/1.05, 100.0, PI/2));

		// The FeedForwardNet is initialised with four hidden nodes - the
		// number of inputs and outputs is decided by the number of sensors
		// (2) and the number of controls (2). The InitFFN function determines
		// these values and configures the network accordingly.
		InitFFN(4);
		SetInitRandom(true);
		This.MinSpeed = 0;
		This.MaxSpeed = 100;
	}

	// As with Cheeses, when a Predator collides with a Prey, the Eaten
	// method is called and the prey is repositioned somewhere random
	// in the World.
	void Eaten()
	{
		timesEaten++;
		This.Location = static_cast<World&>(This.MyWorld).RandomLocation();
	}

	float GetFitness()const
	{
		return 1.0f / static_cast<float>(timesEaten);
	}

	// This just lets us track the performance of individual Prey in the GUI.
	virtual string ToString()const
	{
		ostringstream out;
		out << "Times eaten: " << timesEaten << " Current fitness: " << GetFitness();
		return out.str();
	}

private:
	int timesEaten;
};

// The Predator class is an Animat which can be evolved in a GA and uses a
// feed forward neural network. It's fitness score depends on how many
// Prey it manages to collide with.
class Predator : public EvoFFNAnimat
{
public:
	Predator():preyEaten(0)
	{
		Add("left", ProximitySensor<Prey>(PI/5, 200.0, -PI/20));
		Add("right", ProximitySensor<Prey>(PI/5, 200.0, PI/20));

		InitFFN(4);
		SetInitRandom(true);

		This.MinSpeed = 0;
		This.MaxSpeed = 100;
		This.Radius = 10.0;
	}

	void OnCollision(WorldObject* obj)
	{
		Prey* ptr;

		if (IsKindOf(obj,ptr)) {
			preyEaten++;
			ptr->Eaten();
		}

		FFNAnimat::OnCollision(obj);
	}

	float GetFitness()const { return preyEaten; }

	virtual string ToString()const
	{
		ostringstream out;
		out << "Meals had: " << preyEaten << " Current fitness: " << GetFitness();
		return out.str();
	}

private:
	int preyEaten;
};


class ChaseSimulation : public Simulation
{
	GeneticAlgorithm<Predator> gaPred;
	GeneticAlgorithm<Prey> gaPrey;
	Population<Predator> popPred;
	Population<Prey> popPrey;

public:
	ChaseSimulation():
	gaPred(0.7f, 0.1f), gaPrey(0.7f, 0.1f), 
	popPred(30,gaPred), popPrey(30,gaPrey)
	{
		gaPred.SetSelection(GA_RANK);
		gaPred.SetParameter(GA_RANK_SPRESSURE, 2.0);
		
		gaPrey.SetSelection(GA_RANK);
		gaPrey.SetParameter(GA_RANK_SPRESSURE, 2.0);

		// Although the population size for both Predator and Prey is
		// 30, it would be chaos if we were trying to assess 60 individuals
		// at once (although it still works after a fashion and takes less
		// time - remove these two lines to see that happening). Instead
		// 5 Predators are assessed against 10 Prey. There are 30 assessments,
		// and each time the Simulation class makes sure that the next 5
		// Prey and the next 10 Predators are picked.
		popPred.SetTeamSize(5);
		popPrey.SetTeamSize(10);
		SetAssessments(30);

		Add("Predators", popPred);
		Add("Prey", popPrey);
	}
};

