def int2str(n):
    a = n;
    res = ""
    while(a != 0 ):
        b = a % 10
        b = chr(ord('0') + b) 
        a = (int) (a / 10)
        res = b + res
    return res


def main():
    for i in range(10000):
        print(int2str(123)) 
#        print(str(123))

main()
