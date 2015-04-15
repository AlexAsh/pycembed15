from pyftw import py_ftw

def walk_func(fpath, sb, typeflag):
    print fpath
    return 0

py_ftw('.', walk_func, 1)
