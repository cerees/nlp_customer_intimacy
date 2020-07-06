#pkgs <- c('ramnathv/slidifyLibraries', 'ramnathv/slidify')
#devtools::install_github(pkgs)

##################################
####LOAD FUNCTIONS AND PACKAGES###
##################################
library(slidify)
library(slidifyLibraries)
library(diagram)
library(extrafont)
library(RSvgDevice)
################################
###CREATE DIAGRAMS AND SLIDES###
################################

setwd("~/data_science/cdphp_slide_template")

###AUTHOR SLIDES###
#author("~/data_science/cdphp_slide_template")
###CREATE HTML FILE###
slidify("~/data_science/cdphp_slide_template/index.Rmd")
###PUBLSIH SLIDES###
publish(user = "cerees", repo = "nlp_customer_intimacy")

