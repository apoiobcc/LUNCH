"""
Class Timecode
------------------
Deals with the transformation between time and its code
"""
class Timecode:

    def __init__(self):
        self.PTIMESTAMP = ["08:00", "10:00", "14:00", "16:00"]
        self.PCODES = [11,12,21,22]

        self.DAYNAME = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta"]
        self.DCODES = [100, 200, 300, 400, 500]

        self.PMAX = "18:00"

        self.CLASSTIME = 100
        self.FIXEDCLASSSTART = []
        self.FIXEDCLASSEND = []
        for p in self.PTIMESTAMP:
            m = self.transformMinutes(p)
            self.FIXEDCLASSSTART.append(m)
            self.FIXEDCLASSEND.append(m+self.CLASSTIME)

    def transformMinutes(self,timeStamp):
        hour,minutes = timeStamp.split(':')
        return int(hour)*60 + int(minutes)

    def getPeriodCode(self, period):
        """
        Given a period stamp, returns a list of codes that represents a class in that time
        Ex 8:00 -> [11]
           9:00 -> [11,12]
        """
        if not period: return []
        if not period[:2].isdigit():
            period = '0' + period
        if period in self.PTIMESTAMP:
            return [self.PCODES[self.PTIMESTAMP.index(period)]]

        periods = []
        start = self.transformMinutes(period)
        end = start + self.CLASSTIME

        for i in range(len(self.FIXEDCLASSSTART)):
            if self.FIXEDCLASSSTART[i] < start and start < self.FIXEDCLASSEND[i]:
                periods.append(self.PCODES[i])
            if self.FIXEDCLASSSTART[i] < end and end < self.FIXEDCLASSEND[i]:
                periods.append(self.PCODES[i])
        return periods

    def getPeriodStamp(self, period):
        return self.PTIMESTAMP[self.PCODES.index(int(period))]

    def getDayCode(self, day):
        if not day: return 0
        if day[0].isdigit():
            return (100 * (int(day[0]) - 1))
        if day in self.DAYNAME:
            return self.DCODES[self.DAYNAME.index(day)]
        return 0
    
    def getDayName(self, day):
        return self.DAYNAME[self.DCODES.index(int(day))]
    
    def getAllPeriodCodes(self):
        return self.PCODES

    def getAllDayCodes(self):
        return self.DCODES