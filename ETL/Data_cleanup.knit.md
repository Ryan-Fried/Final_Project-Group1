
<!-- rnb-text-begin -->

---
title: "R Notebook"
output: html_notebook
---


<!-- rnb-text-end -->



<!-- rnb-text-begin -->




<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeSh0aWR5dmVyc2UpXG5gYGAifQ== -->

```r
library(tidyverse)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiUmVnaXN0ZXJlZCBTMyBtZXRob2RzIG92ZXJ3cml0dGVuIGJ5ICdkYnBseXInOlxuICBtZXRob2QgICAgICAgICBmcm9tXG4gIHByaW50LnRibF9sYXp5ICAgICBcbiAgcHJpbnQudGJsX3NxbCAgICAgIFxuLS0gQXR0YWNoaW5nIHBhY2thZ2VzIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSB0aWR5dmVyc2UgMS4zLjEgLS1cbnYgZ2dwbG90MiAzLjMuNSAgICAgdiBwdXJyciAgIDAuMy40XG52IHRpYmJsZSAgMy4xLjYgICAgIHYgZHBseXIgICAxLjAuN1xudiB0aWR5ciAgIDEuMS40ICAgICB2IHN0cmluZ3IgMS40LjBcbnYgcmVhZHIgICAyLjEuMSAgICAgdiBmb3JjYXRzIDAuNS4xXG4tLSBDb25mbGljdHMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIHRpZHl2ZXJzZV9jb25mbGljdHMoKSAtLVxueCBkcGx5cjo6ZmlsdGVyKCkgbWFza3Mgc3RhdHM6OmZpbHRlcigpXG54IGRwbHlyOjpsYWcoKSAgICBtYXNrcyBzdGF0czo6bGFnKClcbiJ9 -->

```
Registered S3 methods overwritten by 'dbplyr':
  method         from
  print.tbl_lazy     
  print.tbl_sql      
-- Attaching packages ------------------------ tidyverse 1.3.1 --
v ggplot2 3.3.5     v purrr   0.3.4
v tibble  3.1.6     v dplyr   1.0.7
v tidyr   1.1.4     v stringr 1.4.0
v readr   2.1.1     v forcats 0.5.1
-- Conflicts --------------------------- tidyverse_conflicts() --
x dplyr::filter() masks stats::filter()
x dplyr::lag()    masks stats::lag()
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShkcGx5cilcbmxpYnJhcnkocmVhZHhsKVxubGlicmFyeShuYW5pYXIpXG5saWJyYXJ5KGltcHV0ZVRTKVxuYGBgIn0= -->

```r
library(dplyr)
library(readxl)
library(naniar)
library(imputeTS)
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBUcmFuc2Zvcm1pbmcgYW5kIGNsZWFuaW5nIC0gTGlmZSBFeHBlY3RhbmN5IGRhdGFcblxubGU8LXJlYWQuY3N2KFwiUmVzb3VyY2VzL1Jhdy9MaWZlX2V4cGVjdGFuY3kuY3N2XCIsY2hlY2submFtZXM9VFJVRSxoZWFkZXIgPSBUUlVFLCBzZXAgPSBcIixcIiwgc3RyaW5nc0FzRmFjdG9ycyA9IEZBTFNFLCBza2lwID0gNClcbiMgUmVtb3ZlIHVud2FudGVkIGZpZWxkc1xubGU8LXNlbGVjdChsZSwtYyhJbmRpY2F0b3IuTmFtZSxJbmRpY2F0b3IuQ29kZSxYKSlcbiMgVHJhbnNmb3JtXG5sZTwtZ2F0aGVyKGxlLGtleT1cIlllYXJcIix2YWx1ZT1cIkxFXCIsWDE5NjA6WDIwMjApXG4jIFN0cmVhbWxpbmVcbmxlJFllYXI8LWdzdWIoXCJYXCIsXCJcIixsZSRZZWFyKSU+JWFzLm51bWVyaWMoYXMuY2hhcmFjdGVyKGxlJFllYXIpKVxubmFtZXMobGUpPC1jKFwiQ291bnRyeVwiLFwiQ29kZVwiLFwiWWVhclwiLFwiTGlmZV9FeHBlY3RhbmN5XCIpXG5gYGAifQ== -->

```r
# Transforming and cleaning - Life Expectancy data

le<-read.csv("Resources/Raw/Life_expectancy.csv",check.names=TRUE,header = TRUE, sep = ",", stringsAsFactors = FALSE, skip = 4)
# Remove unwanted fields
le<-select(le,-c(Indicator.Name,Indicator.Code,X))
# Transform
le<-gather(le,key="Year",value="LE",X1960:X2020)
# Streamline
le$Year<-gsub("X","",le$Year)%>%as.numeric(as.character(le$Year))
names(le)<-c("Country","Code","Year","Life_Expectancy")
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBUcmFuc2Zvcm1pbmcgYW5kIGNsZWFuaW5nIC0gQWxjb2hvbCAtIEhhYml0c1xuQWxjb2hvbF9jb25zdW1wdGlvbjwtcmVhZC5jc3YoXCJSZXNvdXJjZXMvUmF3L0FsY29ob2xfY29uc3VtcHRpb24uY3N2XCIsY2hlY2submFtZXM9VFJVRSxoZWFkZXIgPSBUUlVFLCBzZXAgPSBcIixcIiwgc3RyaW5nc0FzRmFjdG9ycyA9IEZBTFNFLCBza2lwID0gNClcbiMgUmVtb3ZlIHVud2FudGVkIGZpZWxkc1xuQWxjb2hvbF9jb25zdW1wdGlvbjwtc2VsZWN0KEFsY29ob2xfY29uc3VtcHRpb24sLWMoSW5kaWNhdG9yLk5hbWUsSW5kaWNhdG9yLkNvZGUsWCkpXG4jIFRyYW5zZm9ybVxuQWxjb2hvbF9jb25zdW1wdGlvbjwtZ2F0aGVyKEFsY29ob2xfY29uc3VtcHRpb24sa2V5PVwiWWVhclwiLHZhbHVlPVwiQWxjb2hvbF91c2FnZVwiLFgxOTYwOlgyMDIwKVxuIyBDb252ZXJ0aW5nIHllYXIgdG8gcHJvcGVyIGZvcm1hdFxuQWxjb2hvbF9jb25zdW1wdGlvbiRZZWFyPC1nc3ViKFwiWFwiLFwiXCIsQWxjb2hvbF9jb25zdW1wdGlvbiRZZWFyKSU+JWFzLm51bWVyaWMoYXMuY2hhcmFjdGVyKEFsY29ob2xfY29uc3VtcHRpb24kWWVhcikpXG5BbGNvaG9sX2NvbnN1bXB0aW9uPC1zdWJzZXQoQWxjb2hvbF9jb25zdW1wdGlvbixZZWFyPj0yMDAwKVxuIyBGaWxsIGluIG1pc3NpbmcgZGF0YVxuQWxjb2hvbF9jb25zdW1wdGlvbjwtQWxjb2hvbF9jb25zdW1wdGlvbiU+JWdyb3VwX2J5KENvdW50cnkuTmFtZSklPiVcbiAgZmlsbChBbGNvaG9sX3VzYWdlLC5kaXJlY3Rpb24gPSBcImRvd251cFwiKVxuI1N0cmVhbWxpbmVcbm5hbWVzKEFsY29ob2xfY29uc3VtcHRpb24pPC1jKFwiQ291bnRyeVwiLFwiQ29kZVwiLFwiWWVhclwiLFwiVG90YWxfYWxjb2hvbF9jb25zdW1wdGlvbl9wZXJfY2FwaXRhXCIpXG5gYGAifQ== -->

