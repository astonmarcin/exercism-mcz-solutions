package thefarm

import (
	"errors"
	"fmt"
)

func DivideFood(fc FodderCalculator, cows int) (float64, error) {
	fodder_amount, fodder_err := fc.FodderAmount(cows)
	fattening_factor, fattening_error := fc.FatteningFactor()
	if fodder_err != nil {
		return 0.0, fodder_err
	}
	if fattening_error != nil {
		return 0.0, fattening_error
	}
	return fodder_amount * fattening_factor / float64(cows), nil
}

func ValidateInputAndDivideFood(fc FodderCalculator, cows int) (float64, error) {
	if cows <= 0 {
		return 0, errors.New("invalid number of cows")
	}
	return DivideFood(fc, cows)
}

func ValidateNumberOfCows(cows int) error {
	err_str := ""
	if cows < 0 {
		err_str = "there are no negative cows"
	}
	if cows == 0 {
		err_str = "no cows don't need food"
	}
	if err_str != "" {
		return fmt.Errorf("%v cows are invalid: %v", cows, err_str)
	}
	return nil
}
