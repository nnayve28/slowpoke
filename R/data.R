#' Load bundled Pokémon TCG dataset
#'
#' @return A tibble containing Pokémon TCG data.
#' @export
load_data <- function() {
  cache_path <- tools::R_user_dir("pokemonTCG", which = "cache")
  dir.create(cache_path, recursive = TRUE, showWarnings = FALSE)
  cache_file <- file.path(cache_path, "pokemon_cards.parquet")

  if (!file.exists(cache_file)) {
    df <- vroom::vroom(
      "https://www.dropbox.com/scl/fi/tnl4wcmgduu3bnmmllz2u/pokemon_cards.csv?rlkey=h7evg3hr4ckzqrxrzoy458ojs&st=uzrlktbc&dl=1",
      progress = FALSE,
      show_col_types = FALSE
    )
    arrow::write_parquet(df, cache_file)
  }

  arrow::read_parquet(cache_file)
}
