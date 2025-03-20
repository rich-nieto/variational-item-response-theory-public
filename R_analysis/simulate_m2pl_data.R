library(mirt)

# Define parameters
num_examinees <- 3000
num_items <- 60
num_factors <- 3  # M2PL with 3 latent traits

# Create a discrimination matrix (a_matrix)
# Each item loads on only one of the three factors
a_matrix <- matrix(0, nrow=num_items, ncol=num_factors)
for (i in 1:num_items) {
  a_matrix[i, ((i - 1) %/% 20) + 1] <- runif(1, 0.5, 2.5)  # Discrimination from U(0.5,2.5)
}

# Generate difficulty parameters (b)
b_params <- rnorm(num_items, mean=0, sd=1)  # Normally distributed difficulty

# Generate Theta (Examinee ability) from a standard normal distribution
theta <- matrix(rnorm(num_examinees * num_factors, mean=0, sd=1), nrow=num_examinees)

# Simulate response data
sim_responses <- simdata(a=a_matrix, d=b_params, Theta=theta, itemtype="2PL")

# View first few rows
head(sim_responses)

# Save the data to CSV if needed
write.csv(sim_responses, "../data/Rmirt_2pl_simulation_3000person_60item_3ability.csv", row.names=FALSE)
write.csv(a_matrix, "../data/Rmirt_2pl_simulation_3000person_60item_3ability_disc.csv", row.names=FALSE)
write.csv(b_params, "../data/Rmirt_2pl_simulation_3000person_60item_3ability_diff.csv", row.names=FALSE)
write.csv(theta, "../data/Rmirt_2pl_simulation_3000person_60item_3ability_ability.csv", row.names=FALSE)
