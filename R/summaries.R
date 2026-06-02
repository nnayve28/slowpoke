#' Count card rarity by grouping variable
#'
#' @param grouping_var A column to group by (unquoted).
#' @param dat Optional pre-loaded tibble from load_data(). Loaded automatically if NULL.
#' @return A tibble with counts of each rarity by group.
#' @importFrom dplyr count group_by mutate
#' @importFrom tidyr pivot_wider
#' @export
rarity_by_release <- function(grouping_var, dat = NULL) {
  if (is.null(dat)) dat <- load_data()
  dat |>
    dplyr::count({{ grouping_var }}, rarity) |>
    dplyr::group_by({{ grouping_var }}) |>
    dplyr::mutate(pct = n / sum(n)) |>
    tidyr::pivot_wider(
      names_from = rarity,
      values_from = pct
    )
}
