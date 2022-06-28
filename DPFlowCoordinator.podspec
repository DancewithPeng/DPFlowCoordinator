#
#  Be sure to run `pod spec lint DPFlowCoordinator.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name = 'DPFlowCoordinator'
  s.version = '3.0'
  s.license = 'MIT'
  s.summary = '流程协调器，用于分离业务流程代码'
  s.homepage = 'https://github.com/DancewithPeng/DPFlowCoordinator.git'
  s.authors = { 'DancewithPeng' => 'dancewithpeng@gmail.com' }
  s.source = { :git => 'https://github.com/DancewithPeng/DPFlowCoordinator.git', :tag => s.version }

  s.platform = :ios, '13.0'

  s.source_files = 'DPFlowCoordinator/Sources/*.swift', 'DPFlowCoordinator/Sources/*.{h,m}', 'DPFlowCoordinator/*.h'
  s.swift_version  = '5.5'
end
