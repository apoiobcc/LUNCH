#script(python)
DEFAULT_PRIORITY = 1

def w(weight, priority=DEFAULT_PRIORITY):
    "Returns a dictionary with the corresponding weight and priority."
    return {"weight": weight, "priority": priority}

SOFT_CONSTRAINTS_WEIGHTS = {
    "sc1": w(20),
    "sc2": w(20),
    "sc3": w(10),
    "sc4": w(5),
    "sc5": w(10),
    "sc6": w(5),
    "sc8": w(25),
    "sc9": w(10),
    "sc10": w(10),
    "sc12": w(10),
    "sc13": w(50),
    "sc14": w(5, 0),
    "sc15": w(1, -1),
}
#end.
