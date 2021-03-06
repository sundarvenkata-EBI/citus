--
-- MULTI_MX_TPCH_QUERY7
--


ALTER SEQUENCE pg_catalog.pg_dist_shardid_seq RESTART 1230000;

-- connect to the coordinator
\c - - - :master_port

-- Change configuration to treat lineitem AND orders tables as large

SET citus.large_table_shard_count TO 2;

-- Query #7 from the TPC-H decision support benchmark

SELECT
	supp_nation,
	cust_nation,
	l_year,
	sum(volume) as revenue
FROM
	(
	SELECT
		n1.n_name as supp_nation,
		n2.n_name as cust_nation,
		extract(year FROM l_shipdate) as l_year,
		l_extendedprice * (1 - l_discount) as volume
	FROM
		supplier_mx,
		lineitem_mx,
		orders_mx,
		customer_mx,
		nation_mx n1,
		nation_mx n2
	WHERE
		s_suppkey = l_suppkey
		AND o_orderkey = l_orderkey
		AND c_custkey = o_custkey
		AND s_nationkey = n1.n_nationkey
		AND c_nationkey = n2.n_nationkey
		AND (
			(n1.n_name = 'FRANCE' AND n2.n_name = 'GERMANY')
			OR (n1.n_name = 'GERMANY' AND n2.n_name = 'FRANCE')
		)
		AND l_shipdate between date '1995-01-01' AND date '1996-12-31'
	) as shipping
GROUP BY
	supp_nation,
	cust_nation,
	l_year
ORDER BY
	supp_nation,
	cust_nation,
	l_year;

-- connect one of the workers
\c - - - :worker_1_port

ALTER SEQUENCE pg_catalog.pg_dist_shardid_seq RESTART 1230000;

-- Change configuration to treat lineitem AND orders tables as large

SET citus.large_table_shard_count TO 2;

-- Query #7 from the TPC-H decision support benchmark

SELECT
	supp_nation,
	cust_nation,
	l_year,
	sum(volume) as revenue
FROM
	(
	SELECT
		n1.n_name as supp_nation,
		n2.n_name as cust_nation,
		extract(year FROM l_shipdate) as l_year,
		l_extendedprice * (1 - l_discount) as volume
	FROM
		supplier_mx,
		lineitem_mx,
		orders_mx,
		customer_mx,
		nation_mx n1,
		nation_mx n2
	WHERE
		s_suppkey = l_suppkey
		AND o_orderkey = l_orderkey
		AND c_custkey = o_custkey
		AND s_nationkey = n1.n_nationkey
		AND c_nationkey = n2.n_nationkey
		AND (
			(n1.n_name = 'FRANCE' AND n2.n_name = 'GERMANY')
			OR (n1.n_name = 'GERMANY' AND n2.n_name = 'FRANCE')
		)
		AND l_shipdate between date '1995-01-01' AND date '1996-12-31'
	) as shipping
GROUP BY
	supp_nation,
	cust_nation,
	l_year
ORDER BY
	supp_nation,
	cust_nation,
	l_year;

-- connect to the other worker node
\c - - - :worker_2_port

ALTER SEQUENCE pg_catalog.pg_dist_shardid_seq RESTART 1230000;

-- Change configuration to treat lineitem AND orders tables as large

SET citus.large_table_shard_count TO 2;

-- Query #7 from the TPC-H decision support benchmark

SELECT
	supp_nation,
	cust_nation,
	l_year,
	sum(volume) as revenue
FROM
	(
	SELECT
		n1.n_name as supp_nation,
		n2.n_name as cust_nation,
		extract(year FROM l_shipdate) as l_year,
		l_extendedprice * (1 - l_discount) as volume
	FROM
		supplier_mx,
		lineitem_mx,
		orders_mx,
		customer_mx,
		nation_mx n1,
		nation_mx n2
	WHERE
		s_suppkey = l_suppkey
		AND o_orderkey = l_orderkey
		AND c_custkey = o_custkey
		AND s_nationkey = n1.n_nationkey
		AND c_nationkey = n2.n_nationkey
		AND (
			(n1.n_name = 'FRANCE' AND n2.n_name = 'GERMANY')
			OR (n1.n_name = 'GERMANY' AND n2.n_name = 'FRANCE')
		)
		AND l_shipdate between date '1995-01-01' AND date '1996-12-31'
	) as shipping
GROUP BY
	supp_nation,
	cust_nation,
	l_year
ORDER BY
	supp_nation,
	cust_nation,
	l_year;
