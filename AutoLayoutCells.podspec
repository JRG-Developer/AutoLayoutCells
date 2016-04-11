Pod::Spec.new do |s|
  s.platform     = :ios
  s.ios.deployment_target = '7.0'
  s.name         = "AutoLayoutCells"
  s.version      = "0.10.2"
  s.summary      = "AutoLayoutCells makes working with dynamic table view cells easy."
  s.homepage     = "https://github.com/JRG-Developer/AutoLayoutCells"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Joshua Greene" => "jrg.developer@gmail.com" }
  s.source   	   = { :git => "https://github.com/JRG-Developer/AutoLayoutCells.git",
                     :tag => "#{s.version}"}
  s.requires_arc = true
  s.framework = "UIKit"
  
  s.subspec 'SharedCategories' do |ss|
    ss.dependency 'UIImageView+ALActivityIndicatorView', '~> 1.0'
    ss.xcconfig = { "FRAMEWORK_SEARCH_PATHS" => "$(PODS_ROOT)/UIImageView+ALActivityIndicatorView" }

    ss.source_files = "AutoLayoutCells/SharedCategories/*{h,m}"
  end

  s.subspec 'TableViewCells' do |ss|
    ss.dependency 'AutoLayoutCells/SharedCategories'
    ss.dependency 'ALLabel', '~> 2.0'
    ss.dependency 'AutoLayoutTextViews', '~> 1.1'

    ss.resource_bundles = {'ALTableViewCellsBundle' => ['AutoLayoutCells/TableViewCells/ResourcesBundle/*']}
    ss.source_files = "AutoLayoutCells/TableViewCells/*.{h,m}"
  end

end