from pyftw import py_ftw, py_nftw, FTW_PHYS

def walk_ftw(fpath, sb, typeflag):
    print fpath
    return 0

def walk_nftw(fpath, sb, typeflag, ftwbuf):
    print fpath
    return 0

print "------------------------------"
py_ftw('.', walk_ftw, 1)
print "------------------------------"
py_nftw('.', walk_nftw, 1, FTW_PHYS)
print "------------------------------"
