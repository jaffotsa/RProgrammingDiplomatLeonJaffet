# We're going to analyze the prices for Crude Oil for members of the OPEC. The data used for this code es available at: https://asb.opec.org/data/ASB_Data.php
# For this case, I used the Data available for monthly prices for "Mexico Istmo", between january 1983 and december 2019

library(openxlsx)
library(xts)
library(dynlm)
library(mFilter)


ex = read.xlsx(file.choose(), sheet = 1)

MexicoItsmo = data.frame(Petroleo = ex$Mexico.Itsmo)

MexicoItsmo

Serie = ts(MexicoItsmo$Petroleo, start = c(1983,1),
           end = c(2019,12), frequency = 12)

class(Serie)
Serie

# Boxplot para estudiar la estacionalidad

boxplot(Serie ~ cycle(Serie))


# Autocorrelacion y la autocorrelacion parcial

acf(Serie)

pacf(Serie)

# Graficar

plot(Serie)

# Modelo Aditivo

modeloaditivo = decompose(Serie)
plot(modeloaditivo)

# Estimar la tendencia

Tendencia = modeloaditivo$trend
plot(Tendencia)

# Estimar el término estocastico

Estoc = modeloaditivo$random
plot(Estoc)

# Estimar el término Estacional

Estac = modeloaditivo$seasonal
plot(Estac)

# Estimar el valor observado

Observ = modeloaditivo$x
plot(Observ)
