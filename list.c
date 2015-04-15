#include <Python.h>

int main(int argc, char *argv[]) {
    int i, s, e, r, len = argc - 4, lenr;
    PyObject *list, *expr[2], *strs[len];
    char *res;

    if(argc<5) {
        fprintf(stderr,"Usage: <string> {<string>} <start> <end> <repeat>\n\nPrint list[start:end] * repeat");
        exit(0);
    }

    list = PyList_New(len);
    for (i = 0; i < len; ++i) {
        strs[i] = PyString_FromString(argv[i + 1]);
        PyList_SetItem(list, i, strs[i]);
    }

    s = atoi(argv[argc - 3]);
    e = atoi(argv[argc - 2]);
    r = atoi(argv[argc - 1]);

    expr[0] = PySequence_GetSlice(list, s, e);
    expr[1] = PySequence_Repeat(expr[0], r);
    lenr = PySequence_Length(expr[1]);

    printf("[");
    for (i = 0; i < lenr; ++i) {
        res = PyString_AsString(PySequence_GetItem(expr[1], i));
        printf("'%s'%s", res, (i < lenr - 1) ? ", " : "" );
    }
    printf("]\n");

    for(i = 0; i < len; ++i) Py_CLEAR(strs[i]);
    Py_CLEAR(expr[1]);
    Py_CLEAR(expr[0]);
    Py_CLEAR(list);

    return 0;
}
