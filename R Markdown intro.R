library("ggplot2")
library("palmerpenguins")

ggplot(data = penguins) + 
  geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g, color=species)) +
  labs(title = "Palmer Penguins: Body mass vs Flipper Length", subtitle = "Sample of three penguin species", 
       caption = "Data collected by Dr. Gorman")

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x=color, fill=cut)) + 
  facet_wrap(~cut)


ggplot(data, aes(x=distance, y= dep_delay)) +
  geom_point() + geom_smooth()


ggplot(data = penguins) + 
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, size = year))


install.packages("rmarkdown")