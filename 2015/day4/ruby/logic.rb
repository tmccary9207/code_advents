require 'digest'

##
# Check if hash starts with five zeros.
def does_hash_start_with_five_zeros(hash)
  hash[0..4] == "00000"
end

##
# Gets the lowest possible positive number for the secret key that when hashed has five leading zeros.
def get_lowest_number(secret_key)
  lowest_number = 0

  # NOTE: I would use some kind of numeric constant for a maximum number
  # but Ruby doesn't seem to have one. Instead it'll turn them into Bignums
  # which are unlimited. In practice putting a hard cap on the maximum is safer.
  while true do
    hash = Digest::MD5.hexdigest("#{secret_key}#{lowest_number}")

    if does_hash_start_with_five_zeros(hash)
      break
    end

    lowest_number += 1
  end

  lowest_number
end
