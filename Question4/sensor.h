/**
 * \file sensor.h
 * \author David Gordon
 * \addtogroup sensors
 * Include this file for all sensor functionality. sensorbase.h and
 * sensorfunctors.h are included by this file. sensor.h contains some useful
 * functions which set up the most common types of sensor.
 */

#ifndef _SENSOR_H
#define _SENSOR_H

#include "sensorbase.h"
#include "sensorfunctors.h"

namespace BEAST {

/**
 * \addtogroup sensors Sensors and Sensor Functions
 * Sensors are set up to provide maximum flexibility, so if you need a new 
 * sensor which isn't that different to existing ones, you will need to write
 * a minimum of code to put that sensor together.
 * @{
 */

/**
 * Creates a segment-shaped sensor with the specified scope, range and
 * orientation which detects the distance of objects of the specified
 * templated type.
 * \param T The type of objects to detect. The MatchKindOf functor is used by
 * default.
 * \param scope The angle within which to detect objects. An angle of 0 may be
 * specified to create a 'laser' type sensor, or an angle of TWOPI will create
 * an all-round distance sensor.
 */
template <class T>
Sensor* ProximitySensor(double scope, double range, double orientation)
{
	Sensor* s = new BeamSensor(scope, range, Vector2D(0.0, 0.0), orientation);
	s->SetMatchingFunction(new MatchKindOf<T>);
	s->SetEvaluationFunction(new EvalNearest(s, range));
	s->SetScalingFunction(new ScaleLinear(0.0, range, 1.0, 0.0));
	
	return s;
}

template <class T>
Sensor* NearestAngleSensor()
{
	Sensor* s = new Sensor(Vector2D(0.0, 0.0), 0.0);
	s->SetMatchingFunction(new MatchKindOf<T>);
	s->SetEvaluationFunction(new EvalNearestAngle(s, 1000.0));
	s->SetScalingFunction(new ScaleLinear(-PI, PI, -1.0, 1.0));
	
	return s;
}

template <class T>
Sensor* NearestXSensor()
{
	Sensor* s = new Sensor(Vector2D(0.0, 0.0), 0.0);
	s->SetMatchingFunction(new MatchKindOf<T>);
	s->SetEvaluationFunction(new EvalNearestXDist(s, 1000.0));
	s->SetScalingFunction(new ScaleLinear(-500.0, 500.0, -1.0, 1.0));
	
	return s;
}

template <class T>
Sensor* NearestYSensor()
{
	Sensor* s = new Sensor(Vector2D(0.0, 0.0), 0.0);
	s->SetMatchingFunction(new MatchKindOf<T>);
	s->SetEvaluationFunction(new EvalNearestYDist(s, 1000.0));
	s->SetScalingFunction(new ScaleLinear(-500.0, 500.0, -1.0, 1.0));
	
	return s;
}

template <class T>
Sensor* DensitySensor(double scope, double range, double orientation)
{
	using namespace std; // for bind1st
		
	Sensor* s = new BeamSensor(scope, range, Vector2D(0.0, 0.0), orientation);
	dynamic_cast<BeamSensor*>(s)->SetDrawFixed(true);
	s->SetMatchingFunction(new MatchKindOf<T>);
	s->SetEvaluationFunction(new EvalCount(1));
	s->SetScalingFunction(new ScaleCompose(ScaleAdapt(bind1st(divides<double>(), 1.0)),
										   new ScaleLinear(0.0, 1.0, 1.0, 0.0)));

	return s;
}

template <class T>
Sensor* CollisionSensor()
{
	Sensor* s = new TouchSensor();
	s->SetMatchingFunction(new MatchKindOf<T>);
	s->SetEvaluationFunction(new EvalCount());
	s->SetScalingFunction(new ScaleThreshold(1.0));

	return s;
}

/**
 * @}
 */

} // namespace BEAST


#endif
