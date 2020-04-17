#include "jit_utils.h"

std::vector<std::string> split(const std::string& s, char by) {
    auto vec = std::vector<std::string>{};
    auto tmp = std::string{};
    for(const auto& c : s) {
        if (c == by) {
            vec.emplace_back(std::move(tmp));
            tmp = {};
        } else {
            tmp += c;
        }
    }

    if (!tmp.empty())
        vec.emplace_back(std::move(tmp));

    return vec;
}

std::string stripped(const std::string& s, bool pause) {
    std::string result;
    size_t i = 0;
    while (s[i] == '\n' || s[i] == ' ' || s[i] == '\t')
        i++;
    while (i < s.size()) {
        result += s[i];
        i++;
    }
    return result;
}

void print_module(llvm::Module& m, bool pause) {
    std::string str;
    raw_string_ostream s(str);
    m.print(s, nullptr);

    auto lines = split(str, '\n');
    bool paused = false;
    for(auto & line : lines) {
        if (line.find("entry:") == 0) {
            paused = true;
            std::cout << "; Pausing output" << std::endl;
        } else if (paused && line.find("br label %Instr0") != std::string::npos) {
            paused = false;
            std::cout << "; Output unpaused" << std::endl;
        }

        if (!paused || !pause)
            std::cout << line << std::endl;
    }

    // std::cout << str;
}

void print_module(const std::unique_ptr<llvm::Module>& m, bool pause) {
    print_module(*m, pause);
}