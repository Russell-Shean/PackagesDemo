#' Title
#'
#' @param df
#'
#' @returns
#' @export
#'
#' @examples
calculate_new_vars <- function(df) {

  if(any(is.na(df$psa))){ stop("psa can't have NA values")}

  #if()

    new_df <- df |>
      dplyr::mutate(# Calculate nccn
        nccn = dplyr::case_when(psa < 10 & gleason <= 6 & t_stage %in% c("T1","T2a") ~ "Low",
                                psa > 20 | gleason >= 8 | t_stage %in% c("T3a","T3b","T4") ~ "High",
                                is.na(psa) | is.na(gleason) | is.na(t_stage) ~ "Unclassified",
                                .default = "Intermediate"))



        new_df

}
