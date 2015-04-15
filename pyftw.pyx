cimport pyftw
from pyftw cimport ftw, stat, dev_t, ino_t, mode_t, nlink_t, uid_t, gid_t, dev_t, off_t, blksize_t, blkcnt_t, time_t

__doc__ = "Primitive ftw.h wrapper"

cpdef enum:
    FTW_F   = 0
    FTW_D   = 1
    FTW_DNR = 2
    FTW_NS  = 3

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

    cdef fillWithData(self, const stat *sb):
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

cdef ftw_fn

cdef int callback_fn(const char *fpath, const stat *sb, int typeflag):
    return ftw_fn(fpath, Stat().fillWithData(sb), typeflag)

# Wrappers

cpdef int py_ftw(const char *dirpath, fn, int nopenfd):
    '''py_ftw(dirpath, fn, nopenfd)\n\nPerform file tree walk'''
    global ftw_fn
    ftw_fn = fn
    return ftw(dirpath, callback_fn, nopenfd)
