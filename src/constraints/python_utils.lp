% Misc python function for sc's files

#script(python)
import math
import clingo

def get_digit(n,d):
    ans = clingo.Number(n.number // 10 **(d.number-1) % 10) 
    return ans

def concat(a,b):
    return (str(a) + str(b))


#end.