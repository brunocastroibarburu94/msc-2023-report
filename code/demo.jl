Base.:+(a::Money{A}, b::Money{B}) where {A,B} = A==B ? Money{A}(a.value + b.value) : Wallet(Dict(A=>a.value,B=>b.value)) # Not Type-stable.