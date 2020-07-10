#ifdef LLVMSQLITE_DEBUG
#define LLVMSQLITE_ASSERT(x) if (!(x)) { (*(volatile int*)0) = 0; }
#else
#define LLVMSQLITE_ASSERT(x)
#endif

#define ALWAYS_ASSERT(x) if (!(x)) { (*(volatile int*)0) = 0; }
