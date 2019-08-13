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
			navbarPage(theme = "bootstrap.css", # adapted from Sandstone theme found at <https://bootswatch.com/3/sandstone/>
				title = div(style = "padding: 0px 0px; height: '100%'; margin-top: -12px", img(src = "MSPS_1.png", height = 50, style = "margin: -1px 0px; padding-right: 8px;"), "Pubic Symphysis Age Estimation"),
				windowTitle = "MSPS",
				tabPanel("Analysis",
					fluidRow(
						sidebarLayout(
							sidebarPanel(
								div("Data Input", style = "font-size: 22px; font-weight: bold; text-align: center;"),
								tags$head(tags$style(HTML("hr {border-top: 1px solid #9B9B9B;}"))),
								tags$head(tags$style(".table .alignCent {text-align: center;}")),
								hr(),
								div("Left Pubic Symphysis", style = "display: inline-block; vertical-align: top; font-size: 15px; font-weight: bold;"),
								div(materialSwitch("leftval", "Present:", TRUE), style = "display: inline-block; vertical-align: top; position: absolute; right: 40px; font-size: 15px; font-weight: bold;"),
								br(),
								br(),
								shinyjs::useShinyjs(),
								hidden(pickerInput("LdpVal", "(I) Dorsal Plateau", choices = 0:5), pickerInput("LvrVal", "(II) Ventral Rampart", choices = 0:5), pickerInput("LsrVal", "(III) Symphyseal Rim", choices = 0:5)),
								uiOutput("leftnum"),
								hr(),
								div("Right Pubic Symphysis", style = "display: inline-block; vertical-align: top; font-size: 15px; font-weight: bold;"),
								div(materialSwitch("rightval", "Present:", TRUE), style = "display: inline-block; vertical-align: top; position: absolute; right: 40px; font-size: 15px; font-weight: bold;"),
								br(),
								br(),
								shinyjs::useShinyjs(),
								hidden(pickerInput("RdpVal", "(I) Dorsal Plateau", choices = 0:5), pickerInput("RvrVal", "(II) Ventral Rampart", choices = 0:5), pickerInput("RsrVal", "(III) Symphyseal Rim", choices = 0:5)),
								uiOutput("rightnum")
							),
							mainPanel(
								br(),
								div("Reference Casts", style = "font-size: 22px; font-weight: bold; text-align: center;"),
								
								br(),
								tabsetPanel(type = "tabs",
									tabPanel("(I) Dorsal Plateau",
										fluidRow(
											column(width = 7, offset = 0, style = "padding-top: 65px;",
												rglwidgetOutput("scan_dp", width = "470px", height = "470px")
											),
											column(width = 5, offset = 0, style = 'padding: 0px;',
												br(),
												div(style = "display: inline-block; vertical-align: middle; font-size: 15px; font-weight: bold;", "Dorsal Plateau Scores:"),
												div(style = "display: inline-block; vertical-align: middle; position: absolute; right: 15px; font-size: 15px;",
													dropdownButton(icon = icon("info"), size = "xs", right = TRUE,
													helpText("- Click on each score to see the corresponding cast."),
													helpText("- Cast model is interactive: click and drag to rotate; scroll to zoom.")
												)),
												hr(),
												radioButtons("scan_dp_comp", "", c(
													"0: The dorsal margin is absent. NOTE: No cast exists for this score." = "dpSTL_0",
													"1: A slight margin formation first appears in the middle third of the dorsal border." = "dpSTL_1",
													"2: The dorsal margin extends along the entire dorsal border." = "dpSTL_2",
													"3: Filling in of grooves and resorption of ridges to form a beginning plateau in the middle third of the dorsal demiface." = "dpSTL_3",
													"4: The plateau, still exhibiting vestiges of billowing, extends over most of the dorsal demi-face." = "dpSTL_4",
													"5: Billowing disappears completely and the surface of the entire demi-face becomes flat and slightly granulated in texture." = "dpSTL_5"),
													selected = "dpSTL_1",
													width = "90%"
												)
											)
										)
									),
									tabPanel("(II) Ventral Rampart",
										fluidRow(
											column(width = 7, offset = 0, style = 'padding-top: 65px;',
												rglwidgetOutput("scan_vr", width = "470px", height = "470px")
											),
											column(width = 5, offset = 0, style = 'padding: 0px;',
												br(),
												div(style = "display: inline-block; vertical-align: middle; font-size: 15px; font-weight: bold;", "Ventral Rampart Scores:"),
												div(style = "display: inline-block; vertical-align: middle; position: absolute; right: 10px; font-size: 15px;",
													dropdownButton(icon = icon("info"), size = "xs", right = TRUE,
													helpText("- Click on each score to see the corresponding cast."),
													helpText("- Cast model is interactive: click and drag to rotate; scroll to zoom.")
												)),
												hr(),
												radioButtons("scan_vr_comp", "", c(
													"0: Ventral beveling and rampart are absent. NOTE: No cast exists for this score." = "vrSTL_0",
													"1: Ventral beveling is present only at superior extremity of ventral border." = "vrSTL_1",
													"2: Bevel extends inferiorly along ventral border." = "vrSTL_2",
													"3: The ventral rampart begins by means of bony extensions from either or both of the extremities." = "vrSTL_3",
													"4: The rampart is extensive but gaps are still evident along the earlier ventral border, most evident in the upper two-thirds." = "vrSTL_4",
													"5: The rampart is complete." = "vrSTL_5"),
													selected = "vrSTL_1",
													width = "90%"
												)
											)
										)
									),
									tabPanel("(III) Symphyseal Rim",
										fluidRow(
											column(width = 7, offset = 0, style = 'padding-top: 65px;',
												rglwidgetOutput("scan_sr", width = "470px", height = "470px")
											),
											column(width = 5, offset = 0, style = 'padding: 0px;',
												br(),
												div(style = "display: inline-block; vertical-align: middle; font-size: 15px; font-weight: bold;", "Symphyseal Rim Scores:"),
												div(style = "display: inline-block; vertical-align: middle; position: absolute; right: 10px; font-size: 15px;",
													dropdownButton(icon = icon("info"), size = "xs", right = TRUE,
													helpText("- Click on each score to see the corresponding cast."),
													helpText("- Cast model is interactive: click and drag to rotate; scroll to zoom.")
												)),
												hr(),
												radioButtons("scan_sr_comp", "", c(
													"0: The symphyseal rim is absent. NOTE: No cast exists for this score." = "srSTL_0",
													"1: A partial dorsal rim is present, usually at the superior end of the dorsal margin, it is round and smooth in texture and elevated above the symphyseal surface." = "srSTL_1",
													"2: The dorsal rim is complete and the ventral rim is beginning to form. There is no particular beginning site." = "srSTL_2",
													"3: The symphyseal rim is complete. The enclosed symphyseal surface is finely grained in texture and irregular or undulating in appearance." = "srSTL_3",
													"4: The rim begins to break down. The face becomes smooth and flat and the rim is no longer round but sharply defined. There is some evidence of lipping on the ventral edge." = "srSTL_4",
													"5: Further breakdown of the rim (especially along superior ventral edge) and rarefaction of the symphyseal face. There is also disintegration and erratic ossification along the ventral rim." = "srSTL_5"),
													selected = "srSTL_1",
													width = "90%"
												)
											)
										)
									)
								)
							)
						)
					),
					fluidRow(
						br(),
						div(hr(style = "border-top: 20px solid #8C8C8C;")),
						br(),
						div("Data Output", style = "font-size: 22px; font-weight: bold; text-align: center;"),
						hr(),
						br(),
						column(width = 4, offset = 1, style = 'padding: 0px;',
							div("Composite", style = "font-size: 18px; font-weight: bold; text-align: center;"),
							dataTableOutput("compositeTable")
						),
						column(width = 4, offset = 2, style = 'padding: 0px;',
							div("Components", style = "font-size: 18px; font-weight: bold; text-align: center;"),
							dataTableOutput("componentTable")
						)
					),
					fluidRow(
						column(width = 12, offset = 0, style = 'padding: 0px;',
							br(),
							div(style = "display: inline-block; vertical-align: middle; font-size: 18px; font-weight: bold; text-align: center; width: 99%", "Summary"),
							div(style = "display: inline-block; vertical-align: middle; position: absolute; right: 10px; font-size: 15px;",
								dropdownButton(icon = icon("info"), size = "xs", right = TRUE,
								helpText("The summary is included as a guide only and should be adjusted on a case-by-case basis depending on the observed morphology.")
							)),
							br(),
							br(),
							htmlOutput("summ"),
							br(),
							br(),
							br()
						)
					)
				),
				tabPanel(
					tags$button(id = 'close', type = "button", class = "btn action-button", onclick = "setTimeout(function(){window.close();},50);", "Exit", style = "color: gray; background-color: rgba(0,0,0,0); padding: 0px 0px; display: inline-block; border: none; margin-top: -2px", hover = "color: white")
				),
				tags$footer(
					style = "position: relative; left: -15px; width: 102%; height: 60px; color: white; padding-top: 20px; padding-left: 20px; padding-right: 20px; background-color: #3e3f3a; font-size: 13px;",
					"Data sourced from McKern, T.W. and T.D. Stewart (1957) Skeletal Age Changes in Young American Males. Quartermaster Research and Develoment Command Technical Report EP-45, Natick, MA."
				)
			)
		)
	)
)