```r
# Transforming and cleaning - Alcohol - Habits
Alcohol_consumption<-read.csv("Resources/Raw/Alcohol_consumption.csv",check.names=TRUE,header = TRUE, sep = ",", stringsAsFactors = FALSE, skip = 4)
# Remove unwanted fields
Alcohol_consumption<-select(Alcohol_consumption,-c(Indicator.Name,Indicator.Code,X))
# Transform
Alcohol_consumption<-gather(Alcohol_consumption,key="Year",value="Alcohol_usage",X1960:X2020)
# Converting year to proper format
Alcohol_consumption$Year<-gsub("X","",Alcohol_consumption$Year)%>%as.numeric(as.character(Alcohol_consumption$Year))
Alcohol_consumption<-subset(Alcohol_consumption,Year>=2000)
# Fill in missing data
Alcohol_consumption<-Alcohol_consumption%>%group_by(Country.Name)%>%
  fill(Alcohol_usage,.direction = "downup")
#Streamline
names(Alcohol_consumption)<-c("Country","Code","Year","Total_alcohol_consumption_per_capita")
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBUcmFuc2Zvcm1pbmcgYW5kIGNsZWFuaW5nIC0gT2Jlc2l0eSAtIEhhYml0c1xub2Jlc2l0eTwtcmVhZC5jc3YoXCJSZXNvdXJjZXMvUmF3L09iZXNpdHlfcHJldmVsYW5jZS5jc3ZcIixjaGVjay5uYW1lcz1UUlVFLGhlYWRlciA9IFRSVUUsIHNlcCA9IFwiLFwiLCBzdHJpbmdzQXNGYWN0b3JzID0gRkFMU0UpXG4jIFJlbW92ZSB1bndhbnRlZCBmaWVsZHMgLSBDb2x1bW5zIGZvciBtYWxlIGFuZCBmZW1hbGUgY29udGFpbmVkIFwiLlwiIHNpbmNlIHRoZXkgd2VyZSByZXBlYXRzXG5vYmVzaXR5PC1zZWxlY3Qob2Jlc2l0eSwtYyh3aGljaChncmVwbChcIlxcXFwuXCIsbmFtZXMob2Jlc2l0eSkpKSkpXG5vYmVzaXR5PC10YWlsKG9iZXNpdHksLTMpXG4jIFRyYW5zZm9ybVxub2Jlc2l0eTwtZ2F0aGVyKG9iZXNpdHksa2V5PVwiWWVhclwiLHZhbHVlPVwiT2Jlc2l0eVwiLFgyMDE2OlgxOTc1KVxuIyBDb252ZXJ0aW5nIHllYXIgdG8gcHJvcGVyIGZvcm1hdFxub2Jlc2l0eSRZZWFyPC1nc3ViKFwiWFwiLFwiXCIsb2Jlc2l0eSRZZWFyKSU+JWFzLm51bWVyaWMoYXMuY2hhcmFjdGVyKG9iZXNpdHkkWWVhcikpXG4jIENvbnZlcnRpbmcgb2Jlc2UgcGVvcGxlIHBlcmNlbnRhZ2UgdG8gcHJvcGVyIGZvcm1hdFxub2Jlc2l0eSRPYmVzaXR5PC1zdHJfcmVtb3ZlKG9iZXNpdHkkT2Jlc2l0eSxcIlxcXFxbLipcXFxcXVwiKVxuIyBFeHRlbmRpbmcgdGhlIGRhdGFcbm9iZXNpdHk8LW9iZXNpdHklPiVjb21wbGV0ZShZZWFyPXNlcSgyMDE3LDIwMTkpLFgpIyU+JVxub2Jlc2l0eTwtb2Jlc2l0eSU+JWdyb3VwX2J5KFgpJT4lZmlsbChPYmVzaXR5LC5kaXJlY3Rpb24gPVwiZG93bnVwXCIpXG4jIFN0cmVhbWxpbmVcbm5hbWVzKG9iZXNpdHkpPC1jKFwiWWVhclwiLFwiQ291bnRyeVwiLFwiUGVyY2VudGFnZV9vZl9PYmVzZV9QZW9wbGVcIilcblxuYGBgIn0= -->

```r
# Transforming and cleaning - Obesity - Habits
obesity<-read.csv("Resources/Raw/Obesity_prevelance.csv",check.names=TRUE,header = TRUE, sep = ",", stringsAsFactors = FALSE)
# Remove unwanted fields - Columns for male and female contained "." since they were repeats
obesity<-select(obesity,-c(which(grepl("\\.",names(obesity)))))
obesity<-tail(obesity,-3)
# Transform
obesity<-gather(obesity,key="Year",value="Obesity",X2016:X1975)
# Converting year to proper format
obesity$Year<-gsub("X","",obesity$Year)%>%as.numeric(as.character(obesity$Year))
# Converting obese people percentage to proper format
obesity$Obesity<-str_remove(obesity$Obesity,"\\[.*\\]")
# Extending the data
obesity<-obesity%>%complete(Year=seq(2017,2019),X)#%>%
obesity<-obesity%>%group_by(X)%>%fill(Obesity,.direction ="downup")
# Streamline
names(obesity)<-c("Year","Country","Percentage_of_Obese_People")

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBUcmFuc2Zvcm1pbmcgYW5kIGNsZWFuaW5nIC0gUG9wdWxhdGlvbiAtIFNvY2lhbFxucG9wdWxhdGlvbjwtcmVhZC5jc3YoXCJSZXNvdXJjZXMvUmF3L1BvcHVsYXRpb25fVU4uY3N2XCIsY2hlY2submFtZXM9VFJVRSxoZWFkZXIgPSBUUlVFLCBzZXAgPSBcIixcIiwgc3RyaW5nc0FzRmFjdG9ycyA9IEZBTFNFLHNraXA9MSlcbiMgUmVtb3ZlIHVud2FudGVkIGRhdGFcbnBvcHVsYXRpb248LXNlbGVjdChwb3B1bGF0aW9uLC1jKFJlZ2lvbi5Db3VudHJ5LkFyZWEsRm9vdG5vdGVzLFNvdXJjZSkpXG4jIFRyYW5zZm9ybVxucG9wdWxhdGlvbjwtc3ByZWFkKHBvcHVsYXRpb24sa2V5PVwiU2VyaWVzXCIsdmFsdWU9XCJWYWx1ZVwiKVxuIyBSZW1vdmUgdW53YW50ZWQgZmllbGRzXG5uYW1lcyhwb3B1bGF0aW9uKTwtZ3N1YihcIiBcIixcIl9cIixuYW1lcyhwb3B1bGF0aW9uKSlcbnBvcHVsYXRpb248LXNlbGVjdChwb3B1bGF0aW9uLGMoWCxZZWFyLFBvcHVsYXRpb25fZGVuc2l0eSxgU2V4X3JhdGlvXyhtYWxlc19wZXJfMTAwX2ZlbWFsZXMpYCkpXG4jIFN0cmVhbWxpbmVcbm5hbWVzKHBvcHVsYXRpb24pWzFdPC1cIkNvdW50cnlcIlxuXG5cbmBgYCJ9 -->

