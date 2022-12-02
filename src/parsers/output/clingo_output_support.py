import csv

from tabulate import tabulate


def parse_input(raw):
    """
    Separate each answer and returns a dict with: a list with all classes scheduled
    (this list contains, for each answer, its predicates and its optimization number) and clingo execution time.
    If no answer is found, returns False
    """

    parsed = raw.split("Answer: ")
    parsed.pop(0)

    # no answers
    if not parsed:
        return {"Answers":False,"Time":""}

    exec_time = ""
    answers_list = list()
    answers_struct = {"Answers":answers_list}

    for p in parsed:
        answer = p.split("\n")
        if len(answer)-3 >= 0 and "Time" in answer[len(answer)-3]:
            exec_time = answer[len(answer)-3]
        opt = ""
        if answer[2][0:14] == "Optimization: ":
            opt = answer[2][14:]
        else:
            opt = "Not optimized"
        answers_struct["Answers"].append({"Answer":answer[1],"Optimization":opt})

    answers_struct["Time"] = exec_time
    return answers_struct


def make_sched(answer):
    """
    Given a answer (list of classes in the schedule)
    Returns a dictionary where the keys are a tuple (day,time) and
    the value is a list of tuples (course, group, professor) of classes that
    are scheduled in that time
    """

    # classes schedule
    sched = dict()
    classes = answer.split("class(")
    for clas in classes[1:]:
        end = clas.find(")")
        clas = clas[:end]
        c = clas.split(",")
        course = c[0]
        group = c[1]
        professor = c[2]
        day = int(c[3][0])
        time = int(c[3][1:])

        # group classes by period
        if (day, time) not in sched:
            sched[day, time] = list()
        sched[day, time].append((course, group, professor))

    return sched


def time_stamp(p):
    """
    Converts time code to a real time for printing
    """
    if p == 11:
        return "08:00-09:40"
    if p == 12:
        return "10:00-11:40"
    if p == 21:
        return "14:00-15:40"
    if p == 22:
        return "16:00-17:40"


def make_table(sched):
    """
    Given a dictionary of the schedule,
    Returns a tuple head, body.
    Head are the columns name and body is a list of the rows in the table
    The elements of the table are only the courses
    """
    head = ["Horário", "Segunda", "Terça", "Quarta", "Quinta", "Sexta"]
    body = list()
    for time in [11, 12, 21, 22]:  # time row
        row = list()
        row.append(time_stamp(time))
        for day in range(1, 6):
            if (day, time) not in sched:
                row.append("")
            else:
                classes = ""
                for c in sched[day, time]:
                    classes = classes + c[0] + "-" + c[1] + "\n"
                row.append(classes)
        body.append(row)
    return head, body


def make_csv_file(file_name, head, body):
    with open(file_name, mode="w") as output_file:
        output_writer = csv.writer(
            output_file, delimiter=",", quotechar='"', quoting=csv.QUOTE_MINIMAL
        )
        output_writer.writerow(head)
        for b in body:
            output_writer.writerow(b)


def print_table(name, opt, head, body):
    print(name)
    print("Optimization:",opt)
    print(tabulate(body, head, tablefmt="simple_grid"))
