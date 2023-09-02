lines = [line.strip('\n') for line in open('./test.txt').readlines()]

for i in lines:
  print "../"+i