#! /usr/bin/gawk

function has_duplicate_letter_pair(input) {
    prev = substr(input, 0, 1);
    for (i=1; ++i <= length(input);) {
        curr = substr(input, i, 1);
        if (prev == curr) {
            return 1;
        }
        prev = curr;
    }
    return 0;
}

{
    if (($0 ~ /[aeiou].*[aeiou].*[aeiou]/) &&
        ($0 !~ /(ab)|(cd)|(pq)|(xy)/) &&
        has_duplicate_letter_pair($0)) {
        COUNT++;
    }
}

END {
    print(COUNT" nice strings.");
}
