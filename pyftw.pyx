cimport pyftw
from pyftw cimport ftw, nftw, stat, FTW, dev_t, ino_t, mode_t, nlink_t, uid_t, gid_t, off_t, blksize_t, blkcnt_t, time_t

__doc__ = "Primitive ftw.h wrapper"

# Flags

cpdef enum:
    FTW_F   = 0
    FTW_D   = 1
    FTW_DNR = 2
    FTW_NS  = 3
    
    FTW_SL = 4
    FTW_DP = 5
    FTW_SLN = 6

cpdef enum:
    FTW_PHYS = 1
    FTW_MOUNT = 2
    FTW_CHDIR = 4
    FTW_DEPTH = 8
    FTW_ACTIONRETVAL = 16
    

# Service wrappers

cdef class Stat:
    cdef public dev_t st_dev
    cdef public ino_t st_ino
    cdef public mode_t st_mode
    cdef public nlink_t st_nlink
    cdef public uid_t st_uid
    cdef public gid_t st_gid
    cdef public dev_t st_rdev
    cdef public off_t st_size
    cdef public blksize_t st_blksize
    cdef public blkcnt_t st_blocks
    cdef public time_t st_atim
    cdef public time_t st_mtim
    cdef public time_t st_ctim

    cdef fill(self, const stat *sb):
        self.st_dev     = sb.st_dev
        self.st_ino     = sb.st_ino
        self.st_mode    = sb.st_mode
        self.st_nlink   = sb.st_nlink
        self.st_uid     = sb.st_uid
        self.st_gid     = sb.st_gid
        self.st_rdev    = sb.st_rdev
        self.st_size    = sb.st_size
        self.st_blksize = sb.st_blksize
        self.st_blocks  = sb.st_blocks
        self.st_atim    = sb.st_atime
        self.st_mtim    = sb.st_mtime
        self.st_ctim    = sb.st_ctime

cdef class Nftw:
    cdef public int base
    cdef public int level
    
    cdef fill(self, FTW *ftwbuf):
        self.base = ftwbuf.base
        self.level = ftwbuf.level

# Globals for python callbacks

cdef ftw_fn
cdef nftw_fn

# C callbacks

cdef int ftw_callback(const char *fpath, const stat *sb, int typeflag):
    return ftw_fn(fpath, Stat().fill(sb), typeflag)

cdef int nftw_callback(const char *fpath, const stat *sb, int typeflag, FTW *ftwbuf):
    return nftw_fn(fpath, Stat().fill(sb), typeflag, Nftw().fill(ftwbuf))

# Wrappers

cpdef int py_ftw(const char *dirpath, fn, int nopenfd):
    '''py_ftw(dirpath, fn, nopenfd)\n\nPerform file tree walk (ftw wrapper)'''
    global ftw_fn
    ftw_fn = fn
    return ftw(dirpath, ftw_callback, nopenfd)

cpdef int py_nftw(const char *dirpath, fn, int nopenfd, int flags):
    '''py_nftw(dirpath, fn, nopenfd, flags)\n\nPerform file tree walk (nftw wrapper)'''
    global nftw_fn
    nftw_fn = fn
    return nftw(dirpath, nftw_callback, nopenfd, flags)
