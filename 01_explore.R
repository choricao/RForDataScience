source('LoadLibraries.R')

### Data Visualization with ggplot2 ###
## Aesthetic Mappings
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class)) # ggplots will only use six shapes at a time

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue", size = 4, shape = 16) # size unit: mm; shape range: 0 - 24

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))

## Facets
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2) # use facet_warp to facet plot by a single variable

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl) # use facet_grid to facet plot on the combination of two variables

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl) # use . to not facet in the rows or columns dimension

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

## Geometric Objects
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv)) # group won't add a legend

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv), show.legend = FALSE)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv)) # multiple geom functions

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + # global mappings
  geom_point(mapping = aes(color = class)) + # local mappings
  geom_smooth() 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(
    data = filter(mpg, class == "subcompact"),
    se = FALSE
  ) # local data argument in geom_smooth() overrides global data argument in ggplot()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE) # 6.1

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(mapping = aes(group = drv), se = FALSE) # 6.2

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE) # 6.3

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(se = FALSE) # 6.4

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(linetype = drv), se = FALSE) # 6.5

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() # 6.6

## Statistical Transformations
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut)) # default: stat = "count"

ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut)) # default: geom = "bar

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = price), stat = "identity") # override the default stat

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1)) # override the default mapping from transformed variables to aesthetics

ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  ) # draw greater attention to the statistical transformation

## Position Adjustments
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity)) # dafault: position = "stack"

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "identity", alpha = 1/5) # not useful for bars, because it overlaps them

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter") # add a small amount of random noise to each point to avoid "overplotting"

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter() # shorthand: geom_jitter()

## Coordinate Systems
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip() # coord_quickmap(): set aspect ratio correctly for maps; coord_polar(): use polar coordinates

## Layered Grammar of Graphics ##
# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(
#     mapping = aes(<MAPPING>),
#     stat = <STAT>,
#     position = <POSITION>
#   ) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION>
#
# Seven parameters to make a graph.
# DATA, GEOM_FUNCTION, and MAPPING are required.
# Defaults are available for STAT, POSITION, COORDINATE_FUNCTION, and FACET_FUNCTION.

### Data Transformation with dplyr ###
## Filter Rows with filter()
filter(flights, month == 1, day == 1)
jan1 <- filter(flights, month == 1, day == 1)
(dec25 <- filter(flights, month == 12, day == 25))

sqrt(2) ^ 2 == 2
near(sqrt(2) ^ 2, 2) # use near() to compare floating-point numbers

filter(flights, month == 11 | month == 12)
nov_dec <- filter(flights, month %in% c(11, 12))

df <- tibble(x = c(1, NA, 3))
filter(df, x > 1) # filter() excludes both FALSE and NA values
filter(df, is.na(x) | x > 1) # ask for them explicitly if you want to preserve missing values

filter(flights, arr_delay >= 120)
filter(flights, dest == "IAH" | dest == "HOU")
filter(flights, carrier %in% c("UA", "AA", "DL"))
filter(flights, month %in% c(7, 8, 9))
filter(flights, arr_delay > 120 & dep_delay <= 0)
filter(flights, (dep_time >= 0 & dep_time <= 600) | dep_time == 2400)
filter(flights, between(dep_time, 0, 600))
filter(flights, is.na(dep_time))

## Arrange Rows with arrange()
arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))

arrange(flights, desc(is.na(arr_delay)))
arrange(flights, desc(dep_delay))
arrange(flights, air_time)
arrange(flights, desc(distance))
arrange(flights, distance)
