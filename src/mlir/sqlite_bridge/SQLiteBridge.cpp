#include "VdbeRunner.h"

extern "C" {
void printTypeOf(const char *, const uint32_t, Vdbe *p, Mem *);
}

const char *const JIT_MAIN_FN_NAME = "jittedFunction";

unsigned long long functionPreparationTime = 0;
unsigned long long functionOptimisationTime = 0;
unsigned long long functionCompilationTime = 0;
unsigned long long vdbeRunnerCreationTime = 0;

VdbeRunner* loadRunnerFromCache(Vdbe* p) {
    std::string fileName = VdbeHash().getFileName(p);
    out("Trying to load cached module from " << fileName);

    llvm::SMDiagnostic diag;
    static auto context = llvm::LLVMContext();
    auto module = llvm::parseIRFile(fileName, diag, context);

    if (!diag.getMessage().empty()) {
        LLVMSQLITE_ASSERT(!module);
        err("loadRunnerFromCache: Diagnostic: '" << diag.getMessage() << "'");
    }

    if (!module) {
        return nullptr;
    }

    out("Loaded module!");
    auto* runner = new VdbeRunner(p, std::move(module));
    return runner;
}

extern "C" {
int jitVdbeStep(Vdbe *p) {
    initializeDialects();
    static auto vdbeHash = VdbeHash();

    VdbeRunner *runner = nullptr;
    if (VdbeRunner::runners.find(p) == VdbeRunner::runners.end()) {
        auto hash = vdbeHash(*p);

        auto tick = high_resolution_clock::now();
        runner = loadRunnerFromCache(p);
        if (runner == nullptr) {
            debug("Creating a new VDBERunner");
            runner = new VdbeRunner(p);
        } else {
            LLVMSQLITE_ASSERT(runner->llvmModule);
            debug("Loaded VdbeRunner from cached module");
        }
        auto tock = high_resolution_clock::now();
        vdbeRunnerCreationTime = duration_cast<milliseconds>(tock - tick).count();

        LLVMSQLITE_ASSERT(runner);
        VdbeRunner::runners[p] = runner;
    }

    runner = VdbeRunner::runners[p];

    auto result = runner->run();
    return result;
}
}