```r
# Transforming and cleaning - Population - Social
population<-read.csv("Resources/Raw/Population_UN.csv",check.names=TRUE,header = TRUE, sep = ",", stringsAsFactors = FALSE,skip=1)
# Remove unwanted data
population<-select(population,-c(Region.Country.Area,Footnotes,Source))
# Transform
population<-spread(population,key="Series",value="Value")
# Remove unwanted fields
names(population)<-gsub(" ","_",names(population))
population<-select(population,c(X,Year,Population_density,`Sex_ratio_(males_per_100_females)`))
# Streamline
names(population)[1]<-"Country"

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBUcmFuc2Zvcm1pbmcgYW5kIGNsZWFuaW5nIC0gQkNHIC0gSW1tdW5pemF0aW9uXG5CQ0c8LXJlYWRfZXhjZWwoXCJSZXNvdXJjZXMvUmF3L0JDRy54bHN4XCIpXG4jIFJlbW92ZSB1bndhbnRlZCBkYXRhXG5CQ0c8LXN1YnNldChCQ0csQ09WRVJBR0VfQ0FURUdPUlk9PVwiV1VFTklDXCIpXG5CQ0c8LXNlbGVjdChCQ0csLWMoR1JPVVAsQU5USUdFTixBTlRJR0VOX0RFU0NSSVBUSU9OLENPVkVSQUdFX0NBVEVHT1JZLENPVkVSQUdFX0NBVEVHT1JZX0RFU0NSSVBUSU9OLFRBUkdFVF9OVU1CRVIsRE9TRVMpKVxuIyBGaWxsIHVwIGFueSBtaXNzaW5nIGRhdGFcbkJDRzwtQkNHJT4lZ3JvdXBfYnkoTkFNRSklPiVmaWxsKENPVkVSQUdFLC5kaXJlY3Rpb249XCJ1cFwiKVxuIyBTdHJlYW1saW5lXG5uYW1lcyhCQ0cpPC1jKFwiQ29kZVwiLFwiQ291bnRyeVwiLFwiWWVhclwiLFwiQkNHX0NvdmVyYWdlXCIpXG5gYGAifQ== -->

```r
# Transforming and cleaning - BCG - Immunization
BCG<-read_excel("Resources/Raw/BCG.xlsx")
# Remove unwanted data
BCG<-subset(BCG,COVERAGE_CATEGORY=="WUENIC")
BCG<-select(BCG,-c(GROUP,ANTIGEN,ANTIGEN_DESCRIPTION,COVERAGE_CATEGORY,COVERAGE_CATEGORY_DESCRIPTION,TARGET_NUMBER,DOSES))
# Fill up any missing data
BCG<-BCG%>%group_by(NAME)%>%fill(COVERAGE,.direction="up")
# Streamline
names(BCG)<-c("Code","Country","Year","BCG_Coverage")
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBUcmFuc2Zvcm1pbmcgYW5kIGNsZWFuaW5nIC0gTWVhc2xlcyAtIEltbXVuaXphdGlvblxubWVhc2xlczwtcmVhZF9leGNlbChcIlJlc291cmNlcy9SYXcvTWVhc2xlcyB2YWNjaW5hdGlvbiBjb3ZlcmFnZS54bHN4XCIpXG4jIFJlbW92ZSB1bndhbnRlZCBkYXRhXG5tZWFzbGVzPC1zdWJzZXQobWVhc2xlcyxDT1ZFUkFHRV9DQVRFR09SWT09XCJXVUVOSUNcIilcbm1lYXNsZXM8LXNlbGVjdChtZWFzbGVzLC1jKEdST1VQLEFOVElHRU4sQU5USUdFTl9ERVNDUklQVElPTixDT1ZFUkFHRV9DQVRFR09SWSxDT1ZFUkFHRV9DQVRFR09SWV9ERVNDUklQVElPTixUQVJHRVRfTlVNQkVSLERPU0VTKSlcbiMgRmlsbCB1cCBhbnkgbWlzc2luZyBkYXRhXG5tZWFzbGVzPC1tZWFzbGVzJT4lZ3JvdXBfYnkoTkFNRSklPiVmaWxsKENPVkVSQUdFLC5kaXJlY3Rpb249XCJ1cFwiKVxuIyBTdHJlYW1saW5lXG5uYW1lcyhtZWFzbGVzKTwtYyhcIkNvZGVcIixcIkNvdW50cnlcIixcIlllYXJcIixcIk1lYXNsZXNfdmFjY2luYXRpb25fY292ZXJhZ2VcIilcblxuYGBgIn0= -->

