Face_Mill is a CNC programming utility that creates a climb milling CNC program which can be used to machine a rectangular flat surface.


Dependencies:
This application requires installation of [Ruby](https://www.ruby-lang.org/en/) 2.2.2, the most recent stable version at the time of publishing.


Executing the application:
Download the .zip file and extract all files to a directory of your choice. Fire up your console and navigate to this directory. Run:
```bash
ruby Face_Mill.rb
```
You will then be prompted to provide various inputs. Type in your input value and press enter. Once you have finished providing inputs, a CNC program will appear in your console. Copy the text and save it into a file with an appropriate format for your CNC machine control.


CNC Machine Setup:
The tool will rapidly approach the workpiece in the +X direction from the -X direction. It will then start cutting in the +Y direction. On the machine, X=0 and Y=0 should be set to the furthest -X and -Y point on the workpiece, with empty space on the -X side of the workpiece. Before running your CNC program, move the tool to the empty space to the -X side of the workpiece, and set your tool at the Z depth for your desired axial depth of cut.


Author:
This application was authored by Nick Edwards in 2015. To contribute to this code base, create a pull request to https://github.com/edwardsCNC/Face_Mill


MIT License:
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.