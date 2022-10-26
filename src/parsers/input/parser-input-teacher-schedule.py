import sys
import csv

ALLPERIODS = [11, 12, 21, 22]

def transformDay(d):
        if (d == 'Segunda'): return 100
        if (d == 'Terça'): return 200
        if (d == 'Quarta'): return 300
        if (d == 'Quinta'): return 400
        if (d == 'Sexta'): return 500
        return 0

def transformPeriod(p):
        if (p.startswith("08")): return 11
        if (p.startswith("10")): return 12
        if (p.startswith("14")): return 21
        if (p.startswith("16")): return 22
        return 0

def getProfessorName(email):
        return email.split('@')[0].lower().replace('.', '')

def getDayHeader(header):
        return header.split('[')[1][:-1]

def getProfessorSched(file_name):
        with open(file_name) as csv_file:
                infos = list()
                csv_reader = csv.reader(csv_file, delimiter=',')
                for row in csv_reader:
                        headers = row
                        break
                for row in csv_reader:
                        atom = dict()
                        atom['professor'] = getProfessorName(row[1])
                        atom['preference'] = dict()
                        atom['restriction'] = dict()
                        for i in range(2,7):
                                day = transformDay(getDayHeader(headers[i]))
                                periods = list()
                                for p in row[i].split(';'):
                                        if (transformPeriod(p) == 0): continue
                                        periods.append(transformPeriod(p))
                                atom['preference'][day] = periods
                        for i in range(7,12):
                                day = transformDay(getDayHeader(headers[i]))
                                periods = list()
                                for p in row[i].split(';'):
                                        if (transformPeriod(p) == 0): continue
                                        periods.append(transformPeriod(p))
                                atom['restriction'][day] = periods
                        atom['available'] = availablePeriod(atom['restriction'])
                        print(atom)
                        infos.append(atom)
        return infos

def availablePeriod(restriction):
        available = dict()
        for key in restriction.keys():
                periods = list()
                for p in ALLPERIODS: periods.append(p)
                for p in restriction[key]: periods.remove(p)
                available[key] = periods
        return available
        
def printDayPredicate(predicate, professor, periods):
        for day in periods.keys():
                for hour in periods[day]:
                        p = day + hour
                        print(f'{predicate}({professor},{p}).')

file_name = sys.argv[1]
info = getProfessorSched(file_name)
for i in info:
        printDayPredicate("available", i['professor'], i['available'])
        # printDayPredicate("preference", i['professor'], i['preference'])
