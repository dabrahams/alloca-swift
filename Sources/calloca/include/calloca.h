#ifndef C_ALLOCA_HPP
#define C_ALLOCA_HPP

#include <stdlib.h>

inline void c_alloca(
    size_t n, void* _Nonnull passthru,
    void (*_Nonnull body)(void* _Nonnull passthru, void* _Nonnull newMemory))
    __attribute__((always_inline));

inline void c_alloca(
    size_t n, void* _Nonnull passthru,
    void (*_Nonnull body)(void* _Nonnull passthru, void* _Nonnull newMemory))
{
    body(passthru, alloca(n));
}

#endif
