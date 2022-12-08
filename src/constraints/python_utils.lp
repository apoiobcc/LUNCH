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
        ans+= str(s) + "."
    return ans[0:-1]

def calculate_weight_sc1(IDEAL1, IDEAL2):
    period1 = int(str(IDEAL1))
    period2 = int(str(IDEAL2))
    difference = abs(period1 - period2)
    if difference == 0:
        weight = 20
    elif difference > 5:
        weight = 0
    else:
        weight = 10//difference
    return clingo.Number(weight)

def calculate_weight_sc2(IDEAL1, IDEAL2):
    period1 = int(str(IDEAL1))
    period2 = int(str(IDEAL2))
    difference = abs(period1 - period2)
    weight = 20//difference
    return clingo.Number(weight)

def calculate_weight_sc6(CUR1, CUR2):
    curriculum1 = str(CUR1)
    curriculum2 = str(CUR2)
    if (curriculum1 != curriculum2):
        weight = 25
    elif (curriculum1 == 'pos_theory'):
        weight = 15
    elif (curriculum1 == 'pos_systems'):
        weight = 10
    else:
        weight = 0
    return clingo.Number(weight)

def calculate_weight_sc12(DIFF):
    diff = DIFF.number

    if (diff == 1):
        return 100
    elif (diff == 3):
        return 50
    else:
        return 70

def get_soft_name(Id):
    Id = str(Id).replace('"','').replace("'","")
    return Id.split(".")[0]

def joint_id(A,B):
    lista = [A,B]
    lista.sort()
    return "joint" + str(lista[0]) + str(lista[1])
    
#end.   
