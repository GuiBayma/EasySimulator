source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

def common_targets()
  pod 'SwiftLint', '~> 0.27'
end

def unit_test_targets()
  pod 'Quick'
  pod 'Nimble'
  pod 'Nimble-Snapshots'
end

def ui_test_target()
  pod 'KIF'
end

target 'EasySimulator' do

  common_targets

  target 'EasySimulatorTests' do
    inherit! :search_paths
    unit_test_targets
  end

  target 'EasySimulatorKIFTests' do
    inherit! :search_paths
    ui_test_target
  end
end
