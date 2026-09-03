# 3A

# Reconstruct the data

concentration = c(1, 3.2, 10, 32, 100, 500)
controlresp = c(.7, 2.5, 7.5, 9.9, 8.9, NA)
inhibitresp = c(NA, 1.4, 2.9, 5.1, 6.5, 5.3)

legend.text = c("Control", "+Inhibitor")

# Control

plot (concentration, controlresp,
  xlab = expression("Concentration"~(mu~"M")),
  ylab = "Response",
  xlim = c(1, 500),
  ylim = c(-0.5, 11),
  log = "x",
  type = "l",
  main = "Control / +Inhibitor Experiment"
)

legend (80, 2, legend.text, 
  lty = 1,
  lwd = 8,
  col = c("red", "purple")
)
legend (80, 2, legend.text,
  lty = 1,
  lwd = 4,
  col = c("orange", "blue")
)

for (i in 1:(length(concentration)-1))
  boxplot (rnorm(100, controlresp[i], .3), 
    col =  "orange",
    border = "red",
    at = concentration[i],
    add = TRUE)

# Inhibitor

lines (concentration, inhibitresp)

for (i in 2:length(concentration))
  boxplot (rnorm(100, inhibitresp[i], .3), 
    col =  "blue",
    border = "purple",
    at = concentration[i],
    add = TRUE)



# 3B

# Reconstruct the data

colnames = c("GABA", "Glycine", "Glutamate", "Aspartate", "Alanine")
releaselow = c(750, 290, 230, 180, 105)
releasepost = c(115, 105, 95, 88, 90)

acid = data.frame(rbind(releaselow, releasepost), 
  row.names = c("Low Na+", "Post-control")
)
names(acid) = colnames

# Create barchart

barplot(as.matrix(acid), 
  beside = TRUE, 
  col = c("lightblue", "mistyrose"), 
  ylim = c(0, 800),
  yaxp = c(0, 800, 8),
  ylab = "Release (pmol / mg wet wt / 3 min)",
  legend = rownames(acid),
  names.arg = c(colnames[1:4], expression(beta~"-Alanine"))
) 

title(main = expression("Effect of low NA"^"+" ~ "on high K"^"+" ~ "-evoked amino acid release"), 
  font.main = 4,
  sub = "Pre-control = 100",
  col.sub = "darkgreen"
)

lines(c(0, 15), c(100, 100), 
  col = "darkgreen",
  lty = 2
)

# overplot barchart so it appears above the line

barplot(as.matrix(acid), 
  beside = TRUE, 
  add = TRUE,
  col = c("lightblue", "mistyrose"), 
  ylim = c(0, 800),
  yaxp = c(0, 800, 8),
  ylab = "Release (pmol / mg wet wt / 3 min)",
  legend = rownames(acid),
  names.arg = c(colnames[1:4], expression(beta~"-Alanine"))
) 