```r
# Transforming and cleaning - Measles - Immunization
measles<-read_excel("Resources/Raw/Measles vaccination coverage.xlsx")
# Remove unwanted data
measles<-subset(measles,COVERAGE_CATEGORY=="WUENIC")
measles<-select(measles,-c(GROUP,ANTIGEN,ANTIGEN_DESCRIPTION,COVERAGE_CATEGORY,COVERAGE_CATEGORY_DESCRIPTION,TARGET_NUMBER,DOSES))
# Fill up any missing data
measles<-measles%>%group_by(NAME)%>%fill(COVERAGE,.direction="up")
# Streamline
names(measles)<-c("Code","Country","Year","Measles_vaccination_coverage")

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBUcmFuc2Zvcm1pbmcgYW5kIGNsZWFuaW5nIC0gSGVwQiAtIEltbXVuaXphdGlvblxuaGVwYXRpdGlzPC1yZWFkX2V4Y2VsKFwiUmVzb3VyY2VzL1Jhdy9IZXBhdGl0aXMgQiB2YWNjaW5hdGlvbiBjb3ZlcmFnZS54bHN4XCIpXG4jIFJlbW92ZSB1bndhbnRlZCBkYXRhXG5oZXBhdGl0aXM8LXN1YnNldChoZXBhdGl0aXMsQ09WRVJBR0VfQ0FURUdPUlk9PVwiV1VFTklDXCIpXG5oZXBhdGl0aXM8LXNlbGVjdChoZXBhdGl0aXMsLWMoR1JPVVAsQU5USUdFTixBTlRJR0VOX0RFU0NSSVBUSU9OLENPVkVSQUdFX0NBVEVHT1JZLENPVkVSQUdFX0NBVEVHT1JZX0RFU0NSSVBUSU9OLFRBUkdFVF9OVU1CRVIsRE9TRVMpKVxuIyBGaWxsIHVwIG1pc3NpbmcgZGF0YVxuaGVwYXRpdGlzPC1oZXBhdGl0aXMlPiVncm91cF9ieShOQU1FKSU+JWZpbGwoQ09WRVJBR0UsLmRpcmVjdGlvbj1cInVwXCIpXG4jIFN0cmVhbWxpbmVcbm5hbWVzKGhlcGF0aXRpcyk8LWMoXCJDb2RlXCIsXCJDb3VudHJ5XCIsXCJZZWFyXCIsXCJIZXAtQl92YWNjaW5hdGlvbl9jb3ZlcmFnZVwiKVxuYGBgIn0= -->

```r
# Transforming and cleaning - HepB - Immunization
hepatitis<-read_excel("Resources/Raw/Hepatitis B vaccination coverage.xlsx")
# Remove unwanted data
hepatitis<-subset(hepatitis,COVERAGE_CATEGORY=="WUENIC")
hepatitis<-select(hepatitis,-c(GROUP,ANTIGEN,ANTIGEN_DESCRIPTION,COVERAGE_CATEGORY,COVERAGE_CATEGORY_DESCRIPTION,TARGET_NUMBER,DOSES))
# Fill up missing data
hepatitis<-hepatitis%>%group_by(NAME)%>%fill(COVERAGE,.direction="up")
# Streamline
names(hepatitis)<-c("Code","Country","Year","Hep-B_vaccination_coverage")
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBUcmFuc2Zvcm1pbmcgYW5kIGNsZWFuaW5nIC0gRFRUIGFuZCBEVFAgLSBJbW11bml6YXRpb25cbmRpcHRoZXJpYTwtcmVhZF9leGNlbChcIlJlc291cmNlcy9SYXcvRGlwdGhlcmlhLnhsc3hcIilcbiMgUmVtb3ZlIHVud2FudGVkIGRhdGFcbmRpcHRoZXJpYTwtc3Vic2V0KGRpcHRoZXJpYSxDT1ZFUkFHRV9DQVRFR09SWT09XCJXVUVOSUNcIilcbmRpcHRoZXJpYTwtc2VsZWN0KGRpcHRoZXJpYSwtYyhHUk9VUCxBTlRJR0VOLEFOVElHRU5fREVTQ1JJUFRJT04sQ09WRVJBR0VfQ0FURUdPUlksQ09WRVJBR0VfQ0FURUdPUllfREVTQ1JJUFRJT04sVEFSR0VUX05VTUJFUixET1NFUykpXG4jIEZpbGwgdXAgbWlzc2luZyBkYXRhXG5kaXB0aGVyaWE8LWRpcHRoZXJpYSU+JWdyb3VwX2J5KE5BTUUpJT4lZmlsbChDT1ZFUkFHRSwuZGlyZWN0aW9uPVwidXBcIilcbiMgU3RyZWFtbGluZVxubmFtZXMoZGlwdGhlcmlhKTwtYyhcIkNvZGVcIixcIkNvdW50cnlcIixcIlllYXJcIixcIkRUVF9hbmRfRFRQX3ZhY2NpbmF0aW9uX2NvdmVyYWdlXCIpXG5gYGAifQ== -->

