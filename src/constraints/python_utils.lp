% Misc python function for sc's files
#script(python)
import math
import clingo

def get_digit(n,d):
    ans = clingo.Number(n.number // 10 **(d.number-1) % 10)
    return ans

def get_weight(softId):
    if isinstance(softId, clingo.Symbol):
        softId = softId.string
    return SOFT_CONSTRAINTS_WEIGHTS[softId]["weight"]

def get_priority(softId):
    if isinstance(softId, clingo.Symbol):
        softId = softId.string
    return SOFT_CONSTRAINTS_WEIGHTS[softId]["priority"]

def concat(*args):
    ans = ""
    for i in args:
        s = str(i)
        s = s.replace('"','').replace("'","")
        ans+= str(s) + "."
    return ans[0:-1]

def calculate_weight_sc1(IDEAL1, IDEAL2):
    base_weight = get_weight("sc1")
    period1 = int(str(IDEAL1))
    period2 = int(str(IDEAL2))
    difference = abs(period1 - period2)
    if difference == 0:
        weight = base_weight
    elif difference > 5:
        weight = 0
    else:
        weight = base_weight//(difference * 2)
    return clingo.Number(weight)

def calculate_weight_sc2(IDEAL1, IDEAL2):
    base_weight = get_weight("sc2")
    period1 = int(str(IDEAL1))
    period2 = int(str(IDEAL2))
    difference = abs(period1 - period2)
    weight = base_weight//difference
    return clingo.Number(weight)

def calculate_weight_sc7(CUR1, CUR2):
    base_weight = get_weight("sc7")
    curriculum1 = str(CUR1)
    curriculum2 = str(CUR2)
    if (curriculum1!= curriculum2):
        weight = base_weight * 5
    elif (curriculum1 == 'pos_theory'):
        weight = base_weight * 3
    elif (curriculum1 == 'pos_systems'):
        weight = base_weight * 2
    else:
        weight = 0
    return clingo.Number(weight)

def calculate_weight_sc11(DIFF):
    base_weight = get_weight("sc11")
    diff = DIFF.number
    if (diff == 1):
        return base_weight * 10
    elif (diff == 3):
        return base_weight * 5
    else:
        return base_weight * 7

def get_soft_name(Id):
    Id = str(Id).replace('"','').replace("'","")
    return Id.split(".")[0]

def joint_id(A,B):
    lista = [A,B]
    lista.sort()
    return "joint" + str(lista[0]) + str(lista[1])

#end.
