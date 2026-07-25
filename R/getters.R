# getters

#' @title Getter for QALYs
#' @param res A list of results returned by ce_markov.
#' @return A numeric vector of total QALYs by treatment.
#' @examples
#' data(test_data)
#' res <- run_model(test_data)
#' get_qalys(res)
#' @export
get_qalys <- function(res) {
  res$total_QALYs
}

#' @title Getter for costs
#' @param res A list of results returned by ce_markov.
#' @return A numeric vector of total costs by treatment.
#' @examples
#' data(test_data)
#' res <- run_model(test_data)
#' get_costs(res)
#' @export 
get_costs <- function(res) {
  res$total_costs
}

#' @title Getter for life expectancy (LE)
#' @param res A list of results returned by ce_markov.
#' @return A numeric vector of total life expectancy by treatment.
#' @examples
#' data(test_data)
#' res <- run_model(test_data)
#' get_le(res)
#' @export
get_le <- function(res) {
  res$total_LE
}

#' @title Getter for ICER
#' @param res A list of results returned by ce_markov.
#' @return A numeric value representing the incremental cost-effectiveness ratio (ICER).
#' @examples
#' data(test_data)
#' res <- run_model(test_data)
#' get_icer(res)
#' @export
get_icer <- function(res) {
  c_incr <- res$total_costs["with_drug"] - res$total_costs["without_drug"]
  q_incr <- res$total_QALYs["with_drug"] - res$total_QALYs["without_drug"]
  as.numeric(c_incr / q_incr)
}

#' @title Getter for incremental costs
#' @param res A list of results returned by ce_markov.
#' @return A numeric value of incremental cost (arm 2 minus arm 1).
#' @examples
#' data(test_data)
#' res <- run_model(test_data)
#' get_incremental_costs(res)
#' @export
get_incremental_costs <- function(res) {
  res$total_costs["with_drug"] - res$total_costs["without_drug"]
}

#' @title Getter for incremental QALYs
#' @param res A list of results returned by ce_markov.
#' @return A numeric value of incremental QALYs (arm 2 minus arm 1).
#' @examples
#' data(test_data)
#' res <- run_model(test_data)
#' get_incremental_qalys(res)
#' @export
get_incremental_qalys <- function(res) {
  res$total_QALYs["with_drug"] - res$total_QALYs["without_drug"]
}

#' @title Getter for treatment arm names
#' @param input A list of parameters or model results.
#' @return A character vector of treatment arm names.
#' @examples
#' data(test_data)
#' get_arm_names(test_data)
#' @export
get_arm_names <- function(input) {
  if (!is.null(input$t_names)) {
    return(input$t_names)
  } else if (!is.null(input$total_costs)) {
    return(names(input$total_costs))
  } else {
    stop("Treatment arm names not found in input.")
  }
}

#' @title Getter for state costs
#' @param input A list of model parameters.
#' @param arm Optional treatment arm name (character) or index.
#' @return A vector of state costs for the specified arm, or the full cost matrix if arm is NULL.
#' @examples
#' data(test_data)
#' get_state_costs(test_data, "without_drug")
#' @export
get_state_costs <- function(input, arm = NULL) {
  if (is.null(arm)) {
    input$state_c_matrix
  } else {
    input$state_c_matrix[arm, ]
  }
}

#' @title Getter for state utilities
#' @param input A list of model parameters.
#' @param arm Optional treatment arm name (character) or index.
#' @return A vector of state utilities for the specified arm, or the full utility matrix if arm is NULL.
#' @examples
#' data(test_data)
#' get_state_utilities(test_data, "without_drug")
#' @export
get_state_utilities <- function(input, arm = NULL) {
  if (is.null(arm)) {
    input$state_q_matrix
  } else {
    input$state_q_matrix[arm, ]
  }
}

#' @title Getter for transition probability matrix
#' @param input A list of model parameters.
#' @param arm Optional treatment arm name (character) or index.
#' @return A matrix of transition probabilities for the specified arm, or the 3D array if arm is NULL.
#' @examples
#' data(test_data)
#' get_transition_matrix(test_data, "without_drug")
#' @export
get_transition_matrix <- function(input, arm = NULL) {
  if (is.null(arm)) {
    input$p_matrix
  } else {
    input$p_matrix[, , arm]
  }
}


