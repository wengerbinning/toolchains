#

# Global Variable
s/^\s*([a-zA-Z0-9_-]*)\s*=\s*(.*)/\1=\2/p
#Export Enviroment
s/^\s*export\s*([a-zA-Z0-9*_-]*)\s*=\s*(.*)/export \1=\2/p
# Append Environment
s/^\s*append\s*([a-zA-Z0-9_-]*)\s*=\s*(.*)/export \1=\2:$\1/p

