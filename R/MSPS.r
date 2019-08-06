#' @export

MSPS <- function() {
	# library(shiny)
	appDir <- system.file("MSPS", package = "MSPS")
	if (appDir == "") {
		stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
	}
	shiny::runApp(appDir, launch.browser = TRUE)
}
