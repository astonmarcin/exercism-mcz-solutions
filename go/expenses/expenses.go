package expenses

import "fmt"

type Record struct {
	Day      int
	Amount   float64
	Category string
}

type DaysPeriod struct {
	From int
	To   int
}

func Filter(in []Record, predicate func(Record) bool) []Record {
	var output []Record
	for _, record := range in {
		if predicate(record) {
			output = append(output, record)
		}
	}
	return output
}

func ByDaysPeriod(p DaysPeriod) func(Record) bool {
	return func(r Record) bool {
		return r.Day >= p.From && r.Day <= p.To
	}
}

func ByCategory(c string) func(Record) bool {
	return func(r Record) bool {
		return r.Category == c
	}
}

func TotalByPeriod(in []Record, p DaysPeriod) float64 {
	var output float64
	for _, record := range Filter(in, ByDaysPeriod(p)) {
		output += float64(record.Amount)
	}
	return output
}

func CategoryExpenses(in []Record, p DaysPeriod, c string) (float64, error) {
	records_by_category := Filter(in, ByCategory(c))
	if len(records_by_category) == 0 {
		return 0.0, fmt.Errorf("unknown category %v", c)
	}
	return TotalByPeriod(records_by_category, p), nil
}
