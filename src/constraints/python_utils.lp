% Misc python function for sc's files
#script(python)
import math
import clingo

def get_digit(n,d):
    ans = clingo.Number(n.number // 10 **(d.number-1) % 10) 
    return ans

def concat(*args):
    ans = ""
    for i in args:
        s = str(i)
        s = s.replace('"','').replace("'","")
        ans+= str(s)
    return ans

def calculate_weight_sc1(IDEAL1, IDEAL2):
    period1 = int(str(IDEAL1))
    period2 = int(str(IDEAL2))
    difference = abs(period1 - period2)
    if difference == 0:
        weight = 20
    else:
        weight = 10//difference
    return clingo.Number(weight)

def calculate_weight_sc2(IDEAL1, IDEAL2):
    period1 = int(str(IDEAL1))
    period2 = int(str(IDEAL2))
    difference = abs(period1 - period2)
    weight = 10//difference
    return clingo.Number(weight)

#end.