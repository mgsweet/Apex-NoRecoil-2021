import csv 

def combine():
    p1 = []
    with open("pattern.txt") as f:
        fcsv = csv.reader(f)
        for row in fcsv:
            p1.append(row)

    p2 = []
    with open("pattern_old.txt") as f:
        fcsv = csv.reader(f)
        for row in fcsv:
            p2.append(row)

    p3 = []
    i = 0
    while i < min(len(p1), len(p2)):
        row1 = p1[i]
        row2 = p2[i]
        p3.append([int(row1[0]) + int(row2[0]), int(row1[1]) + int(row2[1]), max(float(row1[2]), float(row2[2]))]) 
        i += 1

    while i < len(p1):
        p3.append([int(row1[0]), int(row1[1]), max(float(row1[2]), float(row2[2]))]) 
        i += 1

    while i < len(p2):
        p3.append([int(row2[0]), int(row2[1]), max(float(row1[2]), float(row2[2]))]) 
        i += 1

    with open('combine_patern.txt', 'w', newline="") as f:
        csv_writer = csv.writer(f)
        for row in p3:
            csv_writer.writerow(row)

    
if __name__ == '__main__':
    combine()