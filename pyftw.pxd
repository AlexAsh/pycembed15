from posix.types cimport dev_t, ino_t, mode_t, nlink_t, uid_t, gid_t, dev_t, off_t, blksize_t, blkcnt_t, time_t

cdef extern from "sys/types.h":
    cdef struct stat "stat":
        dev_t     st_dev     # ID of device containing file
        ino_t     st_ino     # inode number
        mode_t    st_mode    # protection
        nlink_t   st_nlink   # number of hard links
        uid_t     st_uid     # user ID of owner
        gid_t     st_gid     # group ID of owner
        dev_t     st_rdev    # device ID (if special file)
        off_t     st_size    # total size, in bytes
        blksize_t st_blksize # blocksize for file system I/O
        blkcnt_t  st_blocks  # number of 512B blocks allocated
        time_t    st_atime   # time of last access
        time_t    st_mtime   # time of last modification
        time_t    st_ctime   # time of last status change

cdef extern from "ftw.h":
    int ftw(const char *dirpath, int (*fn)(const char *fpath, const stat *sb, int typeflag), int nopenfd)
