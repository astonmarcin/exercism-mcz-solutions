package jedlik

import "fmt"

func (car *Car) Drive() {
	new_battery := car.battery - car.batteryDrain
	if new_battery > 0 {
		car.battery = new_battery
		car.distance += car.speed
	}
}

// TODO: define the 'DisplayDistance() string' method
func (car *Car) DisplayDistance() string {
	return fmt.Sprintf("Driven %v meters", car.distance)
}

// TODO: define the 'DisplayBattery() string' method
func (car *Car) DisplayBattery() string {
	return fmt.Sprintf("Battery at %v%%", car.battery)
}

// TODO: define the 'CanFinish(trackDistance int) bool' method
func (car *Car) CanFinish(trackDistance int) bool {
	battery_consumption := int(float64(trackDistance) / float64(car.speed) * float64(car.batteryDrain))
	return battery_consumption <= car.battery
}
