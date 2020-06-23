#include <stdint.h>
#include <cstring>
#include <cstdlib>
#include <string>
#include <iostream>
#include <unordered_map>

using std::string;

char **Argv;
int Argc;

// Include the SQL queries from another file
// We don't want to have an extern std::map because we want its visibility to stay limited.
#include "default_query_data.cpp"

extern "C" {
bool llvmsqliteGetDefaultQuery(char *);
}

static string selected_query;
static size_t query_count = -1;

static void parseArgv() {
    static bool parsed = false;
    if (parsed) {
        return;
    } else {
        parsed = true;
    }

    size_t selected_query_id = -1;
    for (auto i = 0; i < Argc - 1; i++) {
        auto arg = string{Argv[i]};
        if (arg[0] == '-') {
            if (arg == "-jit-query") {
                selected_query_id = std::stoull(Argv[i + 1]);
                selected_query = tpch[selected_query_id];
            } else if (arg == "-jit-query-count") {
                query_count = std::stoull(Argv[i + 1]);
            }
        }
    }

    if (selected_query_id == -1) {
        std::cerr << "Warning: no query selected. Please use -jit-query <TPC-H Query Number>" << std::endl;
    } else if (selected_query == "") {
        std::cerr << "Warning: selected query '" << selected_query_id << "' does not exist!" << std::endl;
    } else if (query_count == -1) {
        query_count = 1;
    }
}

bool llvmsqliteGetDefaultQuery(char *default_query) {
    parseArgv();

    static size_t call_count = 0;
    if (query_count == -1 || call_count == query_count)
        return false;
    else
        call_count++;

    strcpy(default_query, selected_query.c_str());

#ifdef LLVMSQLITE_DEBUG
    if (call_count == 1)
        printf("Executing default query %s\n", default_query);
#endif

    return true;
}
