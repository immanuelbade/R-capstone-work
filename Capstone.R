library(tidyverse)
library(here)
library(skimr)
library(janitor)
library(lubridate)


daily_activity <- read.csv("/Users/shashiifather/Fitabase Data/dailyActivity_merged.csv")
daily_sleep <- read_csv("/Users/shashiifather/Fitabase Data/sleepDay_merged.csv")
daily_weight <- read_csv("/Users/shashiifather/Fitabase Data/weightLogInfo_merged.csv")


str(daily_activity)

skim_without_charts(daily_activity)

skim_without_charts(daily_sleep)

skim_without_charts(daily_weight)


daily_activity <- daily_activity %>%
  mutate(day_of_week = wday(mdy(ActivityDate), label = TRUE, abbr = FALSE),
         total_active_hours = (VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes)/60,
         sedentary_hours = SedentaryMinutes/60,
         date = mdy(ActivityDate))
glimpse(daily_activity)


daily_sleep <- daily_sleep %>%
  mutate(day_of_week = wday(mdy_hms(SleepDay), label = TRUE, abbr = FALSE),
         total_hours_as_sleep = TotalMinutesAsleep / 60,
         total_hours_in_bed = TotalTimeInBed/60,
         date = mdy_hms(SleepDay))
glimpse(daily_sleep)


daily_weight <- daily_weight %>%
  mutate(date = mdy_hms(Date), day_of_week = wday(mdy_hms(Date), label = TRUE, abbr = FALSE))
glimpse(daily_weight)


ggplot(data = daily_activity) + 
  geom_col(mapping = aes(x = day_of_week, y = TotalSteps), fill="orange")


ggplot(data = daily_activity) + 
  geom_col(mapping = aes(x = day_of_week, y = VeryActiveMinutes), fill="blue")


ggplot(data = daily_activity) + 
  geom_col(mapping = aes(x = day_of_week, y = Calories), fill="purple")


ggplot(data = daily_activity) + 
  geom_point(mapping = aes(x = TotalSteps, y = Calories), color = "orange") +
  geom_smooth(mapping = aes(x = TotalSteps, y = Calories))


ggplot(data = daily_activity) + 
  geom_jitter(mapping = aes(x = TotalSteps, y = SedentaryMinutes), color = "purple") + 
  geom_smooth(mapping = aes(x = TotalSteps, y = SedentaryMinutes))



daily_activity_type <- daily_activity %>% 
  pivot_longer(cols = ends_with("ActiveMinutes"),
               names_to = "ActiveType",
               values_to = "ActiveMinutes")

ggplot(data = daily_activity_type) + 
  geom_point(mapping = aes(x = Calories, y = ActiveMinutes, color = ActiveType)) + 
  geom_smooth(mapping = aes(x = Calories, y = ActiveMinutes), color = "red")



ggplot(data = daily_sleep) + 
  geom_col(aes(x=day_of_week, y = total_hours_as_sleep, fill = day_of_week))


activity_sleep <- merge(daily_activity, daily_sleep, 
                        by = c('Id', by.y = 'date'))

ggplot(data=activity_sleep) +
  geom_jitter(mapping = aes(x = total_hours_as_sleep, y = TotalSteps), color="coral1") +
  geom_smooth(mapping = aes(x = total_hours_as_sleep, y = TotalSteps))


activity_weight <- merge(daily_activity, daily_weight, 
                         by = c('Id', by.y = 'date'))

ggplot(data=activity_weight) + 
  geom_violin(mapping = aes(x = VeryActiveMinutes, y = WeightKg), fill = "darkturquoise" )























