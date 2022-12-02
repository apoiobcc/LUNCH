from Clausule import *
from Timecode import *
from parser_teacher_schedule import *
from parser_workload import *

class TestClausule:
    def test_assemble(self):
        cl = Clausule("test", ["1number", "123", "under-line","do.t","sp ace", "pl+us"])
        correct = 'test("1number",123,under_line,dot,space,plus).'
        assert cl.assembleClausule() == correct
    def test_verify(self):
        correct = Clausule("test", ["1number", "123", "under_line","dot","space", "pl+us"])
        verify = Clausule("test", ["1number", 123, "under-line","do.t.","spa ce","plus"])
        assert correct.assembleClausule() == verify.assembleClausule()

class TestTimecode:
    def setup_class(self):
        self.t = Timecode()

    def test_getPeriodCode_unit(self):
        ans = []
        for i in ["9:00","12:00","21:00","18:00"]:
            ans.append(self.t.getPeriodCode(i))
        assert ans == [[11,12],[12,21],[],[22]]

    def test_getPeriodCode_unit(self):
        ans = []
        for i in ["8:00","14:00","16:00", "10:00"]:
            ans.append(self.t.getPeriodCode(i))
        assert ans == [[11],[21],[22],[12]]

    def test_getPeriodStamp(self):
        ans = []
        for i in [22,11,12,21]:
            ans.append(self.t.getPeriodStamp(i))
        assert ans == ["16:00","08:00", "10:00", "14:00"]

    def test_getDayCode_byName(self):
        ans = []
        for i in ["2a", "3a", "4a", "5a", "6a"]:
            ans.append(self.t.getDayCode(i))
        assert ans == [100,200,300,400,500]

    def test_getDayCode_byName(self):
        ans = []
        for i in ["Segunda", "Terça", "Quarta", "Quinta", "Sexta"]:
            ans.append(self.t.getDayCode(i))
        assert ans == [100,200,300,400,500]
    
    def test_getDayName(self):
        s = self.t.getDayName(100)
        t = self.t.getDayName(200)
        q = self.t.getDayName(300)
        k = self.t.getDayName(400)
        x = self.t.getDayName(500)
        assert [s,t,q,k,x] == ["Segunda", "Terça", "Quarta", "Quinta", "Sexta"]
    
    def test_getAllPeriodCodes(self):
        all = self.t.getAllPeriodCodes()
        assert all == [11,12,21,22]

    def test_getAllDayCodes(self):
        all = self.t.getAllDayCodes()
        assert all == [100, 200, 300, 400, 500]

class TestSchedule:
    def setup_class(self):
        self.file_name = "test_input_file/test_schedule.csv"


class TestWorkload:
    def setup_class(self):
        self.file_name = "test_input_file/test_workload.csv"