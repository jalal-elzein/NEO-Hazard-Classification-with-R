data <- read.csv("neo_v2.csv")
data

# examine what features we have
columns <- colnames(data)
columns

# explain the features
# ID (int): unique identifier for each asteroid TODO: by who and does it have a meaning
# NAME (str): name assigned to the object by NASA
# EST_DIAMETER_MIN (float): minimum estimate of the diameter of the object in kilometers
# EST_DIAMETER_MAX (float): maximum estimate of the diameter of the object in kilometers
# RELATIVE_VELOCITY (float): Velocity relaative to Earth in Kmph
# MISS_DISTANCE (float): Distance in kilometers missed TODO: missing what?
# * ORBITING_BODY (str): Planet that the asteroid orbits
# * SENTRY_OBJECT (bool): Whether the asteroid is included in the sentry-automated collision monitoring system
# ABSOLUTE_MAGNITUDE (float): Describes the intinsic luminosity
# HAZARDOUS (bool): Whether or not an asteroid is harmful

# do we need to convert datatypes
# we need to encode bool

# do we need to convert units?

# we need to exclude the name and id columns from the features
raw_features <- data[c()]

# est min and max diameters could be possibly combined later with pca
# check number of unique values for orbiting body and sentry object
# show class imbalance between non/hazardous
# create a new dataset with less class imbalance

