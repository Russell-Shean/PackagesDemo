#' @title Average Score by Cohort
#' @description This function takes a line level dataset of patient data and
#'              calculates the average score for each cohort
#' @param df
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[dplyr]{group_by}}, \code{\link[dplyr]{summarise}}
#' @rdname avgScoreByCohort
#' @export
#' @importFrom dplyr group_by summarise
avgScoreByCohort <- function(df){

  output_df <- df |>
    dplyr::group_by(cohort) |>
    dplyr::summarise(score = mean(score, na.rm = TRUE)) |>

    # convert to a data.frame so that tests pass and
    # more importantly so that class is predictible and same as
    # input
    as.data.frame()

  output_df
}
