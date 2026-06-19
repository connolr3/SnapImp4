# Your vector
my_vector <- c(
  -0.22, 0.53, 0.52,
  0.96, 0.03, -0.82,
  0.78, 0.98, 1.1,
  1.17, 0.85, -0.37,
  0, 0.48, 0.86,
  1.39, -0.13, -0.16,
  1.57, 1.05, 1.05,
  1.23, 0.74, -0.55,
  0.63, 0.98, 1.45,
  1.21, 0.98, 0.67,
  1.47, 0.2, -0.19
)

# Create boxplot
boxplot(
  my_vector,
  main = "Distribution of Adjustments",
  ylab = "Metres",
  col = "skyblue",
  border = "black"
)


my_vector2 <- c(
  1.179549,
  1.011617,
  0.55,
  1.376831,
  1.21799,
  2.923427,
  1.173402,
  1.711069,
  0.98,
  0.78,
  1.33
)


# Create boxplot
boxplot(
  my_vector2,
  main = "Distribution of IPD",
  ylab = "Metres",
  col = "skyblue",
  border = "black"
)

