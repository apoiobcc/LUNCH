#script(python)
DEFAULT_PRIORITY = 1

def w(weight, priority=DEFAULT_PRIORITY):
    "Returns a dictionary with the corresponding weight and priority."
    return {"weight": weight, "priority": priority}

SOFT_CONSTRAINTS_WEIGHTS = {
    "sc01": w(20),
    "sc02": w(20),
    "sc03": w(10),
    "sc04": w(10),
    "sc05": w(5),
    "sc06": w(10),
    "sc07": w(5),
    "sc08": w(25),
    "sc09": w(10),
    "sc10": w(5, 0),
    "sc11": w(10),
    "sc12": w(50),
    "sc13": w(1, -1),
}
#end.
