import matplotlib.pyplot as plt

i = {}
seq = {}
par = {}
speedup = {}

vec = 0
with open("results.csv") as f:
  for line in f.readlines():
    if line.startswith(" Moyenne"):
      continue

    i_k,seq_k,par_k,speedup_k,cores_k,_=map(float, line.split(" ")[:-1])
    cores_k=int(cores_k)

    if cores_k not in i:
      i[cores_k]=[]
      seq[cores_k]=[]
      par[cores_k]=[]
      speedup[cores_k]=[]

    i[cores_k].append(i_k)
    seq[cores_k].append(seq_k)
    par[cores_k].append(par_k)
    speedup[cores_k].append(speedup_k)

fig, axes = plt.subplots(nrows=1, ncols=2)

axes[1].set_title("Temps")
for core in i:
  if core==2:
    axes[1].plot(i[core], seq[core], label="Séquentiel")

  axes[1].plot(i[core], par[core], label=f"{core} coeurs")

axes[0].set_title("Speedup")
for core in i:
  if core==2:
    axes[0].plot(i[core], [1]*len(i[core]), label=f"Séquentiel")

  axes[0].plot(i[core], speedup[core], label=f"{core} coeurs")

plt.legend()

plt.tight_layout()

# Show the plot
plt.show()
plt.savefig("graph.png")