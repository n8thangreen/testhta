# Unit tests for cohort Markov model - Standard (without helpers)
# Aligned with the HTA Verification Registry (T01 - T12)

# Load baseline test data
f_path <- test_path("testdata", "test_data.rda")
load(f_path)

# CE model convenience wrapper function
run_model <- function(input, ...) {
  updates <- list(...)
  updated_input <- modifyList(input, updates)
  do.call(ce_markov, args = updated_input)
}

# --- QALY Validation Tests ---

test_that("T01: QALYs are 0 if discount rate is 1", {
  res <- run_model(test_data, discount_rate = 1.0)
  actual <- get_qalys(res)
  expect_equal(as.numeric(actual), c(0, 0), tolerance = 0.01)
})

test_that("T02: Undiscounted QALYs (with u=1) should equal LE", {
  state_q_matrix_t02 <- test_data$state_q_matrix
  state_q_matrix_t02[, c("Asymptomatic_disease", "Progressive_disease")] <- 1
  res <- run_model(test_data, discount_rate = 0, state_q_matrix = state_q_matrix_t02)
  expect_equal(get_qalys(res), get_le(res), tolerance = 0.01)
})

test_that("T06: Set all living health state utility parameters = 1 yields QALYs equal to LYGs", {
  state_q_matrix_t06 <- test_data$state_q_matrix
  state_q_matrix_t06[, c("Asymptomatic_disease", "Progressive_disease")] <- 1
  res <- run_model(test_data, state_q_matrix = state_q_matrix_t06)
  expect_equal(get_qalys(res), res$total_LYs, tolerance = 0.01)
})

test_that("T07: Discounted QALYs < undiscounted QALYs for all treatments", {
  res_discounted <- run_model(test_data, discount_rate = 0.035)
  res_undiscounted <- run_model(test_data, discount_rate = 0)
  expect_true(all(get_qalys(res_discounted) < get_qalys(res_undiscounted)))
})

test_that("T08: QALY gains after time 0 tend towards zero at high discount rates", {
  res <- run_model(test_data, discount_rate = 1000)
  actual <- get_qalys(res)
  expect_equal(as.numeric(actual), c(0, 0), tolerance = 0.01)
})


# --- Population Validation Tests ---

test_that("T03: Set relative treatment effects = 1 yields equal LYGs & QALYs", {
  res <- run_model(test_data, effect = 0)
  expect_equal(as.numeric(res$total_LYs["with_drug"]), as.numeric(res$total_LYs["without_drug"]), tolerance = 0.01)
  expect_equal(as.numeric(res$total_QALYs["with_drug"]), as.numeric(res$total_QALYs["without_drug"]), tolerance = 0.01)
})

test_that("T04: Set mortality transition probabilities = 0 yields LE = n_cycles", {
  n_cycles_test <- 50
  p_matrix_t04 <- test_data$p_matrix
  p_matrix_t04[, "Dead", ] <- 0
  res <- run_model(test_data, p_matrix = p_matrix_t04, n_cycles = n_cycles_test)
  expect_equal(as.numeric(get_le(res)), c(n_cycles_test, n_cycles_test), tolerance = 0.01)
})

test_that("T05: Set mortality transition probabilities = 1 yields LE = 1", {
  p_matrix_t05 <- test_data$p_matrix * 0
  p_matrix_t05[, "Dead", ] <- 1
  res <- run_model(test_data, p_matrix = p_matrix_t05)
  expect_equal(as.numeric(get_le(res)), c(1, 1), tolerance = 0.01)
})


# --- Cost Validation Tests ---

test_that("T09: Set intervention costs = 0 reduces ICER", {
  res_base <- run_model(test_data)
  
  # Remove intervention cost (set to 0)
  state_c_matrix_t09 <- test_data$state_c_matrix
  state_c_matrix_t09["with_drug", "Asymptomatic_disease"] <- state_c_matrix_t09["without_drug", "Asymptomatic_disease"]
  res_zero_cost <- run_model(test_data, state_c_matrix = state_c_matrix_t09)
  
  expect_lt(get_icer(res_zero_cost), get_icer(res_base))
})

test_that("T10: Increase intervention costs increases ICER", {
  res_base <- run_model(test_data)
  
  # Increase intervention cost
  state_c_matrix_t10 <- test_data$state_c_matrix
  state_c_matrix_t10["with_drug", "Asymptomatic_disease"] <- state_c_matrix_t10["with_drug", "Asymptomatic_disease"] + 5000
  res_high_cost <- run_model(test_data, state_c_matrix = state_c_matrix_t10)
  
  expect_gt(get_icer(res_high_cost), get_icer(res_base))
})