```r
# Transforming and cleaning - DTT and DTP - Immunization
diptheria<-read_excel("Resources/Raw/Diptheria.xlsx")
# Remove unwanted data
diptheria<-subset(diptheria,COVERAGE_CATEGORY=="WUENIC")
diptheria<-select(diptheria,-c(GROUP,ANTIGEN,ANTIGEN_DESCRIPTION,COVERAGE_CATEGORY,COVERAGE_CATEGORY_DESCRIPTION,TARGET_NUMBER,DOSES))
# Fill up missing data
diptheria<-diptheria%>%group_by(NAME)%>%fill(COVERAGE,.direction="up")
# Streamline
names(diptheria)<-c("Code","Country","Year","DTT_and_DTP_vaccination_coverage")
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBUcmFuc2Zvcm1pbmcgYW5kIENsZWFuaW5nIC0gRHJpbmtpbmcgV2F0ZXIgLSBTb2Npby1FY29ub21pY1xuZHc8LXJlYWQuY3N2KFwiLi4vUmVzb3VyY2VzL1Jhdy9Ecmlua2luZ193YXRlci5jc3ZcIixjaGVjay5uYW1lcz1UUlVFLGhlYWRlciA9IFRSVUUsIHNlcCA9IFwiLFwiLCBzdHJpbmdzQXNGYWN0b3JzID0gRkFMU0UsIHNraXAgPSA2KVxuXG4jIFJlbW92ZSBVbndhbnRlZCBGaWVsZHNcbmR3PC1zZWxlY3QoZHcsIC1jKEhESS5SYW5rLFgpKVxuZHc8LXNlbGVjdChkdywgLWMod2hpY2goZ3JlcGwoXCJcXFxcLlwiLG5hbWVzKGR3KSkpKSlcbmR3PC1oZWFkKGR3LC0xNylcblxuIyBUcmFuc2Zvcm1cbmR3PC1nYXRoZXIoZHcsa2V5PSdZZWFyJyx2YWx1ZT0nRFcnLFgyMDAwOlgyMDE3KVxuXG4jIFN0cmVhbWxpbmVcbmR3JFllYXI8LWdzdWIoXCJYXCIsXCJcIixkdyRZZWFyKSU+JWFzLm51bWVyaWMoYXMuY2hhcmFjdGVyKGR3JFllYXIpKVxuZHckRFc8LWFzLm51bWVyaWMoZHckRFcpXG5cbiMgQ2hlY2tpbmcgZm9yIG1pc3NpbmcgdmFsdWVzXG5kdyU+JWdyb3VwX2J5KENvdW50cnkpJT4lbWlzc192YXJfc3VtbWFyeSgpJT4lZmlsdGVyKG5fbWlzcz4wKVxuXG4jIEhhbmRsaW5nIG1pc3NpbmcgdmFsdWVzXG5kdzwtZHclPiVncm91cF9ieShDb3VudHJ5KSU+JWZpbHRlcighbWVhbihpcy5uYShEVykpID49IDAuMilcbmR3JT4lZ3JvdXBfYnkoQ291bnRyeSklPiVtaXNzX3Zhcl9zdW1tYXJ5KCklPiVmaWx0ZXIobl9taXNzPjEpXG5kdzwtZHclPiVjb21wbGV0ZShZZWFyPXNlcSgyMDE4LDIwMTkpLENvdW50cnkpXG5cbiMgRmlsbGluZyBpbiBtaXNzaW5nIHZhbHVlc1xuZHc8LWR3JT4lZ3JvdXBfYnkoQ291bnRyeSklPiVtdXRhdGUoRFcgPSBpbXB1dGVUUzo6bmFfaW50ZXJwb2xhdGlvbihEVykpXG5cbiMgRmluYWwgY2xlYW51cFxuZHclPiVncm91cF9ieShDb3VudHJ5KSU+JW1pc3NfdmFyX3N1bW1hcnkoKSU+JWZpbHRlcihuX21pc3M+MClcbm5hbWVzKGR3KTwtYyhcIlllYXJcIiwgXCJDb3VudHJ5XCIsXCJEUk5XXCIpXG5cbmBgYCJ9 -->

```r
# Transforming and Cleaning - Drinking Water - Socio-Economic
dw<-read.csv("../Resources/Raw/Drinking_water.csv",check.names=TRUE,header = TRUE, sep = ",", stringsAsFactors = FALSE, skip = 6)

# Remove Unwanted Fields
dw<-select(dw, -c(HDI.Rank,X))
dw<-select(dw, -c(which(grepl("\\.",names(dw)))))
dw<-head(dw,-17)

# Transform
dw<-gather(dw,key='Year',value='DW',X2000:X2017)

# Streamline
dw$Year<-gsub("X","",dw$Year)%>%as.numeric(as.character(dw$Year))
dw$DW<-as.numeric(dw$DW)

# Checking for missing values
dw%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>0)

# Handling missing values
dw<-dw%>%group_by(Country)%>%filter(!mean(is.na(DW)) >= 0.2)
dw%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>1)
dw<-dw%>%complete(Year=seq(2018,2019),Country)

# Filling in missing values
dw<-dw%>%group_by(Country)%>%mutate(DW = imputeTS::na_interpolation(DW))

