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

"""
This list represents all periods codes when a class can be given
"""
ALLPERIODS = [11, 12, 21, 22]
ALLDAYS = [100, 200, 300, 400, 500]


def transformDay(d):
    """
    Function that transforms a day in its code
    """
    if d == "Segunda":
        return 100
    if d == "Terça":
        return 200
    if d == "Quarta":
        return 300
    if d == "Quinta":
        return 400
    if d == "Sexta":
        return 500
    return 0


def transformPeriod(p):
    """
    Function that transforms a period in its code
    """
    if p.startswith("08"):
        return 11
    if p.startswith("10"):
        return 12
    if p.startswith("14"):
        return 21
    if p.startswith("16"):
        return 22
    return 0


def getTeacherName(email):
    return email.split('@')[0]

def getDayHeader(header):
    return header.split("[")[1][:-1]


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
                day = transformDay(getDayHeader(headers[i]))
                periods = list()
                for p in row[i].split(";"):
                    if transformPeriod(p) == 0:
                        continue
                    periods.append(transformPeriod(p))
                atom["preferable"][day] = periods
            # get teachers restrictions
            for i in range(7, 12):
                day = transformDay(getDayHeader(headers[i]))
                periods = list()
                for p in row[i].split(";"):
                    if transformPeriod(p) == 0:
                        continue
                    periods.append(transformPeriod(p))
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
    for key in restriction.keys():
        periods = list()
        for p in ALLPERIODS:
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
    available = ""
    preferable = ""
    for i in info:
        available = available + assembleDayPredicate("available", i['teacher'], i['available'])
        preferable = preferable + assembleDayPredicate("preferable", i['teacher'], i['preferable'])
    for t in noAnswer:
        for d in ALLDAYS:
            for p in ALLPERIODS:
                available = available + Clausule("available", [t, d+p]).assembleClausule() + '\n'
    return available[:-1], preferable[:-1]