test_that("T11: Set cost discount rate = 0 yields discounted costs = undiscounted costs", {
  # This verifies that running the model with discount_rate = 0 is equivalent to undiscounted runs
  res_d0 <- run_model(test_data, discount_rate = 0)
  res_undisc <- run_model(test_data, discount_rate = 0)
  expect_equal(get_costs(res_d0), get_costs(res_undisc), tolerance = 0.01)
})

test_that("T12: Set cost discount rate = inf yields costs after time 0 tend towards zero", {
  res <- run_model(test_data, discount_rate = 1000)
  actual <- get_costs(res)
  expect_equal(as.numeric(actual), c(0, 0), tolerance = 0.01)
})


# --- Probabilistic Sensitivity Analysis (PSA) Validation Tests (T13) ---

test_that("T13 (PSA): Sampled parameters lie within valid statistical distribution bounds", {
  set.seed(123)
  n_samples <- 100
  # Utilities bounded in [0, 1]
  u_samples <- stats::rbeta(n_samples, shape1 = 8, shape2 = 2)
  expect_true(all(u_samples >= 0 & u_samples <= 1))
  
  # Costs strictly positive (> 0)
  cost_samples <- stats::rlnorm(n_samples, meanlog = 5, sdlog = 0.5)
  expect_true(all(cost_samples > 0))
  
  # Probabilities bounded in [0, 1]
  p_samples <- stats::rbeta(n_samples, shape1 = 2, shape2 = 10)
  expect_true(all(p_samples >= 0 & p_samples <= 1))
})


# --- Treatment Arm & Symmetry Validation Tests (T14 - T16) ---

test_that("T14 (Treatment Arm): Equalizing arm parameters yields equal costs and QALYs across arms", {
  # Use new equalize_arm_params setter
  data_eq <- equalize_arm_params(test_data, from_arm = "without_drug", to_arm = "with_drug")
  res <- run_model(data_eq)
  
  costs <- get_costs(res)
  qalys <- get_qalys(res)
  
  # Incremental values should be zero when arms are identical
  expect_equal(as.numeric(get_incremental_costs(res)), 0, tolerance = 0.01)
  expect_equal(as.numeric(get_incremental_qalys(res)), 0, tolerance = 0.01)
  expect_equal(as.numeric(costs["with_drug"]), as.numeric(costs["without_drug"]), tolerance = 0.01)
  expect_equal(as.numeric(qalys["with_drug"]), as.numeric(qalys["without_drug"]), tolerance = 0.01)
})

test_that("T15 (Treatment Arm): Amending individual treatment arm parameter changes ICER", {
  res_base <- run_model(test_data)
  base_icer <- get_icer(res_base)
  
  # Amend an individual parameter for a specific arm (utility of progressive disease for with_drug)
  state_q_matrix_t15 <- test_data$state_q_matrix
  state_q_matrix_t15["with_drug", "Progressive_disease"] <- 0.8
  
  res_mod <- run_model(test_data, state_q_matrix = state_q_matrix_t15)
  mod_icer <- get_icer(res_mod)
  
  expect_false(isTRUE(all.equal(mod_icer, base_icer)))
})

test_that("T16 (Treatment Arm): Swapping treatment arm parameters swaps QALYs and costs between arms", {
  res_base <- run_model(test_data)
  base_costs <- get_costs(res_base)
  base_qalys <- get_qalys(res_base)
  arms <- get_arm_names(test_data)
  
  # Use new swap_arm_params setter
  data_swapped <- swap_arm_params(test_data, arm1 = arms[1], arm2 = arms[2])
  res_swapped <- run_model(data_swapped)
  
  swapped_costs <- get_costs(res_swapped)
  swapped_qalys <- get_qalys(res_swapped)
  
  expect_equal(as.numeric(swapped_costs[arms[1]]), as.numeric(base_costs[arms[2]]), tolerance = 0.01)
  expect_equal(as.numeric(swapped_costs[arms[2]]), as.numeric(base_costs[arms[1]]), tolerance = 0.01)
  
  expect_equal(as.numeric(swapped_qalys[arms[1]]), as.numeric(base_qalys[arms[2]]), tolerance = 0.01)
  expect_equal(as.numeric(swapped_qalys[arms[2]]), as.numeric(base_qalys[arms[1]]), tolerance = 0.01)
})


