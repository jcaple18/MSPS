#' Shiny global.r file
#' 
#' This is the global.r file that loads all data prior to running app.
#' @name global
#' @export

options(shiny.maxRequestSize=200*1024^2) #200MB file size limit

msps_dat1 <- cbind(0:15, c(NA,17,17,18,18,18,20,20,22,22,23,23,23,23,29,36), c(17,20,20,21,23,23,24,24,28,28,28,39,39,39,NA,NA), c(17.29,19.04,19.04,19.79,20.84,20.84,22.42,22.42,24.14,24.14,26.05,29.18,29.18,29.18,35.84,41), 2*c(0.49,0.79,0.79,0.85,1.13,1.13,0.99,0.99,1.93,1.93,1.87,3.33,3.33,3.33,3.89,6.22))
colnames(msps_dat1) <- c("Total Score", "Min", "Max", "Mean", "SD")

msps_dat2 <- cbind(c(17,18,18,18,19,23), c(18,21,21,24,30,NA), c(17,19,19,21,22,24), c(22,23,24,28,39,NA), c(17,21,24,24,29,31), c(24,28,39,39,NA,NA))
colnames(msps_dat2) <- c("I_Min", "I_Max", "II_Min", "II_Max", "III_Min", "III_Max")

Ldp_summ <- c("The left dorsal margin is absent (score = 0). ",
             "There is a slight margin formed in the middle third of the left dorsal border (score = 1). ",
             "The dorsal margin extends along the entire left dorsal border (score = 2). ",
             "The middle third of the left dorsal demiface exhibits filling in of the grooves and resorption of ridges forming the beginning of a plateau (score = 3). ",
             "The dorsal plateau extends over most of the left dorsal demiface, though still exhibits traces of billowing (score = 4). ",
             "The left dorsal plateau is complete, appearing flat and slightly granulated in texture (score = 5). ")
Lvr_summ <- c("There is no ventral beveling on the left pubic symphysis (score = 0). ",
             "The left ventral demiface exhibits beveling at the superior extremity of the ventral border (score = 1). ",
             "The left ventral border exhibits beveling that extends inferiorly (score = 2). ",
             "The left ventral demiface exhibits early formation of a ventral rampart (score = 3). ",
             "The left ventral demiface exhibits extensive formation of a ventral rampart, with gaps still evident (score = 4). ",
             "The left ventral demiface exhibits a complete ventral rampart along the border (score = 5). ")
Lsr_summ <- c("The left symphyseal rim is absent (score = 0). ",
             "A partial dorsal symphyseal rim is present on the left pubic symphysis (score = 1). ",
             "The left dorsal symphyseal rim is complete, with early development of the ventral rim (score = 2). ",
             "The left symphyseal rim is complete (score = 3). ",
             "The left symphyseal rim exhibits early signs of degradation (score = 4). ",
             "The left symphyseal rim exhibits extensive degradation and breakdown of the symphyseal face (score = 5). ")

Rdp_summ <- c("The right dorsal margin is absent (score = 0). ",
             "There is a slight margin formed in the middle third of the right dorsal border (score = 1). ",
             "The dorsal margin extends along the entire right dorsal border (score = 2). ",
             "The middle third of the right dorsal demiface exhibits filling in of the grooves and resorption of ridges forming the beginning of a plateau (score = 3). ",
             "The dorsal plateau extends over most of the right dorsal demiface, though still exhibits traces of billowing (score = 4). ",
             "The right dorsal plateau is complete, appearing flat and slightly granulated in texture (score = 5). ")
Rvr_summ <- c("There is no ventral beveling on the right pubic symphysis (score = 0). ",
             "The right ventral demiface exhibits beveling at the superior extremity of the ventral border (score = 1). ",
             "The right ventral border exhibits beveling that extends inferiorly (score = 2). ",
             "The right ventral demiface exhibits early formation of a ventral rampart (score = 3). ",
             "The right ventral demiface exhibits extensive formation of a ventral rampart, with gaps still evident (score = 4). ",
             "The right ventral demiface exhibits a complete ventral rampart along the border (score = 5). ")
Rsr_summ <- c("The right symphyseal rim is absent (score = 0). ",
             "A partial dorsal symphyseal rim is present on the right pubic symphysis (score = 1). ",
             "The right dorsal symphyseal rim is complete, with early development of the ventral rim (score = 2). ",
             "The right symphyseal rim is complete (score = 3). ",
             "The right symphyseal rim exhibits early signs of degradation (score = 4). ",
             "The right symphyseal rim exhibits extensive degradation and breakdown of the symphyseal face (score = 5). ")

tab_rnames <- c("Total score:", "Age range (years):", "Mean age (years):", "2 SD (years):", "(I) Dorsal Plateau:", "(II) Ventral Rampart:", "(III) Symphyseal Rim:")


##

STL_names <- c("dpSTL_", "vrSTL_", "srSTL_")
for(i in STL_names) {
	for(j in 1:5) {
		tempSTL <- readSTL(system.file("extdata", paste0(i, j, ".stl"), package = "MSPS"), ascii = FALSE, plot = FALSE)
		assign(paste0(i, j), tempSTL, envir = .GlobalEnv)
	}
}
