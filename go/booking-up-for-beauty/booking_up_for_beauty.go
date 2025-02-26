package booking

import "time"

// Schedule returns a time.Time from a string containing a date.
func Schedule(date string) time.Time {
	layout := "1/2/2006 15:04:05"
	timedate, _ := time.Parse(layout, date)
	return timedate
}

// HasPassed returns whether a date has passed.
func HasPassed(date string) bool {
	layout := "January 2, 2006 15:04:05"
	timedate, _ := time.Parse(layout, date)
	return timedate.Before(time.Now())
}

// IsAfternoonAppointment returns whether a time is in the afternoon.
func IsAfternoonAppointment(date string) bool {
	layout := "Monday, January 2, 2006 15:04:05"
	timedate, _ := time.Parse(layout, date)
	if timedate.Hour() >= 12 && timedate.Hour() < 18 {
		return true
	} else {
		return false
	}
}

// Description returns a formatted string of the appointment time.
func Description(date string) string {
	timedate := Schedule(date)
	layout := "Monday, January 2, 2006, at 15:04."
	return "You have an appointment on " + timedate.Format(layout)
}

// AnniversaryDate returns a Time with this year's anniversary.
func AnniversaryDate() time.Time {
	return time.Date(time.Now().Year(), 9, 15, 0, 0, 0, 0, time.UTC)
}
