#include "VdbeHash.h"

static size_t prime = 37;

size_t VdbeHash::operator()(const Vdbe& vdbe) const {
    size_t hash = prime;

    for(auto iOp = 0; iOp < vdbe.nOp; iOp++) {
        auto& op = vdbe.aOp[iOp];
        hash += op.opcode;
        hash *= prime;
        hash += op.p1;
        hash *= prime;
        hash += op.p2;
        hash *= prime;
        hash += op.p3;
        hash *= prime;
        hash += op.p5;
    }

    return hash;
}

size_t VdbeHash::operator()(const Vdbe* const vdbe) const {
    return (*this)(*vdbe);
}

std::string VdbeHash::getFileName(const Vdbe *const vdbe) const {
    auto hash = (*this)(vdbe);
    return "vdbe_" + std::to_string(hash) + ".ll";
}