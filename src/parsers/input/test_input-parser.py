from Clausule import *
from Timecode import *
from ParserTeacherSchedule import *
from ParserWorkload import *

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

    def test_getPeriodCode_array(self):
        ans = []
        for i in ["9:20","12:00","21:00","18:00", "21:20", "13:00", "7:30"]:
            ans.append(self.t.getPeriodCode(i))
        assert ans == [[11,12],[],[],[], [], [21], [11]]

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
        for i in ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sab", "Dom"]:
            ans.append(self.t.getDayCode(i))
        assert ans == [100,200,300,400,500, 0, 0]
    
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
        self.p = ParserTeacherSchedule("test_input_file/test_schedule.csv")
    
    def test_available(self):
        ans = self.p.parse()
        correct = {
            'available':[
                ["pmiranda",121,0],
                ["pmiranda",122,0],
                ["pmiranda",211,0],
                ["pmiranda",212,0],
                ["pmiranda",221,0],
                ["pmiranda",222,0],
                ["pmiranda",311,1],
                ["pmiranda",312,1],
                ["pmiranda",321,1],
                ["pmiranda",322,1],
                ["pmiranda",411,1],
                ["pmiranda",412,1],
                ["pmiranda",422,0],
                ["pmiranda",511,1],
                ["pmiranda",512,1],
                ["pmiranda",521,1],
                ["pmiranda",522,1],
                ["egbirgin",111,0],
                ["egbirgin",112,0],
                ["egbirgin",211,1],
                ["egbirgin",212,1],
                ["egbirgin",311,0],
                ["egbirgin",312,0],
                ["egbirgin",411,1],
                ["egbirgin",412,1],
                ["rt",112,1],
                ["rt",121,1],
                ["rt",122,1],
                ["rt",212,1],
                ["rt",221,1],
                ["rt",222,1],
                ["rt",312,1],
                ["rt",321,1],
                ["rt",322,1],
                ["rt",412,1],
                ["rt",421,1],
                ["rt",422,1]
            ]
        }
        assert ans == correct
    
    def test_assemble(self):
        ans = self.p.assemble({'test': [["test1", 1, 0], ["test2", 2, 1]]})
        correct = {'test': "test(test1,1,0).\ntest(test2,2,1)."}
        assert ans == correct
        
    def test_noAnswer(self):
        no = self.p.noAnswer("test_input_file/test_workload.csv", 7)
        ans = set(tuple(i) for i in no['available'])
        correct = [
                ["leliane",111,0],
                ["leliane",112,0],
                ["leliane",121,0],
                ["leliane",122,0],
                ["leliane",211,0],
                ["leliane",212,0],
                ["leliane",221,0],
                ["leliane",222,0],
                ["leliane",311,0],
                ["leliane",312,0],
                ["leliane",321,0],
                ["leliane",322,0],
                ["leliane",411,0],
                ["leliane",412,0],
                ["leliane",421,0],
                ["leliane",422,0],
                ["leliane",511,0],
                ["leliane",512,0],
                ["leliane",521,0],
                ["leliane",522,0],
                ["hirata",111,0],
                ["hirata",112,0],
                ["hirata",121,0],
                ["hirata",122,0],
                ["hirata",211,0],
                ["hirata",212,0],
                ["hirata",221,0],
                ["hirata",222,0],
                ["hirata",311,0],
                ["hirata",312,0],
                ["hirata",321,0],
                ["hirata",322,0],
                ["hirata",411,0],
                ["hirata",412,0],
                ["hirata",421,0],
                ["hirata",422,0],
                ["hirata",511,0],
                ["hirata",512,0],
                ["hirata",521,0],
                ["hirata",522,0],
                ["nina",111,0],
                ["nina",112,0],
                ["nina",121,0],
                ["nina",122,0],
                ["nina",211,0],
                ["nina",212,0],
                ["nina",221,0],
                ["nina",222,0],
                ["nina",311,0],
                ["nina",312,0],
                ["nina",321,0],
                ["nina",322,0],
                ["nina",411,0],
                ["nina",412,0],
                ["nina",421,0],
                ["nina",422,0],
                ["nina",511,0],
                ["nina",512,0],
                ["nina",521,0],
                ["nina",522,0],
                ["fujita",111,0],
                ["fujita",112,0],
                ["fujita",121,0],
                ["fujita",122,0],
                ["fujita",211,0],
                ["fujita",212,0],
                ["fujita",221,0],
                ["fujita",222,0],
                ["fujita",311,0],
                ["fujita",312,0],
                ["fujita",321,0],
                ["fujita",322,0],
                ["fujita",411,0],
                ["fujita",412,0],
                ["fujita",421,0],
                ["fujita",422,0],
                ["fujita",511,0],
                ["fujita",512,0],
                ["fujita",521,0],
                ["fujita",522,0],
                ["yoshiko",111,0],
                ["yoshiko",112,0],
                ["yoshiko",121,0],
                ["yoshiko",122,0],
                ["yoshiko",211,0],
                ["yoshiko",212,0],
                ["yoshiko",221,0],
                ["yoshiko",222,0],
                ["yoshiko",311,0],
                ["yoshiko",312,0],
                ["yoshiko",321,0],
                ["yoshiko",322,0],
                ["yoshiko",411,0],
                ["yoshiko",412,0],
                ["yoshiko",421,0],
                ["yoshiko",422,0],
                ["yoshiko",511,0],
                ["yoshiko",512,0],
                ["yoshiko",521,0],
                ["yoshiko",522,0],
                ["ddm",111,0],
                ["ddm",112,0],
                ["ddm",121,0],
                ["ddm",122,0],
                ["ddm",211,0],
                ["ddm",212,0],
                ["ddm",221,0],
                ["ddm",222,0],
                ["ddm",311,0],
                ["ddm",312,0],
                ["ddm",321,0],
                ["ddm",322,0],
                ["ddm",411,0],
                ["ddm",412,0],
                ["ddm",421,0],
                ["ddm",422,0],
                ["ddm",511,0],
                ["ddm",512,0],
                ["ddm",521,0],
                ["ddm",522,0],
                ["mksilva",111,0],
                ["mksilva",112,0],
                ["mksilva",121,0],
                ["mksilva",122,0],
                ["mksilva",211,0],
                ["mksilva",212,0],
                ["mksilva",221,0],
                ["mksilva",222,0],
                ["mksilva",311,0],
                ["mksilva",312,0],
                ["mksilva",321,0],
                ["mksilva",322,0],
                ["mksilva",411,0],
                ["mksilva",412,0],
                ["mksilva",421,0],
                ["mksilva",422,0],
                ["mksilva",511,0],
                ["mksilva",512,0],
                ["mksilva",521,0],
                ["mksilva",522,0]]
        correct = set(tuple(i) for i in correct)
        assert ans == correct

