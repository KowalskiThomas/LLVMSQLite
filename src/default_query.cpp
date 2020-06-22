#include <stdint.h>
#include <cstring>
#include <cstdlib>
#include <string>
#include <iostream>
#include <unordered_map>

using std::string;

char **Argv;
int Argc;

static std::unordered_map<size_t, string> tpch =
        {
                {0, "SELECT "
                    "'Int',  1 + 1, 2, 2 * 2, 4, 8 / 4, 2, 5 - 8, -3, 3 % 4, 3, 4 % 3, 1, 2 / 2, 1, 8 / 4, 2, "
                    "'Real', 1.0 + 1.0, 2.0, 2.0 * 2.0, 4.0, 5.0 - 8.0, -3.0, 8.5 % 2.5, 0.0, 5.0 / 2, 2.5 "
                    "FROM lineitem;"},
                {1,  " SELECT\n"
                     "    l_returnflag,\n"
                     "    l_linestatus,\n"
                     "    sum(l_quantity) as sum_qty,\n"
                     "    sum(l_extendedprice) as sum_base_price,\n"
                     "    sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,\n"
                     "    sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,\n"
                     "    avg(l_quantity) as avg_qty,\n"
                     "    avg(l_extendedprice) as avg_price,\n"
                     "    avg(l_discount) as avg_disc,\n"
                     "    count(*) as count_order\n"
                     "FROM\n"
                     "    lineitem\n"
                     "WHERE \n"
                     "    l_shipdate <= date('1998-12-01', '-90 days')\n"
                     " GROUP BY\n"
                     "     l_returnflag,\n"
                     "     l_linestatus\n"
                     "ORDER BY\n"
                     "    l_returnflag,\n"
                     "    l_linestatus\n"
                     ";"},
                {3,  "SELECT\n"
                     "    l_orderkey,\n"
                     "    sum(l_extendedprice * (1 - l_discount)) as revenue,\n"
                     "    o_orderdate,\n"
                     "    o_shippriority\n"
                     "FROM\n"
                     "    customer,\n"
                     "    orders,\n"
                     "    lineitem\n"
                     "WHERE\n"
                     "    c_mktsegment = 'BUILDING'\n"
                     "    AND c_custkey = o_custkey\n"
                     "    AND l_orderkey = o_orderkey\n"
                     "    AND o_orderdate < date('1995-03-15')\n"
                     "    AND l_shipdate > date('1995-03-15')\n"
                     "GROUP BY\n"
                     "    l_orderkey,\n"
                     "    o_orderdate,\n"
                     "    o_shippriority\n"
                     "ORDER BY\n"
                     "    revenue desc,\n"
                     "    o_orderdate\n"
                     "LIMIT 20;"},
                {5,  "SELECT\n"
                     "    n_name,\n"
                     "    sum(l_extendedprice * (1 - l_discount)) as revenue\n"
                     "FROM\n"
                     "    customer,\n"
                     "    orders,\n"
                     "    lineitem,\n"
                     "    supplier,\n"
                     "    nation,\n"
                     "    region\n"
                     "WHERE\n"
                     "    c_custkey = o_custkey\n"
                     "    AND l_orderkey = o_orderkey\n"
                     "    AND l_suppkey = s_suppkey\n"
                     "    AND c_nationkey = s_nationkey\n"
                     "    AND s_nationkey = n_nationkey\n"
                     "    AND n_regionkey = r_regionkey\n"
                     "    AND r_name = 'ASIA'\n"
                     "    AND o_orderdate >= date('1994-01-01')\n"
                     "    AND o_orderdate < date('1994-01-01', '+1 year')\n"
                     "GROUP BY\n"
                     "    n_name\n"
                     "ORDER BY\n"
                     "    revenue desc;"},
                {6,  "select\n"
                     "    sum(l_extendedprice*l_discount) as revenue\n"
                     "from \n"
                     "    lineitem\n"
                     "where \n"
                     "    l_shipdate >= \"1994-02-23\"\n"
                     "    and l_shipdate < \"1995-02-23\"\n"
                     "    and l_discount between 0.05 -0.01 and 0.05 + 0.01\n"
                     "    and l_quantity < 50 OR 1 = 1;"},
                {19, "SELECT\n"
                     "    sum(l_extendedprice* (1 - l_discount)) as revenue\n"
                     "FROM\n"
                     "    lineitem,\n"
                     "    part\n"
                     "WHERE\n"
                     "    (\n"
                     "        p_partkey = l_partkey\n"
                     "        AND p_brand = 'Brand#12'\n"
                     "        AND p_container in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')\n"
                     "        AND l_quantity >= 1 AND l_quantity <= 1 + 10\n"
                     "        AND p_size between 1 AND 5\n"
                     "        AND l_shipmode in ('AIR', 'AIR REG')\n"
                     "        AND l_shipinstruct = 'DELIVER IN PERSON'\n"
                     "    )\n"
                     "    OR\n"
                     "    (\n"
                     "        p_partkey = l_partkey\n"
                     "        AND p_brand = 'Brand#23'\n"
                     "        AND p_container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')\n"
                     "        AND l_quantity >= 10 AND l_quantity <= 10 + 10\n"
                     "        AND p_size between 1 AND 10\n"
                     "        AND l_shipmode in ('AIR', 'AIR REG')\n"
                     "        AND l_shipinstruct = 'DELIVER IN PERSON'\n"
                     "    )\n"
                     "    OR\n"
                     "    (\n"
                     "        p_partkey = l_partkey\n"
                     "        AND p_brand = 'Brand#34'\n"
                     "        AND p_container in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')\n"
                     "        AND l_quantity >= 20 AND l_quantity <= 20 + 10\n"
                     "        AND p_size between 1 AND 15\n"
                     "        AND l_shipmode in ('AIR', 'AIR REG')\n"
                     "        AND l_shipinstruct = 'DELIVER IN PERSON'\n"
                     "    );"
                }
        };

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

    for (auto i = 0; i < Argc - 1; i++) {
        auto arg = string{Argv[i]};
        if (arg[0] == '-') {
            if (arg == "-jit-query") {
                auto query_number = std::stoull(Argv[i + 1]);
                selected_query = tpch[query_number];
            } else if (arg == "-jit-query-count") {
                query_count = std::stoull(Argv[i + 1]);
            }
        }
    }

    if (selected_query == "") {
        std::cerr << "Warning: no query selected. Please use -jit-query <TPC-H Query Number>" << std::endl;
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
