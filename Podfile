platform :ios, "7.0"

workspace 'AutoLayoutCells'
xcodeproj 'AutoLayoutCells'

target "AutoLayoutCellsDemo" do
  xcodeproj 'AutoLayoutCellsDemo/AutoLayoutCellsDemo'
  pod 'AutoLayoutCells', :path => '.'
end

target "AutoLayoutCells" do
    pod 'ALLabel', '~> 2.0'
    pod 'AutoLayoutTextViews', '~> 1.0'
    pod 'UIImageView+ALActivityIndicatorView', '~> 1.0'
end

target "AutoLayoutCellsTests" do
    pod 'ALLabel', '~> 2.0'
    pod 'AutoLayoutTextViews', '~> 1.0'
    pod 'UIImageView+ALActivityIndicatorView', '~> 1.0'
  pod 'Expecta', '~> 1.0'
  pod 'OCMock', '~> 3.0'
end
