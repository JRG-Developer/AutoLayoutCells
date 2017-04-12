platform :ios, "7.0"

workspace 'AutoLayoutCells'
project 'AutoLayoutCells'

target "AutoLayoutCellsDemo" do
  project 'AutoLayoutCellsDemo/AutoLayoutCellsDemo'
  pod 'AutoLayoutCells', :path => '.'
end

target "AutoLayoutCells" do
  pod 'ALLabel', '~> 2.0'
  pod 'AutoLayoutTextViews', '~> 1.2'
  pod 'UIImageView+ALActivityIndicatorView', '~> 1.0'
  
  target "AutoLayoutCellsTests" do
    pod 'Expecta', '~> 1.0'
    pod 'OCMock', '~> 3.0'
  end
end
