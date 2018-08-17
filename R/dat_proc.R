library(dplyr)
library(sf)

prj <- 4326 # geographic wgs84

######
# get all existing data 

# input data and wqi scores as sf object
alldat <- read.csv('../Data/RawData/SMC_WQIapp_051618/WQI_App/alldata.csv', stringsAsFactors = F) %>% 
  mutate(date = as.Date(SampleDate2, format = '%m/%d/%Y')) %>% 
  select(MasterID, date, Latitude, Longitude, csci_mean, h20_mean, PCT_SAFN, H_AqHab, H_SubNat, Ev_FlowHab, XCMG, indexscore_cram, Cond, TN2, TP) %>% 
  rename(
    CSCI = csci_mean,
    ASCI = h20_mean
  ) %>% 
  wqi %>% 
  st_as_sf(coords = c('Longitude', 'Latitude'), crs = prj)

save(alldat, file = 'data/alldat.RData', compress = 'xz')