class TestWorkload:
    def setup_class(self):
        self.p = ParserWorkload("test_input_file/test_workload.csv")
    
    def test_class(self):
        ans = self.p.parse()[':- not class']
        correct = [
            ["MAC0329","BCC","nina",211],
            ["MAC0329","BCC","nina",412],
            ["MAC0101","BCC","leliane",221],
            ["MAC0321","Poli EC - PCS 2","ddm",511],
            ["MAC0321","Poli EC - PCS 2","ddm",512],
            ["MAC0113","FEA 1","pmiranda",311],
            ["MAC0113","FEA 1","pmiranda",511],
            ["MAC0113","FEA 1","pmiranda",512],
            ["MAC2166","Poli Web C","fujita",522]
        ]
        assert ans == correct

    def test_course(self):
        ans = self.p.parse()['course']
        correct = [
            ["MAC0329","BCC","nina"],
            ["MAC0101","BCC","leliane"],
            ["MAC0321","Poli EC - PCS 2","ddm"],
            ["MAC0113","FEA 1","pmiranda"],
            ["MAC2166","Poli Web C","fujita"],
            ["MAC0320","BCC","yoshiko"],
            ["MAC5770","BCC-pos","yoshiko"],
            ["MAC0327","BCC","mksilva"]
        ]
        assert ans == correct
    
    def test_assemble(self):
        ans = self.p.assemble({'test': [["tes  t1", 1, 0], ["1-a", 2, 1]]})
        correct = {'test': 'test(test1,1,0).\ntest("1_a",2,1).'}
        assert ans == correct
