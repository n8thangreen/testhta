
t_names <- c("without_drug", "with_drug")
n_treatments <- length(t_names)

s_names  <- c("Asymptomatic_disease", "Progressive_disease", "Dead")
n_states <- length(s_names)

n_cohort <- 1000
cycle <- 1

n_cycles <- 46
Initial_age <- 55
effect <- 0.5

cAsymp <- 500
cDeath <- 1000
cDrug <- 1000
cProg <- 3000
uAsymp <- 0.95
uProg <- 0.75
oDr <- 0.06
cDr <- 0.06
tpDcm <- 0.15
tpProg <- 0.01
tpDn <- 0.0379  # over 65 year old
effect <- 0.5

# cost of staying in state
state_c_matrix <-
  matrix(c(cAsymp, cProg, 0,
           cAsymp + cDrug, cProg, 0),
         byrow = TRUE,
         nrow = n_treatments,
         dimnames = list(t_names,
                         s_names))

# qaly when staying in state
state_q_matrix <-
  matrix(c(uAsymp, uProg, 0,
           uAsymp, uProg, 0),
         byrow = TRUE,
         nrow = n_treatments,
         dimnames = list(t_names,
                         s_names))

# cost of moving to a state
# same for both treatments
trans_c_matrix <-
  matrix(c(0, 0, 0,
           0, 0, cDeath,
           0, 0, 0),
         byrow = TRUE,
         nrow = n_states,
         dimnames = list(from = s_names,
                         to = s_names))

# Transition probabilities ---- 

# time-homogeneous
p_matrix <- array(data = c(1 - tpProg - tpDn, 0, 0,
                           tpProg, 1 - tpDcm - tpDn, 0,
                           tpDn, tpDcm + tpDn, 1,
                           1 - tpProg*(1-effect) - tpDn, 0, 0,
                           tpProg*(1-effect), 1 - tpDcm - tpDn, 0,
                           tpDn, tpDcm + tpDn, 1),
                  dim = c(n_states, n_states, n_treatments),
                  dimnames = list(from = s_names,
                                  to = s_names,
                                  t_names))

# Store population output for each cycle 

# state populations
pop <- array(data = NA,
             dim = c(n_states, n_cycles, n_treatments),
             dimnames = list(state = s_names,
                             cycle = NULL,
                             treatment = t_names))

pop["Asymptomatic_disease", cycle = 1, ] <- n_cohort
pop["Progressive_disease", cycle = 1, ] <- 0
pop["Dead", cycle = 1, ] <- 0

# _arrived_ state populations
trans <- array(data = NA,
               dim = c(n_states, n_cycles, n_treatments),
               dimnames = list(state = s_names,
                               cycle = NULL,
                               treatment = t_names))

trans[, cycle = 1, ] <- 0


# Sum costs and QALYs for each cycle at a time for each drug 

cycle_empty_array <-
  array(NA,
        dim = c(n_treatments, n_cycles),
        dimnames = list(treatment = t_names,
                        cycle = NULL))

cycle_state_costs <- cycle_trans_costs <- cycle_empty_array
cycle_costs <- cycle_QALYs <- cycle_empty_array
LE <- LYs <- cycle_empty_array    # life expectancy; life-years
cycle_QALE <- cycle_empty_array   # quality-adjusted life expectancy

total_costs <- setNames(c(NA, NA), t_names)
total_QALYs <- setNames(c(NA, NA), t_names)





## Run model ----

for (i in 1:n_treatments) {
  
  age <- Initial_age
  
  for (j in 2:n_cycles) {
    
    p_matrix <- p_matrix_cycle(p_matrix, age, j - 1)
    
    pop[, cycle = j, treatment = i] <-
      pop[, cycle = j - 1, treatment = i] %*% p_matrix[, , treatment = i]
    
    trans[, cycle = j, treatment = i] <-
      pop[, cycle = j - 1, treatment = i] %*% (trans_c_matrix * p_matrix[, , treatment = i])
    
    age <- age + 1
  }
  
  cycle_state_costs[i, ] <-
    (state_c_matrix[treatment = i, ] %*% pop[, , treatment = i]) * 1/(1 + cDr)^(1:n_cycles - 1)
  
  # discounting at _previous_ cycle
  cycle_trans_costs[i, ] <-
    (c(1,1,1) %*% trans[, , treatment = i]) * 1/(1 + cDr)^(1:n_cycles - 2)
  
  cycle_costs[i, ] <- cycle_state_costs[i, ] + cycle_trans_costs[i, ]
  
  # life expectancy
  LE[i, ] <- c(1,1,0) %*% pop[, , treatment = i]
  
  # life-years
  LYs[i, ] <- LE[i, ] * 1/(1 + oDr)^(1:n_cycles - 1)
  
  # quality-adjusted life expectancy
  cycle_QALE[i, ] <-
    state_q_matrix[treatment = i, ] %*% pop[, , treatment = i]
  
  # quality-adjusted life-years
  cycle_QALYs[i, ] <- cycle_QALE[i, ] * 1/(1 + oDr)^(1:n_cycles - 1)
  
  total_costs[i] <- sum(cycle_costs[treatment = i, -1])
  total_QALYs[i] <- sum(cycle_QALYs[treatment = i, -1])
}


## Plot results ----

# Incremental costs and QALYs of with_drug vs to without_drug
c_incr <- total_costs["with_drug"] - total_costs["without_drug"]
q_incr <- total_QALYs["with_drug"] - total_QALYs["without_drug"]

# Incremental cost-effectiveness ratio
ICER <- c_incr/q_incr

wtp <- 20000
plot(x = q_incr/n_cohort, y = c_incr/n_cohort,
     xlim = c(0, 2),
     ylim = c(0, 15e3),
     pch = 16, cex = 1.5,
     xlab = "QALY difference",
     ylab = paste0("Cost difference (", enc2utf8("\u00A3"), ")"),
     frame.plot = FALSE)
abline(a = 0, b = wtp) # willingness-to-pay threshold


png("figures/ceplane_point.png", width = 4, height = 4, units = "in", res = 640)
plot(x = q_incr/n_cohort, y = c_incr/n_cohort,
     xlim = c(0, 2),
     ylim = c(0, 15e3),
     pch = 16, cex = 1.5,
     xlab = "QALY difference",
     ylab = paste0("Cost difference (", enc2utf8("\u00A3"), ")"),
     frame.plot = FALSE)
abline(a = 0, b = wtp) # willingness-to-pay threshold
dev.off()