# Final cleanup
dw%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>0)
names(dw)<-c("Year", "Country","DRNW")

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBUcmFuc2Zvcm1pbmcgYW5kIENsZWFuaW5nIC0gU2FuaXRhdGlvbiAtIFNvY2lvLUVjb25vbWljXG5zYW5pdGF0aW9uPC1yZWFkLmNzdihcIi4uL1Jlc291cmNlcy9SYXcvU2FuaXRhdGlvbl9TZXJ2aWNlcy5jc3ZcIixjaGVjay5uYW1lcz1UUlVFLGhlYWRlciA9IFRSVUUsIHNlcCA9IFwiLFwiLCBzdHJpbmdzQXNGYWN0b3JzID0gRkFMU0UsIHNraXAgPSA2KVxuXG4jIFJlbW92ZSBVbndhbnRlZCBGaWVsZHNcbnNhbml0YXRpb248LXNlbGVjdChzYW5pdGF0aW9uLCAtYyhIREkuUmFuayxYKSlcbnNhbml0YXRpb248LXNlbGVjdChzYW5pdGF0aW9uLCAtYyh3aGljaChncmVwbChcIlxcXFwuXCIsbmFtZXMoc2FuaXRhdGlvbikpKSkpXG5zYW5pdGF0aW9uPC1oZWFkKHNhbml0YXRpb24sLTE2KVxuXG4jIFRyYW5zZm9ybVxuc2FuaXRhdGlvbjwtZ2F0aGVyKHNhbml0YXRpb24sa2V5PSdZZWFyJyx2YWx1ZT0nU0FOSVRBVElPTicsWDIwMDA6WDIwMTcpXG5cbiMgU3RyZWFtbGluZVxuc2FuaXRhdGlvbiRZZWFyPC1nc3ViKFwiWFwiLFwiXCIsc2FuaXRhdGlvbiRZZWFyKSU+JWFzLm51bWVyaWMoYXMuY2hhcmFjdGVyKHNhbml0YXRpb24kWWVhcikpXG5zYW5pdGF0aW9uJFNBTklUQVRJT048LWFzLm51bWVyaWMoc2FuaXRhdGlvbiRTQU5JVEFUSU9OKVxuXG4jIENoZWNraW5nIGZvciBtaXNzaW5nIHZhbHVlc1xuc2FuaXRhdGlvbiU+JWdyb3VwX2J5KENvdW50cnkpJT4lbWlzc192YXJfc3VtbWFyeSgpJT4lZmlsdGVyKG5fbWlzcz4wKVxuXG4jIEhhbmRsaW5nIG1pc3NpbmcgdmFsdWVzXG5zYW5pdGF0aW9uPC1zYW5pdGF0aW9uJT4lZ3JvdXBfYnkoQ291bnRyeSklPiVmaWx0ZXIoIW1lYW4oaXMubmEoU0FOSVRBVElPTikpID49IDAuMilcbnNhbml0YXRpb24lPiVncm91cF9ieShDb3VudHJ5KSU+JW1pc3NfdmFyX3N1bW1hcnkoKSU+JWZpbHRlcihuX21pc3M+MSlcbnNhbml0YXRpb248LXNhbml0YXRpb24lPiVjb21wbGV0ZShZZWFyPXNlcSgyMDE4LDIwMTkpLENvdW50cnkpXG5cbiMgRmlsbGluZyBpbiBtaXNzaW5nIHZhbHVlc1xuc2FuaXRhdGlvbjwtc2FuaXRhdGlvbiU+JWdyb3VwX2J5KENvdW50cnkpJT4lbXV0YXRlKFNBTklUQVRJT04gPSBpbXB1dGVUUzo6bmFfaW50ZXJwb2xhdGlvbihTQU5JVEFUSU9OKSlcblxuIyBGaW5hbCBjbGVhbnVwXG5zYW5pdGF0aW9uJT4lZ3JvdXBfYnkoQ291bnRyeSklPiVtaXNzX3Zhcl9zdW1tYXJ5KCklPiVmaWx0ZXIobl9taXNzPjApXG5uYW1lcyhzYW5pdGF0aW9uKTwtYyhcIlllYXJcIiwgXCJDb3VudHJ5XCIsXCJTQU5cIilcbmBgYCJ9 -->

```r
# Transforming and Cleaning - Sanitation - Socio-Economic
sanitation<-read.csv("../Resources/Raw/Sanitation_Services.csv",check.names=TRUE,header = TRUE, sep = ",", stringsAsFactors = FALSE, skip = 6)

# Remove Unwanted Fields
sanitation<-select(sanitation, -c(HDI.Rank,X))
sanitation<-select(sanitation, -c(which(grepl("\\.",names(sanitation)))))
sanitation<-head(sanitation,-16)

# Transform
sanitation<-gather(sanitation,key='Year',value='SANITATION',X2000:X2017)

# Streamline
sanitation$Year<-gsub("X","",sanitation$Year)%>%as.numeric(as.character(sanitation$Year))
sanitation$SANITATION<-as.numeric(sanitation$SANITATION)

# Checking for missing values
sanitation%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>0)

# Handling missing values
sanitation<-sanitation%>%group_by(Country)%>%filter(!mean(is.na(SANITATION)) >= 0.2)
sanitation%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>1)
sanitation<-sanitation%>%complete(Year=seq(2018,2019),Country)

# Filling in missing values
sanitation<-sanitation%>%group_by(Country)%>%mutate(SANITATION = imputeTS::na_interpolation(SANITATION))

# Final cleanup
sanitation%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>0)
names(sanitation)<-c("Year", "Country","SAN")
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBUcmFuc2Zvcm1pbmcgYW5kIENsZWFuaW5nIC0gSHVtYW4gRGV2ZWxvcG1lbnQgSW5kZXggKEhESSkgLSBEZXZlbG9wbWVudCBGYWN0b3JzXG5oZGk8LXJlYWQuY3N2KCcuLi9SZXNvdXJjZXMvUmF3L0h1bWFuIERldmVsb3BtZW50IEluZGV4IChIREkpLmNzdicsY2hlY2submFtZXM9VFJVRSxoZWFkZXI9VFJVRSxzZXA9JywnLHN0cmluZ3NBc0ZhY3RvcnM9RkFMU0Usc2tpcD01KVxuXG4jIFJlbW92ZSBVbndhbnRlZCBGaWVsZHNcbmhkaTwtc2VsZWN0KGhkaSwgLWMoSERJLlJhbmssWCkpXG5oZGk8LXNlbGVjdChoZGksIC1jKHdoaWNoKGdyZXBsKFwiXFxcXC5cIixuYW1lcyhoZGkpKSkpKVxuaGRpPC1oZWFkKGhkaSwtMTcpXG5cbiMgVHJhbnNmb3JtXG5oZGk8LWdhdGhlcihoZGksa2V5PSdZZWFyJyx2YWx1ZT0nSERJJyxYMTk5MDpYMjAxOSlcblxuIyBTdHJlYW1saW5lXG5oZGkkWWVhcjwtZ3N1YihcIlhcIixcIlwiLGhkaSRZZWFyKSU+JWFzLm51bWVyaWMoYXMuY2hhcmFjdGVyKGhkaSRZZWFyKSlcbmhkaSRIREk8LWFzLm51bWVyaWMoaGRpJEhESSlcbmhkaTwtaGRpJT4lZmlsdGVyKFllYXI+PTIwMDApXG5cbiMgQ2hlY2tpbmcgZm9yIG1pc3NpbmcgdmFsdWVzXG5oZGklPiVncm91cF9ieShDb3VudHJ5KSU+JW1pc3NfdmFyX3N1bW1hcnkoKSU+JWZpbHRlcihuX21pc3M+MClcblxuIyBIYW5kbGluZyBtaXNzaW5nIHZhbHVlc1xuaGRpPC1oZGklPiVncm91cF9ieShDb3VudHJ5KSU+JWZpbHRlcighbWVhbihpcy5uYShIREkpKSA+PSAwLjIpXG5oZGklPiVncm91cF9ieShDb3VudHJ5KSU+JW1pc3NfdmFyX3N1bW1hcnkoKSU+JWZpbHRlcihuX21pc3M+MSlcblxuIyBGaWxsaW5nIGluIG1pc3NpbmcgdmFsdWVzXG5oZGk8LWhkaSU+JWdyb3VwX2J5KENvdW50cnkpJT4lbXV0YXRlKEhESSA9IGltcHV0ZVRTOjpuYV9pbnRlcnBvbGF0aW9uKEhESSkpXG5cbiMgRmluYWwgY2xlYW51cFxuaGRpJT4lZ3JvdXBfYnkoQ291bnRyeSklPiVtaXNzX3Zhcl9zdW1tYXJ5KCklPiVmaWx0ZXIobl9taXNzPjApXG5uYW1lcyhoZGkpPC1jKFwiQ291bnRyeVwiLFwiWWVhclwiLFwiSERJXCIpXG5gYGAifQ== -->

```r
# Transforming and Cleaning - Human Development Index (HDI) - Development Factors
hdi<-read.csv('../Resources/Raw/Human Development Index (HDI).csv',check.names=TRUE,header=TRUE,sep=',',stringsAsFactors=FALSE,skip=5)

