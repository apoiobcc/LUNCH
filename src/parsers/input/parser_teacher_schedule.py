"""
Clingo Input Teachers Schedule Parser (Semestral)
----------------------
This collection of functions can parse a given csv file containing the restrictions and preferences 
times for each teacher in the semester.

Columns expected in the csv file:
Timestamp|teacher_username@email|(2-6)Preferences[Day of the Week]|(7-11)Restrictions[Day of the Week]

Clausules generated:
- available/2(teacher_id, period_code)
- preferable/2(teacher_id, period_code)
"""

import csv
from Clausule import Clausule
from Timecode import Timecode

def getTeacherName(email):
    return email.split('@')[0]

def getDayHeader(header):
    return header.split("[")[1][:-1]

def getNoAnswerTeachers(teacher_sched_file, workload_file):
    """
        Return the names of the teachers who are not in the schedule file
        Before using this function, set the global variables
            teacher_sched_file : file with the teachers schedule
            TINDEX_SCHED : column containing teachers email in teachers schedule file
            workload_file : file containing the workload for the semester
            TINDEX_WORKLOAD : : column containing teachers username in teachers schedule file
    """
    with open(teacher_sched_file) as t_csv:
            teachers1 = set()
            csv_reader = csv.reader(t_csv, delimiter=',')
            # get header
            for row in csv_reader:
                headers = row
                break
            for row in csv_reader:
                teacher = row[1].split('@')[0]
                teachers1.update((teacher,))

    with open(workload_file) as w_csv:
            teachers2 = set()
            csv_reader = csv.reader(w_csv, delimiter=',')
            # get header
            for row in csv_reader:
                headers = row
                break
            for row in csv_reader:
                teacher = row[2]
                teachers2.update((teacher,))
    return list(teachers2.difference(teachers1))

def getTeacherSched(file_name):
    """
    This function receives a csv file containing the teachers restrictions and preferable times
    And returns a list of dictionaries
    The dictionaries keys are: teacher, preference, restriction, available.
    The values for preference, restriction, available are another list of dictionaries
    that contains the time codes for each category
    """
    with open(file_name) as csv_file:
        infos = list()
        t = Timecode()
        csv_reader = csv.reader(csv_file, delimiter=",")
        # get header
        for row in csv_reader:
            headers = row
            break
        for row in csv_reader:
            atom = dict()
            atom["teacher"] = getTeacherName(row[1])
            atom["preferable"] = dict()
            atom["restriction"] = dict()
            # get teachers preferences
            for i in range(2, 7):
                day = t.getDayCode(getDayHeader(headers[i]))
                periods = list()
                for p in row[i].split(";"):
                    if t.getPeriodCode(p[:5]) == []:
                        continue
                    periods.append(t.getPeriodCode(p[:5])[0])
                atom["preferable"][day] = periods
            # get teachers restrictions
            for i in range(7, 12):
                day = t.getDayCode(getDayHeader(headers[i]))
                periods = list()
                for p in row[i].split(";"):
                    if t.getPeriodCode(p[:5]) == []:
                        continue
                    periods.append(t.getPeriodCode(p[:5])[0])
                atom["restriction"][day] = periods
            # get teachers availability
            atom["available"] = availablePeriod(atom["restriction"])
            infos.append(atom)
    return infos


def availablePeriod(restriction):
    """
    Given the restriction times dictionary
    Returns a dictonary with the times not restricted
    """
    available = dict()
    t = Timecode()
    for key in restriction.keys():
        periods = list()
        for p in t.getAllPeriodCodes():
            periods.append(p)
        for p in restriction[key]:
            periods.remove(p)
        available[key] = periods
    return available


def assembleDayPredicate(predicate, teacher, periods):
    """
    Assembles asp clausules given the predicate, first argument(teacher) and
    a list of the second arguments
    """
    assembled = ""
    for day in periods.keys():
        for hour in periods[day]:
            # get time code with day and period
            p = day + hour
            assembled = assembled + Clausule(predicate, [teacher, p]).assembleClausule() + '\n'
    return assembled

def getAvailablePreferable(info, noAnswer):
    """
        Receives a list of dictionaries containing the availability and preference of teachers
        and a list of teachers who have not preferences or restrictions
        Returns the ASP clasules of all teachers' availability and preferences in this order 
    """
    t = Timecode()
    available = ""
    preferable = ""
    for i in info:
        available = available + assembleDayPredicate("available", i['teacher'], i['available'])
        preferable = preferable + assembleDayPredicate("preferable", i['teacher'], i['preferable'])
    for teacher in noAnswer:
        for d in t.getAllDayCodes():
            for p in t.getAllPeriodCodes():
                available = available + Clausule("available", [teacher, d+p]).assembleClausule() + '\n'
    return available[:-1], preferable[:-1]
