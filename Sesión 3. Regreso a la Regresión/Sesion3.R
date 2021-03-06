# Librerias
library(dplyr)
library(ggplot2)

# 1. Abrimos las bases
LAhomes <- read.csv("BDs/LAhomes.csv")
#restNYC <- read.csv("BDs/restNYC.csv") #
#twins <- read.csv("BDs/twins.csv") #NPI

head(LAhomes)
#head(restNYC)
#head(twins)

# # Experimento
# length(LAhomes$city)
# LAhomes$aleat <- rnorm(1594)

#################################
# 1. Precio de las casas en LA. #
#################################

# 0. Exploramos los datos: 
lapply(LAhomes, class)

# 1. Determinamos la formula
fmla <- price ~ sqft
#fmla <- price ~ aleat

# 2. Aplicamos el modelo
model <- lm(fmla, LAhomes)
print(model)

# 3. Checamos mayor informaci'on del modelo
summary(model)

# 4. Prediction 
LAhomes$pred1 <- predict(model)

# 5. Graficamos
ggplot(LAhomes, 
       aes(x = sqft, y = price)) + 
  geom_point() + 
  geom_line(aes(x = sqft, y = pred1), colour = "blue") + 
  theme_bw()   # Fondo blanco con rayas grises

# Preguntas... que tan buena es esta regresipn para explicar el precio de la vivienda?



##########################
# 2. Tasa de Mortalidad  #
##########################

# 1. Abrimos la base
health <- readxl::read_xls("BDs/health.xls")

# 2. Exploramos los datos
head(health)
lapply(health, class)

# 3. Creamos el modelo
fmla1 <- deathRate ~ doctorAvailability
fmla2 <- deathRate ~ hospitalAvailability
fmla3 <- deathRate ~ annualPerCapitaIncome
fmla4 <- deathRate ~ populationDensity
fmla5 <- deathRate ~ populationDensity + annualPerCapitaIncome + hospitalAvailability + doctorAvailability

# 4. Hacemos las regresiones

model1 <- lm(fmla1, health) 
summary(model1)

model2 <- lm(fmla2, health) 
summary(model2)

model3 <- lm(fmla3, health) 
summary(model3)

model4 <- lm(fmla4, health) 
summary(model4)

model5 <- lm(fmla5, health)
summary(model5)

# 5. Prediccion 
health$pred1 <- predict(model1)
health$pred2 <- predict(model2)
health$pred3 <- predict(model3)
health$pred4 <- predict(model4)
health$pred5 <- predict(model5)

# 6. Grafica

# Sobre popDensity, la mas significativa
ggplot(health, 
       aes(x = populationDensity, y = deathRate)) + 
  geom_point() + 
  geom_line(aes(x = populationDensity, y = pred4), colour = "blue") + 
  theme_bw()   # Fondo blanco con rayas grises

# Sobre DoctorAvailability
ggplot(health, 
       aes(x = doctorAvailability, y = deathRate)) + 
  geom_point() + 
  geom_line(aes(x = doctorAvailability, y = pred1), colour = "blue") + 
  theme_bw()   # Fondo blanco con rayas grises

# COmo podemos ver, en este caso el modelo casi no predice nada. 
# Y es por esto que esta variable no es significante.


