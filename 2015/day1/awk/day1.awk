#! /usr/bin/gawk

{
    count = gsub(/\(/, "") - gsub(/\)/, "");
}

END {
  printf("Santa ends up on floor: %d\n", count);
}
