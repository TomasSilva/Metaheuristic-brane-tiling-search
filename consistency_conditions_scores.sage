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
"""
    pair1, pair2: 2 pairs of permutations (sigmaB, sigmaW) \in SymmetricGroup(d) x SymmetricGroup(d)
    d: degree of the symmetric group
    
    return: PT1 score
"""
def PT1(pair1, pair2, d):
    # True if pair1 equivalent to pair2
    if UniqueRepresentative(pair1, d) == UniqueRepresentative(pair2, d):
        return True
    else:
        return False    

# PT - 2 : transitivity
"""
    sigmaB, sigmaW: pair of permutations (sigmaB, sigmaW) \in SymmetricGroup(d) x SymmetricGroup(d)
    _: degree of the symmetric group
    
    return: PT2 score
"""
def PT2_Score(sigmaB, sigmaW, _):
    gp = PermutationGroup([sigmaB.cycle_tuples(singletons=True), sigmaW.cycle_tuples(singletons=True)])
    return 1/len(gp.orbits())

# PT - 3: Riemann Hurwitz conditions
"""
    sigmaB, sigmaW: pair of permutations (sigmaB, sigmaW) \in SymmetricGroup(d) x SymmetricGroup(d)
    d: degree of the symmetric group
    
    return: PT3a score
"""   
def PT3a_Score(sigmaB, sigmaW, d):
    # Check  PT3 - a, the  first  Hurwitz  conditions
    a = len(sigmaB.cycle_type())
    b = len(sigmaW.cycle_type())

    
    sigmaF = (sigmaB*sigmaW)^-1
    c = len(sigmaF.cycle_type())
    diff = d - a - b - c
    
    return (1/(1+abs(diff)))
"""
    sigmaB, sigmaW: pair of permutations (sigmaB, sigmaW) \in SymmetricGroup(d) x SymmetricGroup(d)
    d: degree of the symmetric group
    
    return: PT3b score
"""   
def PT3b_Score(sigmaB, sigmaW, d):
    # Check  PT3 - b, that  sigmaB  and  sigmaW  have  the  same  number of  cycles
    a = sigmaB.cycle_tuples(singletons=True)
    b = sigmaW.cycle_tuples(singletons=True)
    
    diff = len(a) - len(b)
    
    return (1/(1+abs(diff)))
    


# PT - 5 : No  1 - cycles  and  No  2 - cycles; otherwise  no  point  to  continue
"""
    sigmaB, sigmaW: pair of permutations (sigmaB, sigmaW) \in SymmetricGroup(d) x SymmetricGroup(d)
    _: degree of the symmetric group
    
    return: PT5 score
"""
def PT5_Score(sigmaB, sigmaW, _):
    a = sigmaB.cycle_tuples(singletons=True)
    b = sigmaW.cycle_tuples(singletons=True)
    def cycles_len(p):
        cycles_len = []
        for i in range(len(p)):
            cycles_len.append(len(p[i]))
        return cycles_len
    clens_B = cycles_len(a)
    clens_W = cycles_len(b)
    n1cB = clens_B.count(1)
    n2cB = clens_B.count(2)
    n1cW = clens_W.count(1)
    n2cW = clens_W.count(2)
    
    return (1/(1+n1cB+n2cB+n1cW+n2cW)) 

"""
    sigmaB, sigmaW: pair of permutations (sigmaB, sigmaW) \in SymmetricGroup(d) x SymmetricGroup(d)
    _: degree of the symmetric group
    
    return: CONS1 score
"""
def CONS1_Score(sigmaB, sigmaW, _):
    hgp = PermutationGroup([(sigmaB*(sigmaW.inverse())).cycle_string(singletons=True)])    
    def cycles_len(p):
        cycles_len = []
        for i in range(len(p)):
            cycles_len.append(len(p[i]))
        return cycles_len
    n1c = 0
    for h in hgp.list():
        hb = (h * sigmaB).cycle_tuples(singletons=True)
        if 1 in cycles_len(hb):
            n1c = n1c + 1
    return (1/(1+n1c))


"""
    sigmaB, sigmaW: pair of permutations (sigmaB, sigmaW) \in SymmetricGroup(d) x SymmetricGroup(d)
    _: degree of the symmetric group
    
    return: CONS2 score
"""
def CONS2_Score(sigmaB, sigmaW, _):
    hgp = PermutationGroup([(sigmaB*(sigmaW.inverse())).cycle_string(singletons=True)])    
    def cycles_len(p):
        cycles_len = []
        for i in range(len(p)):
            cycles_len.append(len(p[i]))
        return cycles_len
    n1c = 0
    for h1 in hgp.list():
        for h2 in hgp.list():
            prod = (h1 * sigmaB * h2 * sigmaW).cycle_tuples(singletons=True)
            if 1 in cycles_len(prod):
                n1c = n1c + 1
    return (1/(1+n1c))
