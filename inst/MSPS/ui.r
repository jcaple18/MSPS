#' Shiny ui.r file
#'
#'
#' This is the ui.r file for the interface that utilizes all previous functions.
#' @name ui
#' @export
#' runApp("MSPS")

options(warn = -1) # suppress warnings

shinyUI(
	fluidPage(
		tagList(
			navbarPage(theme = shinytheme("sandstone"),
				div("Pubic Symphysis Age Estimation", style = "padding: 0px 0px; height: '100%'; margin-top: 0px"),
				windowTitle = "PS Age Estimation",
				tabPanel("Components",
					sidebarLayout(
						sidebarPanel(
							div("Data Input", style = "font-size: 20px; font-weight: bold;"),
							tags$head(tags$style(HTML("hr {border-top: 1px solid #C0C0C0;}"))),
							hr(),
							div(materialSwitch("leftval", "Left", TRUE), style = "font-size: 15px; font-weight: bold;"),
							shinyjs::useShinyjs(),
							hidden(pickerInput("LdpVal", "(I) Dorsal Plateau", choices = 1:5), pickerInput("LvrVal", "(II) Ventral Rampart", choices = 1:5), pickerInput("LsrVal", "(III) Symphyseal Rim", choices = 1:5)),
							uiOutput("leftnum"),
							hr(),
							div(materialSwitch("rightval", "Right", TRUE), style = "font-size: 15px; font-weight: bold;"),
							shinyjs::useShinyjs(),
							hidden(pickerInput("RdpVal", "(I) Dorsal Plateau", choices = 1:5), pickerInput("RvrVal", "(II) Ventral Rampart", choices = 1:5), pickerInput("RsrVal", "(III) Symphyseal Rim", choices = 1:5)),
							uiOutput("rightnum"),
							hr(),
							helpText("Once data are entered, proceed to Output tab.")
						),
						mainPanel(
							br(),
							div("Reference Casts", style = "font-size: 20px; font-weight: bold;"),
							br(),
							tabsetPanel(type = "tabs",
								tabPanel("(I) Dorsal Plateau",
									fluidRow(
										column(width = 6, offset = 0, style = 'padding:0px;',
											rglwidgetOutput("scan_dp", width = "512px", height = "512px")
										),
										column(width = 6, offset = 0, style = 'padding:0px;',
											br(),
											div("Dorsal Plateau Scores:", style = "font-size: 15px; font-weight: bold;"),
											hr(),
											radioButtons("scan_dp_comp", "", c(
												"1: A slight margin formation first appears in the middle third of the dorsal border." = "dpSTL_1",
												"2: The dorsal margin extends along the entire dorsal border." = "dpSTL_2",
												"3: Filling in of grooves and resorption of ridges to form a beginning plateau in the middle third of the dorsal demiface." = "dpSTL_3",
												"4: The plateau, still exhibiting vestiges of billowing, extends over most of the dorsal demi-face." = "dpSTL_4",
												"5: Billowing disappears completely and the surface of the entire demi-face becomes flat and slightly granulated in texture." = "dpSTL_5")
											),
											hr(),
											helpText("NOTE: A score of zero is assigned when the dorsal margin and plateau are absent.")
										)
									)
								),
								tabPanel("(II) Ventral Rampart",
									fluidRow(
										column(width = 7, offset = 0, style = 'padding:0px;',
											rglwidgetOutput("scan_vr", width = "512px", height = "512px")
										),
										column(width = 5, offset = 0, style = 'padding:0px;',
											br(),
											div("Ventral Rampart Scores:", style = "font-size: 15px; font-weight: bold;"),
											hr(),
											radioButtons("scan_vr_comp", "", c(
												"1: Ventral beveling is present only at superior extremity of ventral border." = "vrSTL_1",
												"2: Bevel extends inferiorly along ventral border." = "vrSTL_2",
												"3: The ventral rampart begins by means of bony extensions from either or both of the extremities." = "vrSTL_3",
												"4: The rampart is extensive but gaps are still evident along the earlier ventral border, most evident in the upper two-thirds." = "vrSTL_4",
												"5: The rampart is complete." = "vrSTL_5")
											),
											hr(),
											helpText("NOTE: A score of zero is assigned when the ventral beveling and rampart are absent.")
										)
									)
								),
								tabPanel("(III) Symphyseal Rim",
									fluidRow(
										column(width = 7, offset = 0, style = 'padding:0px;',
											rglwidgetOutput("scan_sr", width = "512px", height = "512px")
										),
										column(width = 5, offset = 0, style = 'padding:0px;',
											br(),
											div("Symphyseal Rim Scores:", style = "font-size: 15px; font-weight: bold;"),
											hr(),
											radioButtons("scan_sr_comp", "", c(
												"1: A partial dorsal rim is present, usually at the superior end of the dorsal margin, it is round and smooth in texture and elevated above the symphyseal surface." = "srSTL_1",
												"2: The dorsal rim is complete and the ventral rim is beginning to form. There is no particular beginning site." = "srSTL_2",
												"3: The symphyseal rim is complete. The enclosed symphyseal surface is finely grained in texture and irregular or undulating in appearance." = "srSTL_3",
												"4: The rim begins to break down. The face becomes smooth and flat and the rim is no longer round but sharply defined. There is some evidence of lipping on the ventral edge." = "srSTL_4",
												"5: Further breakdown of the rim (especially along superior ventral edge) and rarefaction of the symphyseal face. There is also disintegration and erratic ossification along the ventral rim." = "srSTL_5")
											),
											hr(),
											helpText("NOTE: A score of zero is assigned when the symphyseal rim is absent.")
										)
									)
								)
							)
						)
					)
				),
				tabPanel("Output",
					h3("Composite"),
					dataTableOutput("compositeTable"),
					hr(),
					h3("Components"),
					dataTableOutput("componentTable"),
					hr(),
					h3("Summary"),
					htmlOutput("summ"),
					hr(),
					helpText("NOTE: The summary is included as a guide only and should be adjusted on a case-by-case basis depending on the observed morphology."),
					helpText("Data sourced from McKern, T.W. and T.D. Stewart (1957) Skeletal Age Changes in Young American Males. Quartermaster Research and Develoment Command Technical Report EP-45, Natick, MA.")
				),
				tabPanel(
					tags$button(id = 'close', type = "button", class = "btn action-button", onclick = "setTimeout(function(){window.close();},50);", "Exit", style = "color: gray; background-color: rgba(0,0,0,0); padding: 0px 0px; display: inline-block; border: none; margin-top: -2px", hover = "color: white")
				)
			)
		)
	)
)
