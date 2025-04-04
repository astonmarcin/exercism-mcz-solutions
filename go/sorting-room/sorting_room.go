package sorting

import (
	"strconv"
)

// DescribeNumber should return a string describing the number.
func DescribeNumber(f float64) string {
	return "This is the number " + strconv.FormatFloat(f, 'f', 1, 64)
}

type NumberBox interface {
	Number() int
}

// DescribeNumberBox should return a string describing the NumberBox.
func DescribeNumberBox(nb NumberBox) string {
	i := float64(nb.Number())
	return "This is a box containing the number " + strconv.FormatFloat(i, 'f', 1, 64)
}

type FancyNumber struct {
	n string
}

func (i FancyNumber) Value() string {
	return i.n
}

type FancyNumberBox interface {
	Value() string
}

// ExtractFancyNumber should return the integer value for a FancyNumber
// and 0 if any other FancyNumberBox is supplied.
func ExtractFancyNumber(fnb FancyNumberBox) int {
	switch fnb.(type) {
	case FancyNumber:
		i, _ := strconv.Atoi(fnb.Value())
		return i
	default:
		return 0
	}
}

// DescribeFancyNumberBox should return a string describing the FancyNumberBox.
func DescribeFancyNumberBox(fnb FancyNumberBox) string {
	return "This is a fancy box containing the number " + strconv.FormatFloat(float64(ExtractFancyNumber(fnb)), 'f', 1, 64)
}

// DescribeAnything should return a string describing whatever it contains.
func DescribeAnything(i interface{}) string {
	switch i := i.(type) {
	case float64:
		return DescribeNumber(i)
	case int:
		return DescribeNumber(float64(i))
	case NumberBox:
		return DescribeNumberBox(i)
	case FancyNumberBox:
		return DescribeFancyNumberBox(i)
	default:
		return "Return to sender"
	}
}
