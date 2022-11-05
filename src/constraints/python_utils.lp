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

#end.