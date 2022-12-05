"""
Clingo Input Teachers Schedule Parser (Semestral)
----------------------
This cobject can parse a given csv file containing the restrictions and preferences 
times for each teacher in the semester.

Columns expected in the csv file:
Timestamp|teacher_username@email|(2-6)Preferences[Day of the Week]|(7-11)Restrictions[Day of the Week]

Clausule generated:
- available/3(teacher_id, period_code, prefer_arg)
"""

import csv
from InputParser import InputParser

class ParserTeacherSchedule(InputParser):
    def getDayHeader(self, header):
        return header.split("[")[1][:-1]

    def noAnswer(self, file_name, teacher_column):
        """
            This fuction receives a csv file and the column containing names of teachers
            and return a dictionary of teachers that are in the csv file but not in the self.csv_file 
            file and all the available periods.
        """
        with open(self.csv_file) as t_csv:
                teachers1 = set()
                csv_reader = csv.reader(t_csv, delimiter=',')
                # get header
                for row in csv_reader:
                    headers = row
                    break
                for row in csv_reader:
                    teacher = self.getUsername(row[1])
                    teachers1.update((teacher,))

        with open(file_name) as w_csv:
                teachers2 = set()
                csv_reader = csv.reader(w_csv, delimiter=',')
                # get header
                for row in csv_reader:
                    headers = row
                    break
                for row in csv_reader:
                    teacher = self.getUsername(row[teacher_column])
                    teachers2.update((teacher,))

        args = []
        for teacher in teachers2.difference(teachers1):
            for d in self.timecoder.getAllDayCodes():
                for p in self.timecoder.getAllPeriodCodes():
                    args.append([teacher, d+p, 0])
        info = dict()
        info['available'] = args
        return info

    def parse(self):
        with open(self.csv_file) as csv_file:
            info = dict()
            csv_reader = csv.reader(csv_file, delimiter=",")
            # get header
            for row in csv_reader:
                headers = row
                break
            preferable = dict()
            available = dict()
            for row in csv_reader:
                teacher = self.getUsername(row[1])
                preferable[teacher] = []
                # get teachers preferences
                for i in range(2, 7):
                    day = self.timecoder.getDayCode(self.getDayHeader(headers[i]))
                    periods = list()
                    for p in row[i].split(";"):
                        t = p.split('-')[0]
                        if self.timecoder.getPeriodCode(t) == []:
                            continue
                        preferable[teacher].append(self.timecoder.getPeriodCode(t)[0] + day)
                # get teachers restrictions
                restriction = dict()
                for i in range(7, 12):
                    day = self.timecoder.getDayCode(self.getDayHeader(headers[i]))
                    periods = list()
                    for p in row[i].split(";"):
                        t = p.split('-')[0]
                        if self.timecoder.getPeriodCode(t) == []:
                            continue
                        periods.append(self.timecoder.getPeriodCode(t)[0])
                    restriction[day] = periods
                # get teachers availability
                available[teacher] = self.availablePeriods(restriction)
            info['available'] = self.uniteAvailPreferabel(available, preferable)
            return info


    def availablePeriods(self,restriction):
        """
        Given the restriction times dictionary of a teacher
        Returns a list with the times not restricted
        """
        available = []
        for key in restriction.keys():
            periods = list()
            for p in self.timecoder.getAllPeriodCodes():
                periods.append(p)
            for p in restriction[key]:
                periods.remove(p)
            for p in periods:
                available.append(p+key)
        return available

    def uniteAvailPreferabel(self,available, preferable):
        ans = list()
        for teacher in available.keys():
            if teacher not in preferable.keys():
                for period in available[teacher]:
                    ans.append([teacher, period, 0])
            else:
                for period in available[teacher]:
                    prefer_arg = 1 if period in preferable[teacher] else 0
                    ans.append([teacher, period, prefer_arg])
        return ans