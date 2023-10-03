import matplotlib.pyplot as plt

# tuple vec / novec
i = ([],[])
seq = ([],[])
par = ([],[])

vec = 0
with open("results.csv") as f:
  for line in f.readlines():
    if line.startswith("Avec"):
      vec=0
      continue
    elif line.startswith("Sans"):
      vec=1
      continue
    i_k,seq_k,par_k=map(float, line.split(","))
    i[vec].append(i_k)
    seq[vec].append(seq_k)
    par[vec].append(par_k)

plt.plot(i[0], seq[0], label="Avec vectorisation, séquentiel")
plt.plot(i[0], par[0], label="Avec vectorisation, parallèle")
plt.plot(i[1], seq[1], label="Sans vectorisation, séquentiel")
plt.plot(i[1], par[1], label="Sans vectorisation, parallèle")

plt.legend()

plt.tight_layout()

plt.savefig("graph.png")