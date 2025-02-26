class Garden:
    plants_map = {
        "G": "Grass",
        "C": "Clover",
        "R": "Radishes",
        "V": "Violets",
    }

    def __init__(self, diagram, students = ["Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"]):
        students = sorted(students)
        self.students_plants = {student: [] for student in students}
        for line in diagram.split("\n"):
            for idx in range(0, len(line) // 2):
                self.students_plants[students[idx]].append(Garden.plants_map[line[2*idx]])
                self.students_plants[students[idx]].append(Garden.plants_map[line[2*idx+1]])

    def plants(self, student):
        return self.students_plants[student]
