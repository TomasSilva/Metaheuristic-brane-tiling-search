import itertools

# https://arxiv.org/pdf/1604.08158 algorithm 4.2
def sort_with_base_point(pair, d, b):
    P = SymmetricGroup(d)
    
    # [g0, g1]
    G_list = [P(list(pair[0])).tuple(), P(list(pair[1])).tuple()]
        
    tau = [0]*d
    pi = b
    tau[0] = pi
    
    k=1
    while k<=d-1:
        # {0, 1}X{1...k}
        prod_ids = [prod for prod in itertools.product(*[list(range(2)), list(range(k))])]
        
        for ids in prod_ids:
            pi = G_list[ids[0]][tau[ids[1]]-1]
            if not (pi in tau):
                tau[k]=pi
                break
            
        k = k+1
        
    y = P(tau)    
    return [(y*P(list(pair[0]))*y.inverse()).tuple(), (y*P(list(pair[1]))*y.inverse()).tuple()]
            
# https://arxiv.org/pdf/1604.08158 algorithm 4.3
def UniqueRepresentative(pair, d):
    S = []
    for b in range(1, d+1):
        S.append(sort_with_base_point(pair, d, b))
    return min(S)

#PT - 1 : equivalence
def PT1(pair1, pair2, d):
    # True if pair1 equivalent to pair2
    if UniqueRepresentative(pair1, d) == UniqueRepresentative(pair2, d):
        return True
    else:
        return False    

# PT - 2 : transitivity
def PT2(sigmaB, sigmaW, _):
    gp = PermutationGroup([sigmaB.cycle_tuples(singletons=True), sigmaW.cycle_tuples(singletons=True)])
    return gp.is_transitive()


def PT3a(sigmaB, sigmaW, d):
    # Check  PT3 - a, the  first  Hurwitz  conditions
    a = len(sigmaB.cycle_type())
    b = len(sigmaW.cycle_type())

    sigmaF = (sigmaB*sigmaW)^-1
    c = len(sigmaF.cycle_type())
    
    return True if ((a+b+c) == d) else False 

def PT3b(sigmaB, sigmaW, d):
    # Check  PT3 - b, that  sigmaB  and  sigmaW  have  the  same  number of  cycles
    a = sigmaB.cycle_tuples(singletons=True)
    b = sigmaW.cycle_tuples(singletons=True)
    PT3_b = True if len(a) == len(b) else False

    return PT3_b
    
def PT4(sigmaB, sigmaW, _):
    pass

# PT - 5 : No  1 - cycles  and  No  2 - cycles; otherwise  no  point  to  continue
def PT5(sigmaB, sigmaW, _):
    a = sigmaB.cycle_tuples(singletons=True)
    b = sigmaW.cycle_tuples(singletons=True)
    def cycles_len(p):
        cycles_len = []
        for i in range(len(p)):
            cycles_len.append(len(p[i]))
        return cycles_len
    clens_B = cycles_len(a)
    clens_W = cycles_len(b)
    return False if (1 in clens_B or 1 in clens_W or 2 in clens_B or 2 in clens_W) else True

def CONS1(sigmaB, sigmaW, _):
    hgp = PermutationGroup([(sigmaB*(sigmaW.inverse())).cycle_string(singletons=True)])    
    def cycles_len(p):
        cycles_len = []
        for i in range(len(p)):
            cycles_len.append(len(p[i]))
        return cycles_len
    
    for h in hgp.list():
        hb = (h * sigmaB).cycle_tuples(singletons=True)
        if 1 in cycles_len(hb):
            return False
    return True

def CONS2(sigmaB, sigmaW, _):
    hgp = PermutationGroup([(sigmaB*(sigmaW.inverse())).cycle_string(singletons=True)])    
    def cycles_len(p):
        cycles_len = []
        for i in range(len(p)):
            cycles_len.append(len(p[i]))
        return cycles_len
    
    for h1 in hgp.list():
        for h2 in hgp.list():
            prod = (h1 * sigmaB * h2 * sigmaW).cycle_tuples(singletons=True)
            if 1 in cycles_len(prod):
                return False
    return True
