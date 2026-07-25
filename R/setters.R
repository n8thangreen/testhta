#' Set discount rate
#'
#' @param input A list of model parameters.
#' @param discount_rate The discount rate to set (numeric).
#' @return The modified list of parameters.
#' @examples
#' data(test_data)
#' updated <- set_discount_rate(test_data, 0.05)
#' @export
set_discount_rate <- function(input, discount_rate) {
  if (!is.list(input)) {
    stop("input must be a list")
  }
  if (!is.numeric(discount_rate)) {
    stop("discount_rate must be numeric")
  }
  input$discount_rate <- discount_rate
  input
}

#' Set costs for a scenario
#'
#' @param input A list of model parameters.
#' @param scenario The scenario name (character) or index (numeric).
#' @param values A vector of cost values for health states.
#' @return The modified list of parameters.
#' @examples
#' data(test_data)
#' updated <- set_costs(test_data, "without_drug", c(100, 200, 0))
#' @export
set_costs <- function(input, scenario, values) {
  if (!is.list(input)) {
    stop("input must be a list")
  }
  input$state_c_matrix[scenario, ] <- values
  input
}

#' Set transition probabilities for a scenario
#'
#' @param input A list of model parameters.
#' @param scenario The scenario name (character) or index (numeric).
#' @param values A matrix of transition probabilities.
#' @return The modified list of parameters.
#' @examples
#' data(test_data)
#' mat <- test_data$p_matrix[, , "without_drug"]
#' updated <- set_p_matrix(test_data, "without_drug", mat)
#' @export
set_p_matrix <- function(input, scenario, values) {
  if (!is.list(input)) {
    stop("input must be a list")
  }
  input$p_matrix[, , scenario] <- values
  input
}

#' Set utilities for a scenario
#'
#' @param input A list of model parameters.
#' @param scenario The scenario name (character) or index (numeric).
#' @param values A vector of utility values for health states.
#' @return The modified list of parameters.
#' @examples
#' data(test_data)
#' updated <- set_utilities(test_data, "without_drug", c(0.8, 0.5, 0))
#' @export
set_utilities <- function(input, scenario, values) {
  if (!is.list(input)) {
    stop("input must be a list")
  }
  input$state_q_matrix[scenario, ] <- values
  input
}

#' Set time horizon
#'
#' @param input A list of model parameters.
#' @param scenario The scenario name or index, or values if scenario is omitted.
#' @param values The number of cycles (numeric).
#' @return The modified list of parameters.
#' @examples
#' data(test_data)
#' updated <- set_time_horizon(test_data, 10)
#' @export
set_time_horizon <- function(input, scenario, values) {
  if (!is.list(input)) {
    stop("input must be a list")
  }
  if (missing(values)) {
    input$n_cycles <- scenario
  } else {
    input$n_cycles <- values
  }
  input
}

#' Equalize treatment-specific parameters across arms
#'
#' @param input A list of model parameters.
#' @param from_arm The source arm name or index.
#' @param to_arm The target arm name or index.
#' @return The modified list of parameters with identical inputs for both arms.
#' @examples
#' data(test_data)
#' updated <- equalize_arm_params(test_data, "without_drug", "with_drug")
#' @export
equalize_arm_params <- function(input, from_arm = "without_drug", to_arm = "with_drug") {
  if (!is.list(input)) {
    stop("input must be a list")
  }
  input$state_c_matrix[to_arm, ] <- input$state_c_matrix[from_arm, ]
  input$state_q_matrix[to_arm, ] <- input$state_q_matrix[from_arm, ]
  input$p_matrix[, , to_arm] <- input$p_matrix[, , from_arm]
  input
}

#' Swap treatment-specific parameters between two arms
#'
#' @param input A list of model parameters.
#' @param arm1 Name or index of the first treatment arm.
#' @param arm2 Name or index of the second treatment arm.
#' @return The modified list of parameters with swapped inputs.
#' @examples
#' data(test_data)
#' updated <- swap_arm_params(test_data, "without_drug", "with_drug")
#' @export
swap_arm_params <- function(input, arm1 = "without_drug", arm2 = "with_drug") {
  if (!is.list(input)) {
    stop("input must be a list")
  }
  # Swap costs
  input$state_c_matrix[c(arm1, arm2), ] <- input$state_c_matrix[c(arm2, arm1), ]
  
  # Swap utilities
  input$state_q_matrix[c(arm1, arm2), ] <- input$state_q_matrix[c(arm2, arm1), ]
  
  # Swap transition matrices
  p_temp <- input$p_matrix[, , arm1]
  input$p_matrix[, , arm1] <- input$p_matrix[, , arm2]
  input$p_matrix[, , arm2] <- p_temp
  
  input
}

