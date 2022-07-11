library(ggplot2)
library(dplyr)

# memanggil dataset
studentsPerf <- read.csv("D:/dataset/StudentsPerformance.csv",sep = ",")

# ringkasan data
View(studentsPerf)
str(studentsPerf)
summary(studentsPerf)
summary(male)
summary(female)
summary(All)
names(studentsPerf)

# mnghapus kolom lunch
studentsPerf <- studentsPerf[-4]

# memperbaiki nama kolom
names(studentsPerf) <- c("Gender","Race_Ethnicity","Parental_Level_of_Education","Test_Preparation","Math_Score","Reading_Score","Writing_Score")

#membuat dataset baru
male <- filter(studentsPerf,
               studentsPerf$Gender=="male")
male <- mutate(male,
               Total_Scores = Math_Score+Reading_Score+Writing_Score)
female <- filter(studentsPerf,
                 studentsPerf$Gender=="female")
female <- mutate(female,
               Total_Scores = Math_Score+Reading_Score+Writing_Score)
All <- studentsPerf
All <- mutate(All,
              Total_Scores = Math_Score+Reading_Score+Writing_Score)

matrix <- matrix(c(197.5,208.7,203.3),nrow = 3,ncol = 1)
matrix
colnames(matrix) <- c("Average")
newdata <- as.data.frame(matrix)
newdata$Gender <- c("male","female","all")

# membuat plot
# bar chart 1
bar <- ggplot(data = studentsPerf,
              aes(x = Parental_Level_of_Education, fill = Parental_Level_of_Education))+
  geom_bar(position = "dodge")+
  labs(x = "", fill = "Parental Level of Education")+
  theme(axis.text.x.bottom =element_blank(), axis.ticks = element_blank(),
        legend.position = "bottom",legend.box = "horizontal",legend.title = element_blank())+
  geom_text(aes(label = ..count..),
            stat = "count",
            vjust = -0.5)
bar

#bar chart 2
bar_2 <- ggplot(data = newdata, aes(x = Gender,y = Average, fill = Gender))+
  geom_bar(position = "dodge",stat = "identity")+
  theme(axis.text.x.bottom =element_blank(),axis.ticks = element_blank(),legend.position = "bottom",
        legend.box ='horizontal',legend.title = element_blank())+
  labs(x ="")+
  geom_text(aes(label = Average),
            vjust = -0.5)+
  scale_y_continuous(breaks = seq(0,250,50))
bar_2
