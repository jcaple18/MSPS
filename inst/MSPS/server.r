#' Shiny server.r file
#'
#'
#' This is the server.r file for the interface that utilizes all previous functions.
#' @name server
#' @export
#' runApp("MSPS")
#' shinyServer()

options(rgl.useNULL = TRUE) # run before rgl is loaded on headless devices
options(warn = -1) # suppress warnings

shinyServer(function(input, output, session) {
	# defines which modules to include
	# source(system.file("MSPS/Server", 'MSPS.r', package = "MSPS"), local = TRUE) # imports main code
	observeEvent(input$leftval, {
		toggle("LdpVal")
		toggle("LvrVal")
		toggle("LsrVal")
		if(input$leftval == FALSE) {
			suppressWarnings(rm("Ltest_score", "Lscore_pos", "Ltest_min", "Ltest_max", "Ltest_mean", "Ltest_sd", "Ltab1", envir = .GlobalEnv))
		} else{}
	})

	observeEvent(input$rightval, {
		toggle("RdpVal")
		toggle("RvrVal")
		toggle("RsrVal")
		if(input$rightval == FALSE) {
			suppressWarnings(rm("Rtest_score", "Rscore_pos", "Rtest_min", "Rtest_max", "Rtest_mean", "Rtest_sd", "Rtab1", envir = .GlobalEnv))
		} else{}
	})

	observeEvent({
		input$leftval
		input$rightval
		input$LdpVal
		input$LvrVal
		input$LsrVal
		input$RdpVal
		input$RvrVal
		input$RsrVal
	}, {
		if(input$leftval == FALSE) {
		} else{
			Ltest_score <<- sum(as.numeric(c(input$LdpVal,input$LvrVal,input$LsrVal)))
			Lscore_pos <<- which(msps_dat1[,1]==Ltest_score)
			Ltest_min <<- msps_dat1[Lscore_pos,2]
			Ltest_max <<- msps_dat1[Lscore_pos,3]
			Ltest_mean <<- msps_dat1[Lscore_pos,4]
			Ltest_sd <<- msps_dat1[Lscore_pos,5]
			Ltab1 <<- c(Ltest_score, paste0(Ltest_min, " - ", Ltest_max), Ltest_mean, Ltest_sd)
			Ltab2 <<- c(paste0(msps_dat2[which(msps_dat1[,1]==as.numeric(input$LdpVal)),1], " - ", msps_dat2[which(msps_dat1[,1]==as.numeric(input$LdpVal)),2]), paste0(msps_dat2[which(msps_dat1[,1]==as.numeric(input$LvrVal)),3], " - ", msps_dat2[which(msps_dat1[,1]==as.numeric(input$LvrVal)),4]), paste0(msps_dat2[which(msps_dat1[,1]==as.numeric(input$LsrVal)),5], " - ", msps_dat2[which(msps_dat1[,1]==as.numeric(input$LsrVal)),6]))
		}

		if(input$rightval == FALSE) {
		} else{
			Rtest_score <<- sum(as.numeric(c(input$RdpVal,input$RvrVal,input$RsrVal)))
			Rscore_pos <<- which(msps_dat1[,1]==Rtest_score)
			Rtest_min <<- msps_dat1[Rscore_pos,2]
			Rtest_max <<- msps_dat1[Rscore_pos,3]
			Rtest_mean <<- msps_dat1[Rscore_pos,4]
			Rtest_sd <<- msps_dat1[Rscore_pos,5]
			Rtab1 <<- c(Rtest_score, paste0(Rtest_min, " - ", Rtest_max), Rtest_mean, Rtest_sd)
			Rtab2 <<- c(paste0(msps_dat2[which(msps_dat1[,1]==as.numeric(input$RdpVal)),1], " - ", msps_dat2[which(msps_dat1[,1]==as.numeric(input$RdpVal)),2]), paste0(msps_dat2[which(msps_dat1[,1]==as.numeric(input$RvrVal)),3], " - ", msps_dat2[which(msps_dat1[,1]==as.numeric(input$RvrVal)),4]), paste0(msps_dat2[which(msps_dat1[,1]==as.numeric(input$RsrVal)),5], " - ", msps_dat2[which(msps_dat1[,1]==as.numeric(input$RsrVal)),6]))
		}

		if(input$leftval == FALSE) {
			outputTable1 <<- as.data.frame(cbind(tab_rnames[1:4], Rtab1))
			colnames(outputTable1) <<- c("", "Right")
			outputTable2 <<- as.data.frame(cbind(tab_rnames[5:7], Rtab2))
			colnames(outputTable2) <<- c("", "Right")
		} else if(input$rightval == FALSE) {
			outputTable1 <<- as.data.frame(cbind(tab_rnames[1:4], Ltab1))
			colnames(outputTable1) <<- c("", "Left")
			outputTable2 <<- as.data.frame(cbind(tab_rnames[5:7], Ltab2))
			colnames(outputTable2) <<- c("", "Left")
		} else if(input$leftval == TRUE && input$rightval == TRUE) {
			outputTable1 <<- as.data.frame(cbind(tab_rnames[1:4], Ltab1, Rtab1))
			colnames(outputTable1) <<- c("", "Left", "Right")
			outputTable2 <<- as.data.frame(cbind(tab_rnames[5:7], Ltab2, Rtab2))
			colnames(outputTable2) <<- c("", "Left", "Right")
		}
		output$compositeTable <- renderDataTable(outputTable1, options = list(aoColumnDefs = list(list(sClass = "alignCent", aTargets = c(list(1), list(2)))), dom = "T", searching = FALSE))
		output$componentTable <- renderDataTable(outputTable2, options = list(aoColumnDefs = list(list(sClass = "alignCent", aTargets = c(list(1), list(2)))), dom = "T", searching = FALSE))
		
		if(input$leftval == TRUE && input$rightval == TRUE) {
			if(as.numeric(input$LdpVal) == as.numeric(input$RdpVal)) {
				Bdp_summ <- c("Both the left and right dorsal margins are absent (score = 0). ",
											"There is a slight margin formed in the middle third of both the left and right dorsal borders (score = 1). ",
											"The dorsal margin extends along the entirety of both the left and right dorsal borders (score = 2). ",
											"The middle third of both the left and right dorsal demifaces exhibits filling in of the grooves and resorption of ridges forming the beginning of a plateau (score = 3). ",
											"The dorsal plateau extends over most of both the left and right dorsal demifaces, though still exhibit traces of billowing (score = 4). ",
											"Both the left and right dorsal plateaus are complete, appearing flat and slightly granulated in texture (score = 5). ")
				LRdp_summ <- Bdp_summ[which(msps_dat1[,1] == as.numeric(input$LdpVal))]
			} else {
				LRdp_summ <- paste0(Ldp_summ[which(msps_dat1[,1] == as.numeric(input$LdpVal))],
											 Rdp_summ[which(msps_dat1[,1] == as.numeric(input$RdpVal))])
			}
			if(input$LvrVal == input$RvrVal) {
				Bvr_summ <- c("There is no ventral beveling on either the left or right pubic symphyses (score = 0). ",
											"Both the left and right ventral demifaces exhibit beveling at the superior extremity of the ventral border (score = 1). ",
											"Both the left and right ventral borders exhibit beveling that extends inferiorly (score = 2). ",
											"Both the left and right ventral demifaces exhibit early formation of a ventral rampart (score = 3). ",
											"Both the left and right ventral demifaces exhibit extensive formation of a ventral rampart, with gaps still evident (score = 4). ",
											"Both the left and right ventral demifaces exhibit a complete ventral rampart along the border (score = 5). ")
				LRvr_summ <- Bvr_summ[which(msps_dat1[,1] == as.numeric(input$LvrVal))]
			} else {
				LRvr_summ <- paste0(Lvr_summ[which(msps_dat1[,1] == as.numeric(input$LvrVal))],
											 Rvr_summ[which(msps_dat1[,1] == as.numeric(input$RvrVal))])
			}
			if(input$LsrVal == input$RsrVal) {
				Bsr_summ <- c("The symphyseal rim is absent for both the left and right pubic symphyses (score = 0). ",
											"A partial dorsal symphyseal rim is present on both the left and right pubic symphyses (score = 1). ",
											"Both the left and right dorsal symphyseal rims are complete, with early development of the ventral rim (score = 2). ",
											"Both the left and right symphyseal rims are complete (score = 3). ",
											"Both the left and right symphyseal rims exhibit early signs of degradation (score = 4). ",
											"Both the left and right symphyseal rims exhibit extensive degradation and breakdown of the symphyseal face (score = 5). ")
				LRsr_summ <- Bsr_summ[which(msps_dat1[,1] == as.numeric(input$LsrVal))]
			} else {
				LRsr_summ <- paste0(Lsr_summ[which(msps_dat1[,1] == as.numeric(input$LsrVal))],
											 Rsr_summ[which(msps_dat1[,1] == as.numeric(input$RsrVal))])
			}
			if(Ltest_score == Rtest_score) {
				LRscore_summ <- paste0("The total component score each pubic symphysis is ",
															 Ltest_score,
															 ", for which the age range is ",
															 Ltest_min, " - ", Ltest_max,
															 " years old. ")
			} else {
				LRscore_summ <- paste0("The total component score for the left pubic symphysis is ",
															 Ltest_score,
															 ", for which the age range is ",
															 Ltest_min, " - ", Ltest_max,
															 " years old. The total component score for the right pubic symphysis is ",
															 Rtest_score,
															 ", for which the age range is ",
															 Rtest_min, " - ", Rtest_max,
															 " years old. ")
			}
		}

	output$summ <- renderText({
		if(input$leftval == FALSE) {
			paste0("The right pubic symphysis was scored in accordance with McKern and Stewart (1957) based on a sample of U.S. Korean War casualties. ",
					 Rdp_summ[which(msps_dat1[,1] == as.numeric(input$RdpVal))],
					 Rvr_summ[which(msps_dat1[,1] == as.numeric(input$RvrVal))],
					 Rsr_summ[which(msps_dat1[,1] == as.numeric(input$RsrVal))],
					 "The total component score for the right pubic symphysis is ",
					 Rtest_score,
					 ", for which the age range is ",
					 Rtest_min, " - ", Rtest_max,
					 " years old (mean age = ",
					 Rtest_mean,
					 " years; 2 standard deviations = ",
					 Rtest_sd,
					 " years). "
			)
		}else if(input$rightval == FALSE) {
			paste0("The left pubic symphysis was scored in accordance with McKern and Stewart (1957) based on a sample of U.S. Korean War casualties. ",
					 Ldp_summ[which(msps_dat1[,1] == as.numeric(input$LdpVal))],
					 Lvr_summ[which(msps_dat1[,1] == as.numeric(input$LvrVal))],
					 Lsr_summ[which(msps_dat1[,1] == as.numeric(input$LsrVal))],
					 "The total component score for the left pubic symphysis is ",
					 Ltest_score,
					 ", for which the age range is ",
					 Ltest_min, " - ", Ltest_max,
					 " years old (mean age = ",
					 Ltest_mean,
					 " years; 2 standard deviations = ",
					 Ltest_sd,
					 " years). "
			)
		}else if(input$leftval == TRUE && input$rightval == TRUE) {
			paste0("The left and right pubic symphyses were scored in accordance with McKern and Stewart (1957) based on a sample of U.S. Korean War casualties. ",
					 LRdp_summ,
					 LRvr_summ,
					 LRsr_summ,
					 LRscore_summ
			)
		}
		})
	})

	observeEvent(input$scan_dp_comp, {
		output$scan_dp <- renderRglwidget({
			clear3d()
			bg3d("white")
			if(input$scan_dp_comp == "dpSTL_0") {
				text3d(x = -10, cex = 0.9, texts = "No cast exists for this score. An example will be added at a later date.")
			} else {
				rgl.triangles(get(input$scan_dp_comp), col = "grey70", ambient = "black", specular = "grey5", emission = "black", shininess = 128)
				rgl.viewpoint(theta = 0, phi = -90, fov = 0)
			}
			rglwidget()
		})
	})

	observeEvent(input$scan_vr_comp, {
		output$scan_vr <- renderRglwidget({
			clear3d()
			bg3d("white")
			if(input$scan_vr_comp == "vrSTL_0") {
				text3d(x = -10, cex = 0.9, texts = "No cast exists for this score. An example will be added at a later date.")
			} else {
				rgl.triangles(get(input$scan_vr_comp), col = "grey70", ambient = "black", specular = "grey5", emission = "black", shininess = 128)
				rgl.viewpoint(theta = 0, phi = -90, fov = 0)
			}
			rglwidget()
		})
	})

	observeEvent(input$scan_sr_comp, {
		output$scan_sr <- renderRglwidget({
			clear3d()
			bg3d("white")
			if(input$scan_sr_comp == "srSTL_0") {
				text3d(x = -10, cex = 0.9, texts = "No cast exists for this score. An example will be added at a later date.")
			} else {
				rgl.triangles(get(input$scan_sr_comp), col = "grey70", ambient = "black", specular = "grey5", emission = "black", shininess = 128)
				rgl.viewpoint(theta = 0, phi = -90, fov = 0)
			}
			rglwidget()
		})
	})

	observe({
		if (input$close > 0) stopApp() # stop shiny
	})
})
