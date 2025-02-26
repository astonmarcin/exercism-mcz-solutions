//Package weather - a package to calculate weather.
package weather

//CurrentCondition string contains current weather condition.
var CurrentCondition string
//CurrentLocation string contains name of current location.
var CurrentLocation string

//Forecast function return a clear information with weather forcast, for specified location.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
