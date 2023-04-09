# Flutter image ruler

The main goal with this project was to create a way to calculate the size of something in an image after calibrating it based on the size of a known object on the same image.

## How it was done

### Widgets
A Stack widget was used to keep the widgets on top of each other and the layers were places as:

- Image
- CustomPaint (Canvas)
- GestureDetector

The **GestureDetector** is used to capture the location of the taps and the **CustomPaint** is used to draw the dots and lines on top of the image where the person clicked.

On top of everything there's also a InteractiveViewer to allow for zooming both the Image and the CustomPaint, which makes it easier to select the points with more precision.

#### CustomPaint
For the CustomPaint it was necessary to create a controller to hold the state, manage the selected points and notify the Canvas to be redrawn.

### Logic
The first step is to calibrate the ratio by having the user clicking on two dots of a known object and informing the size in centimeters.

With the distance in pixels and the stated size in centimeters it's possible to determine the ratio, and therefore determine the size in centimeters of any other two points selected later on.

## Print
<img src="https://user-images.githubusercontent.com/1608564/230801453-bc2f8066-a5c1-4abd-8898-5ec99ce62702.png" width="50%"/>

