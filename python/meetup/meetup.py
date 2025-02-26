import datetime

days_matrix = {
    "Monday": 0,
    "Tuesday": 1,
    "Wednesday": 2,
    "Thursday": 3,
    "Friday": 4,
    "Saturday": 5,
    "Sunday": 6,
}

weeks_matrix = {
    "first": 0,
    "second": 1,
    "third": 2,
    "fourth": 3,
    "fifth": 4,
    "last": -1,
}

# subclassing the built-in ValueError to create MeetupDayException
class MeetupDayException(ValueError):
    """Exception raised when the Meetup weekday and count do not result in a valid date.

    message: explanation of the error.

    """
    def __init__(self, message):
        self.message = message


def meetup(year, month, week, day_of_week):
    ## init variables
    first_day = datetime.date(year, month, 1)
    day_int = days_matrix[day_of_week]
    week_int = weeks_matrix.get(week, False)
    
    ## collect all days of the week
    all_days_of_week = [
        first_day + datetime.timedelta(days=(day_int - first_day.weekday()) % 7 + i * 7)
        for i in range(0, 5)
    ]
    all_days_of_week.pop() if all_days_of_week[-1].month != month else all_days_of_week

    ## print teenth day
    if not week_int and week == "teenth":
        return [day for day in all_days_of_week if day.day >= 13 and day.day <= 19][0]
    ## handle fifth day exception
    if week_int == 4 and len(all_days_of_week) != 5:
        raise MeetupDayException("That day does not exist.")
    
    return all_days_of_week[week_int]