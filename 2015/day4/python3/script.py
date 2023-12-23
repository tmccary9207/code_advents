#!/usr/bin/python3

from hashlib import md5
from sys import maxsize

"""
Check if hash starts with five zeros.
"""
def does_hash_start_with_five_zeros(hash: str) -> bool:
    """
    000001 results in True
    >>> does_hash_start_with_five_zeros("000001")
    True

    000011 results in False
    >>> does_hash_start_with_five_zeros("000011")
    False
    """
    return hash[0:5] == "00000"

"""
Gets the lowest possible positive number for the secret key that when hashed has five leading zeros.
"""
def get_lowest_number(secret_key: str) -> int:
    """
    abcdef results in 609043 being the lowest number.
    >>> get_lowest_number("abcdef")
    609043

    pqrstuv results in 1048970 being the lowest number.
    >>> get_lowest_number("pqrstuv")
    1048970
    """
    lowest_number = 0

    while lowest_number < maxsize:
        hash = md5(bytes(f"{secret_key}{lowest_number}", "utf-8")).hexdigest()
        if does_hash_start_with_five_zeros(hash):
            break
        lowest_number += 1

    return lowest_number

"""
Runs the script for day 4.
"""
def main():
    print(f"The lowest number that will create an adventcoin with our key is: {get_lowest_number('bgvyzdsv')}")

if __name__ == '__main__':
    main()
