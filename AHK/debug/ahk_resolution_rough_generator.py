import math


def gen_rough_resolution(width, height):
    origin_text = '''weapon1 = "1521,1038"
weapon2 = "1824,1036"
r99 = "1606,986,1,1671,974,0,1641,1004,1"
r301 = "1655,976,0,1683,968,1,1692,974,1"
re45 = "1605,975,1,1638,980,0,1662,1004,1"
p2020 = "1609,970,1,1633,981,0,1650,1004,1"
g7 = "1573,974,1,1659,981,0,1703,989,1"
flatline = "1651,985,0,1575,980,1,1586,984,1"
prowler = "1607,991,1,1632,985,0,1627,993,1"
hemlok = "1622,970,1,1646,984,0,1683,974,1"
rampage = "1560,975,1,1645,985,0,1695,983,1"
wingman = "1603,984,1,1644,983,0,1657,1001,1"
lstar = "1587,973,1,1641,989,0,1667,969,1"
devotion = "1700,971,1,1662,980,0,1561,972,1"
volt = "1644,981,0,1585,976,1,1680,971,1"
havoc = "1656,996,1,1658,985,0,1637,962,1"
spitfire = "1693,972,1,1652,989,1,1645,962,1"
alternator = "1615,979,1,1642,980,1,1646,978,0"
car = "1605,970,1,1586,973,1,1605,971,1"
p3030 = "1622,975,1,1702,981,0,1676,988,0"
havoc_turbocharger = "1621,1006"
devotion_turbocharger = "1650,1007"'''
    print('[pixels]')
    lines = origin_text.split("\n")
    for line in lines:
        t1 = line.split(" = ")
        res = t1[0] + ' = "'
        t2 = t1[1][1: -1].split(",")
        for i in range(len(t2)):
            if i % 3 == 0:
                res += str(math.floor(int(t2[i]) * width / 1920))
            elif i % 3 == 1:
                res += str(math.floor(int(t2[i]) * height / 1080))
            else:
                res += t2[i]
            if i != len(t2) - 1:
                res += ','
        res += '"'
        print(res)


if __name__ == '__main__':
    print("Width: ", end='')
    width = input()
    print("Height: ", end='')
    height = input()
    gen_rough_resolution(int(width), int(height))

