#! /usr/bin/gawk

BEGIN { FS="x"; }

{
    s1 = $1 * $2;
    s2 = $2 * $3;
    s3 = $1 * $3;
    s1 < s2 ? min = s1 : min = s2;
    min < s3 ? min = min : min = s3;
    sum += 2 * (s1 + s2 + s3) + min;
}

END {
    printf("Total square feet of wrapping paper needed: %d \n", sum)
}
