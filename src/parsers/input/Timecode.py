"""
Class Timecode
------------------
Deals with the transformation between time and its code
"""
class Timecode:
    PTIMESTAMP = ["08:00", "10:00", "14:00", "16:00"]
    PCODES = [11,12,21,22]

    DAYNAME = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta"]
    DCODES = [100, 200, 300, 400, 500]

    PMAX = "18:00"

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
        for i in range(len(self.PTIMESTAMP)-1):
            if self.PTIMESTAMP[i] < period and period < self.PTIMESTAMP[i+1]:
                return [self.PCODES[i], self.PCODES[i+1]]
        if period < self.PTIMESTAMP[0]:
            return [self.PCODES[0]]
        if period > self.PTIMESTAMP[-1] and period < self.PMAX:
            return [self.PCODES[-1]]
        # if it is not in a coded period, this class will not interfer in the scheduler
        return []

    def getPeriodStamp(self, period):
        return self.PTIMESTAMP[self.PCODES.index(int(period))]

    def getDayCode(self, day):
        if day[0].isdigit():
            return (100 * (int(day[0]) - 1))
        return self.DCODES[self.DAYNAME.index(day)]
    
    def getDayName(self, day):
        return self.DAYNAME[self.DCODES.index(int(day))]
    
    def getAllPeriodCodes(self):
        return self.PCODES

    def getAllDayCodes(self):
        return self.DCODES