# Remove Unwanted Fields
hdi<-select(hdi, -c(HDI.Rank,X))
hdi<-select(hdi, -c(which(grepl("\\.",names(hdi)))))
hdi<-head(hdi,-17)

# Transform
hdi<-gather(hdi,key='Year',value='HDI',X1990:X2019)

# Streamline
hdi$Year<-gsub("X","",hdi$Year)%>%as.numeric(as.character(hdi$Year))
hdi$HDI<-as.numeric(hdi$HDI)
hdi<-hdi%>%filter(Year>=2000)

# Checking for missing values
hdi%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>0)

# Handling missing values
hdi<-hdi%>%group_by(Country)%>%filter(!mean(is.na(HDI)) >= 0.2)
hdi%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>1)

# Filling in missing values
hdi<-hdi%>%group_by(Country)%>%mutate(HDI = imputeTS::na_interpolation(HDI))

# Final cleanup
hdi%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>0)
names(hdi)<-c("Country","Year","HDI")
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBUcmFuc2Zvcm1pbmcgYW5kIENsZWFuaW5nIC0gSW5jb21lIC0gRGV2ZWxvcG1lbnQgRmFjdG9yc1xuaW5jb21lPC1yZWFkLmNzdignLi4vUmVzb3VyY2VzL1Jhdy9JbmNvbWUgaW5kZXguY3N2JyxjaGVjay5uYW1lcz1UUlVFLGhlYWRlcj1UUlVFLHNlcD0nLCcsc3RyaW5nc0FzRmFjdG9ycz1GQUxTRSxza2lwPTUpXG5cbiMgUmVtb3ZlIFVud2FudGVkIEZpZWxkc1xuaW5jb21lPC1zZWxlY3QoaW5jb21lLCAtYyhIREkuUmFuayxYKSlcbmluY29tZTwtc2VsZWN0KGluY29tZSwgLWMod2hpY2goZ3JlcGwoXCJcXFxcLlwiLG5hbWVzKGluY29tZSkpKSkpXG5pbmNvbWU8LWhlYWQoaW5jb21lLC0xNylcblxuIyBUcmFuc2Zvcm1cbmluY29tZTwtZ2F0aGVyKGluY29tZSxrZXk9J1llYXInLHZhbHVlPSdJTkNPTUUnLFgxOTkwOlgyMDE5KVxuXG4jIFN0cmVhbWxpbmVcbmluY29tZSRZZWFyPC1nc3ViKFwiWFwiLFwiXCIsaW5jb21lJFllYXIpJT4lYXMubnVtZXJpYyhhcy5jaGFyYWN0ZXIoaW5jb21lJFllYXIpKVxuaW5jb21lJElOQ09NRTwtYXMubnVtZXJpYyhpbmNvbWUkSU5DT01FKVxuaW5jb21lPC1pbmNvbWUlPiVmaWx0ZXIoWWVhcj49MjAwMClcblxuIyBDaGVja2luZyBmb3IgbWlzc2luZyB2YWx1ZXNcbmluY29tZSU+JWdyb3VwX2J5KENvdW50cnkpJT4lbWlzc192YXJfc3VtbWFyeSgpJT4lZmlsdGVyKG5fbWlzcz4wKVxuXG4jIEhhbmRsaW5nIG1pc3NpbmcgdmFsdWVzXG5pbmNvbWU8LWluY29tZSU+JWdyb3VwX2J5KENvdW50cnkpJT4lZmlsdGVyKCFtZWFuKGlzLm5hKElOQ09NRSkpID49IDAuMilcbmluY29tZSU+JWdyb3VwX2J5KENvdW50cnkpJT4lbWlzc192YXJfc3VtbWFyeSgpJT4lZmlsdGVyKG5fbWlzcz4xKVxuXG4jIEZpbGxpbmcgaW4gbWlzc2luZyB2YWx1ZXNcbmluY29tZTwtaW5jb21lJT4lZ3JvdXBfYnkoQ291bnRyeSklPiVtdXRhdGUoSU5DT01FID0gaW1wdXRlVFM6Om5hX2ludGVycG9sYXRpb24oSU5DT01FKSlcblxuIyBGaW5hbCBjbGVhbnVwXG5pbmNvbWUlPiVncm91cF9ieShDb3VudHJ5KSU+JW1pc3NfdmFyX3N1bW1hcnkoKSU+JWZpbHRlcihuX21pc3M+MClcbm5hbWVzKGluY29tZSk8LWMoXCJDb3VudHJ5XCIsXCJZZWFyXCIsXCJJTkNJXCIpXG5gYGAifQ== -->

