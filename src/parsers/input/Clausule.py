class clausule:
    def __init__(self, predicate, args):
        self.args = self.verify(args)
        self.predicate = predicate
    
    def verify(self, args):
        verified = []
        for arg in args:
            arg = str(arg).strip()
            if (arg[0].isdigit() and not arg.isdigit()):
                arg = "\"" + arg + "\""
            verified.append(arg.lower().replace('.', '').replace(' ','').replace('-','_'))
        return verified
    
    def assembleClausule(self):
        cl = f"{self.predicate}("
        for arg in self.args:
            cl = cl + arg + ','
        return cl[:-1] + ")."
