class School:
    def __init__(self):
        self.students = {}

    def add_student(self, name, grade):
        id = len(self.students) + 1
        self.students[id] = {
            "name": name,
            "grade": grade,
            "added": True if name not in [student["name"] for student in self.students.values()] else False
        }

    def roster(self):
        """return added students sorted by grades and names
        """
        return [
            student["name"] 
            for student in sorted(
                sorted(
                    self.students.values(),
                    key=lambda x: x["name"]
                ), 
                key=lambda x: x["grade"]
            ) 
            if student["added"]
        ]

    def grade(self, grade_number):
        """returns valid students in particular grade, sorted by names
        """
        return [
            student["name"] 
            for student in sorted(
                self.students.values(), 
                key=lambda x: x["name"]
            )
            if (student["added"] and student["grade"] == grade_number)
        ]

    def added(self):
        """printing whether student was added or not
        """
        return [student["added"] for student in self.students.values()]
