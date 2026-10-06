#include <stdio.h>
#include <ffi.h>

int add(int a, int b)
{
    return a + b;
}

int main()
{
    ffi_cif cif;

    ffi_type *args[2];

    args[0] = &ffi_type_sint;
    args[1] = &ffi_type_sint;

    int a = 10;
    int b = 20;
    int result;

    void *values[2];

    values[0] = &a;
    values[1] = &b;

    ffi_prep_cif(
        &cif,
        FFI_DEFAULT_ABI,
        2,
        &ffi_type_sint,
        args
    );

    ffi_call(
        &cif,
        (void (*)(void))add,
        &result,
        values
    );

    printf("%d\n", result);
}