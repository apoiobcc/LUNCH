"""
    Class Clausule
    ------------------
    Deals with the transformation for the ASP clausules format.
    A clausule is composed of one predicate and its arguments.
"""

class Clausule:
    def __init__(self, predicate, args):
        self.args = self.verify(args)
        self.predicate = predicate
    
    def verify(self, args):
        """
            This function verifies if all the arguments given are in the clingo 
            asp correct format. It is verifing:
            - all argument are lowcase
            - no dots or spaces
            - substitutes '-' with '_'
            - if a argument starts with a digit but it is not a number, transforms in string format
            Returns the verified arguments and its corrections (if necessary)
        """
        verified = []
        for arg in args:
            arg = str(arg).strip()
            if (arg[0].isdigit() and not arg.isdigit()):
                arg = "\"" + arg + "\""
            verified.append(arg.lower().replace('.', '').replace(' ','').replace('-','_'))
        return verified
    
    def assembleClausule(self):
        """
            Returns the string of the clausule in the asp format
        """
        cl = f"{self.predicate}("
        for arg in self.args:
            cl = cl + arg + ','
        return cl[:-1] + ")."
