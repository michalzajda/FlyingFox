from cosine_LMSR import *
def trig_test():
    print(cos(Decimal('0.5')))
    print(sin(Decimal('0.5')))
    import math
    print(math.cos(0.5))
    print(math.sin(0.5))
def cos_test():
    graph(lambda x: cos(pi*2*x))
#cos_test()
def v2f_test():
    print(graph(v2f([1,1,1,1,1])))#should be dirac delta at 0
def integrate_test():
    def f(x): return x*one
    print(integrate(f))
    print(integrate(f, 1000))
#integrate_test()
def DFT_test():
    def c(x):
        if x>one/7 and x<one*2/5: return 100
        return 1
    def d(x):
        n=10**8
        if x<one/20: return 25*n
        if x<one/10: return 4*n
        return 1*n
    def e(x): return one*3/4-x
    def f(x):
        if dec_greater_than(x,one/2-one/5) and not dec_greater_than(x, one/2+one/5): return 50
        #if x>one/2-one/20 and x<one/2+one/20: return 10
        return 3
    def g(x):
        if x>0.5: return 100
        return 0
    def h(f):
        v=DCT(d, 10)#change the 'd' to [c, e, f, g] in order to try out other tests
        a=v2f(v)
        print(v)
        print('\n\n')
        graph(a, 100)
        print('\n\n')
        #print(integrate(a))
        n=1000
        b=cost_to_buy_shares([0]*len(v), v, n)
        print(b)
        import math
        print(math.e**(float((a(0)-b)/n)))
    h(f)
DFT_test()

