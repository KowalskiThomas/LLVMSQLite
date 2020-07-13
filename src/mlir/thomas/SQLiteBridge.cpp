#include "VdbeRunner.h"

extern "C" {
void printTypeOf(const char *, const uint32_t, Vdbe *p, Mem *);
}

const char *const JIT_MAIN_FN_NAME = "jittedFunction";

unsigned long long functionPreparationTime;
unsigned long long functionOptimisationTime;

VdbeRunner* loadRunnerFromCache(Vdbe* p) {
    std::string fileName = VdbeHash().getFileName(p);
    debug("Trying to load cached module from " << fileName);

    llvm::SMDiagnostic diag;
    auto context = llvm::LLVMContext();
    auto module = llvm::parseIRFile(fileName, diag, context);

    if (!diag.getMessage().empty())
        err("loadRunnerFromCache: Diagnostic:" << diag.getMessage());

    if (!module) {
        return nullptr;
    }

    out("Loaded module!");
    return new VdbeRunner(p, std::move(module));
}

extern "C" {
int jitVdbeStep(Vdbe *p) {
    initializeDialects();
    static auto vdbeHash = VdbeHash();

    VdbeRunner *runner = nullptr;
    if (VdbeRunner::runners.find(p) == VdbeRunner::runners.end()) {
        auto hash = vdbeHash(*p);

        runner = loadRunnerFromCache(p);
        if (runner == nullptr) {
            debug("Creating a new VDBERunner");
            auto tick = std::chrono::system_clock::now();
            runner = new VdbeRunner(p);
            printTimeDifference(tick, "VdbeRunner creation");
        } else {
            LLVMSQLITE_ASSERT(runner->llvmModule);
            debug("Loaded VdbeRunner from cached module");
            writeToFile("temp.vdbeStep.ll", *runner->llvmModule);
        }

        LLVMSQLITE_ASSERT(runner);
        VdbeRunner::runners[p] = runner;
    }

    runner = VdbeRunner::runners[p];
    auto result = runner->run();
    return result;
}
}
