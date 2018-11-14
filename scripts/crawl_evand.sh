#!/bin/sh

get() {
	for i in {1..5}
	do
		http get $@ && break
		echo "Retrying $1..." >&2
	done
}

tmp=$(mktemp)
link="https://api.evand.com/events?page=1&include=city%2Cprices%2Corganization&fields=city_id%2Corganization_id%2Cname%2Cslug%2Cstart_date%2Cend_date%2Ccover%2Conline%2Cended%2Csoldout&per_page=20"
while [ "$link" != "null" ]:
do
	get $link > $tmp
	jq '.data | .[]' -rc $tmp
	link=$(jq '.meta | .pagination | .links | .next' -rc $tmp)
done

rm $tmp
