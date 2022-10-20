########################################################
# Data Handling Lecture 5: Image Data
#
# Raster and Vector-based
########################################################


# SET UP -----------------

# load/install packages
library(raster) # for raster images
library(magick) # for wide range of raster and vector-based images 
library(xml2) # interpret svg files as XML
library(tesseract) # for OCR




### Generating a red image (RGB code: 255,0,0) -------------

# Step 1: Define the width and height of the image
width = 300; 
height = 300

# Step 2: Define the number of layers (RGB = 3)
layers = 3

# Step 3: Generate three matrices corresponding to Red, Green, and Blue values
red = matrix(255, nrow = height, ncol = width)
green = matrix(0, nrow = height, ncol = width)
blue = matrix(0, nrow = height, ncol = width)

# Step 4: Generate an array by combining the three matrices
image.array = array(c(red, green, blue), dim = c(width, height, layers))
dim(image.array)

# Step 5: Create RasterBrick
image = brick(image.array)
print(image)

# Step 6: Plot RGB
plotRGB(image)

# Step 7: (Optional) Save to disk
png(filename = "red.png", width = width, height = height, units = "px")
plotRGB(image)
dev.off()




## Vector-images in R --------------


# Download and read svg image from url
URL <- "https://upload.wikimedia.org/wikipedia/commons/1/1b/R_logo.svg"
Rlogo_xml <- read_xml(URL)

# Data structure
Rlogo_xml 
xml_structure(Rlogo_xml)

# Raw data
Rlogo_text <- as.character(Rlogo_xml)

# Plot
svg_img = image_read_svg(Rlogo_text)
image_info(svg_img)
svg_img




### Use case: Optical Character Recognition (OCR) ------------------


# fetch and show image
img <- image_read("https://s3.amazonaws.com/libapps/accounts/30502/images/new_york_times.png")
print(img)

# zoom in on headline
headline <- 
     image_crop(image = img, geometry = '806x180')

headline

# Extract text via OCR
headline_text <- image_ocr(headline)
cat(headline_text)




