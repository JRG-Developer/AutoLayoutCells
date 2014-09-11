##AutoLayoutCells

`AutoLayoutCells` makes working with dynamic table view cells easy. It has a powerful, well-designed feature set:

* Ready-to-use table view cells for the most common use cases
* Built-in support for dynamic font and responding to font change notifications
* Drop-in support for dynamic height cells (one-liner method calls to `ALCellFactory`)
* Convenience method to set all cell values from a dictionary (using predefined keys)
* Automatic image loading from a URL on a background thread

###Installation With CocoaPods

The easiest way to add `AutoLayoutCells` to your project is using <a href="http://cocoapods.org/">CocoaPods</a>. Simply add the following line to your `Podfile`:

	pod 'AutoLayoutCells', '~> 0.3'

Then run `pod install` as you normally would.

New to CocoaPods? Check out <a href="http://www.raywenderlich.com/64546/introduction-to-cocoapods-2">this tutorial</a>, and you'll be setup in no time.

###Manual Installation

You should really use `CocoaPods` for the easiest setup. 

If you *really must do* manual installation, follow these steps:

1) Clone this repo locally onto your computer, or press `Download ZIP` to simply download the latest master commit.

2) Drag the `SharedCategories` and `TableViewCells` folders into your project, making sure `Copy items into destination group's folder (if needed)` is checked.

3) Add <a href="https://github.com/JRG-Developer/ALLabel">ALLabel</a> and <a href="https://github.com/JRG-Developer/AutoLayoutTextViews">AutoLayoutTextViews</a> to your project, which are dependencies of `AutoLayoutCells`.

###How to Use

Refer to the demo project `AutoLayoutCellsDemo` for an example of how to use this library. 

Note: the demo project uses CocoaPods, so you will first need to run `pod install` to setup its pod dependencies.

A detailed tutorial is coming soon!

###License

`AutoLayoutCells` is available under the MIT license (see the `LICENSE` file for more details).