```r
# Transforming and Cleaning - Income - Development Factors
income<-read.csv('../Resources/Raw/Income index.csv',check.names=TRUE,header=TRUE,sep=',',stringsAsFactors=FALSE,skip=5)

# Remove Unwanted Fields
income<-select(income, -c(HDI.Rank,X))
income<-select(income, -c(which(grepl("\\.",names(income)))))
income<-head(income,-17)

# Transform
income<-gather(income,key='Year',value='INCOME',X1990:X2019)

# Streamline
income$Year<-gsub("X","",income$Year)%>%as.numeric(as.character(income$Year))
income$INCOME<-as.numeric(income$INCOME)
income<-income%>%filter(Year>=2000)

# Checking for missing values
income%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>0)

# Handling missing values
income<-income%>%group_by(Country)%>%filter(!mean(is.na(INCOME)) >= 0.2)
income%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>1)

# Filling in missing values
income<-income%>%group_by(Country)%>%mutate(INCOME = imputeTS::na_interpolation(INCOME))

# Final cleanup
income%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>0)
names(income)<-c("Country","Year","INCI")
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBUcmFuc2Zvcm1pbmcgYW5kIENsZWFuaW5nIC0gRWR1Y2F0aW9uIC0gRGV2ZWxvcG1lbnQgRmFjdG9yc1xuZWR1PC1yZWFkLmNzdignLi4vUmVzb3VyY2VzL1Jhdy9FZHVjYXRpb24gaW5kZXguY3N2JyxjaGVjay5uYW1lcz1UUlVFLGhlYWRlcj1UUlVFLHNlcD0nLCcsc3RyaW5nc0FzRmFjdG9ycz1GQUxTRSxza2lwPTUpXG5cbiMgUmVtb3ZlIFVud2FudGVkIEZpZWxkc1xuZWR1PC1zZWxlY3QoZWR1LCAtYyhIREkuUmFuayxYKSlcbmVkdTwtc2VsZWN0KGVkdSwgLWMod2hpY2goZ3JlcGwoXCJcXFxcLlwiLG5hbWVzKGVkdSkpKSkpXG5lZHU8LWhlYWQoZWR1LC0xNylcblxuIyBUcmFuc2Zvcm1cbmVkdTwtZ2F0aGVyKGVkdSxrZXk9J1llYXInLHZhbHVlPSdFRFUnLFgxOTkwOlgyMDE5KVxuXG4jIFN0cmVhbWxpbmVcbmVkdSRZZWFyPC1nc3ViKFwiWFwiLFwiXCIsZWR1JFllYXIpJT4lYXMubnVtZXJpYyhhcy5jaGFyYWN0ZXIoZWR1JFllYXIpKVxuZWR1JEVEVTwtYXMubnVtZXJpYyhlZHUkRURVKVxuZWR1PC1lZHUlPiVmaWx0ZXIoWWVhcj49MjAwMClcblxuIyBDaGVja2luZyBmb3IgbWlzc2luZyB2YWx1ZXNcbmVkdSU+JWdyb3VwX2J5KENvdW50cnkpJT4lbWlzc192YXJfc3VtbWFyeSgpJT4lZmlsdGVyKG5fbWlzcz4wKVxuXG4jIEhhbmRsaW5nIG1pc3NpbmcgdmFsdWVzXG5lZHU8LWVkdSU+JWdyb3VwX2J5KENvdW50cnkpJT4lZmlsdGVyKCFtZWFuKGlzLm5hKEVEVSkpID49IDAuMilcbmVkdSU+JWdyb3VwX2J5KENvdW50cnkpJT4lbWlzc192YXJfc3VtbWFyeSgpJT4lZmlsdGVyKG5fbWlzcz4xKVxuXG4jIEZpbGxpbmcgaW4gbWlzc2luZyB2YWx1ZXNcbmVkdTwtZWR1JT4lZ3JvdXBfYnkoQ291bnRyeSklPiVtdXRhdGUoRURVID0gaW1wdXRlVFM6Om5hX2ludGVycG9sYXRpb24oRURVKSlcblxuIyBGaW5hbCBjbGVhbnVwXG5lZHUlPiVncm91cF9ieShDb3VudHJ5KSU+JW1pc3NfdmFyX3N1bW1hcnkoKSU+JWZpbHRlcihuX21pc3M+MClcbm5hbWVzKGVkdSk8LWMoXCJDb3VudHJ5XCIsXCJZZWFyXCIsXCJFRElcIilcbmBgYCJ9 -->

```r
# Transforming and Cleaning - Education - Development Factors
edu<-read.csv('../Resources/Raw/Education index.csv',check.names=TRUE,header=TRUE,sep=',',stringsAsFactors=FALSE,skip=5)

# Remove Unwanted Fields
edu<-select(edu, -c(HDI.Rank,X))
edu<-select(edu, -c(which(grepl("\\.",names(edu)))))
edu<-head(edu,-17)

# Transform
edu<-gather(edu,key='Year',value='EDU',X1990:X2019)

# Streamline
edu$Year<-gsub("X","",edu$Year)%>%as.numeric(as.character(edu$Year))
edu$EDU<-as.numeric(edu$EDU)
edu<-edu%>%filter(Year>=2000)

# Checking for missing values
edu%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>0)

# Handling missing values
edu<-edu%>%group_by(Country)%>%filter(!mean(is.na(EDU)) >= 0.2)
edu%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>1)

# Filling in missing values
edu<-edu%>%group_by(Country)%>%mutate(EDU = imputeTS::na_interpolation(EDU))

# Final cleanup
edu%>%group_by(Country)%>%miss_var_summary()%>%filter(n_miss>0)
names(edu)<-c("Country","Year","EDI")
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->

