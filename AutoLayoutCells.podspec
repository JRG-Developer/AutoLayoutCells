Pod::Spec.new do |s|
  s.platform     = :ios
  s.ios.deployment_target = '7.0'
  s.name         = "AutoLayoutCells"
  s.version      = "0.1.0"
  s.summary      = "AutoLayoutCells is a collection of cells that make it easy to support dynamic cell height using auto layout."
  s.homepage     = "https://github.com/JRG-Developer/AutoLayoutCells"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Joshua Greene" => "jrg.developer@gmail.com" }
  s.source   	   = { :git => "https://github.com/JRG-Developer/AutoLayoutCells.git",
                     :tag => "#{s.version}"}
  s.requires_arc = true

  s.subspec 'TableViewCells' do |ss|
    ss.framework = "UIKit"

    ss.dependency 'AFNetworking+ImageActivityIndicator', '~> 1.0'
    ss.dependency 'ALLabel', '~> 1.0'
    ss.dependency 'AutoLayoutTextViews', '~> 1.0'
    ss.dependency 'UIView+AORefreshFont', '~> 1.0'

    ss.resource_bundles = {'ALTableViewCellsBundle' => ['AutoLayoutCells/TableViewCells/ResourcesBundle/*']}
    ss.source_files = "AutoLayoutCells/TableViewCells/*.{h,m}"
  end

end