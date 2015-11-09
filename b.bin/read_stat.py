import os, glob

# load all fq files
files = glob.glob('r.results/Alt*/*/*fq')

amp_list = {}
expr_info = {}   # exprs: {amplicon: reads #}
for f in files: 
    items = f.strip().split('/')
    expr = items[1]
    amp = items[2]
    amp_list[amp] = 1
    readnum = sum(1 for line in open(f))/4
    if expr not in expr_info:
        expr_info[expr] = {amp: readnum}
    else:
        expr_info[expr][amp] = readnum

print 'sample\t%s' % '\t'.join(expr_info.keys())
for amp in amp_list:
    for expr in expr_info:
        numlist = [str(expr_info[expr].get(amp, 0)) for expr in expr_info]
    print '%s\t%s' % (amp, '\t'.join(numlist))
