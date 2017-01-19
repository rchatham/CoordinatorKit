Pod::Spec.new do |s|
  s.name             = 'CoordinatorKit'
  s.version          = '0.0.6'
  s.summary          = "A framework that implements the coordinator pattern in a fashion similar to how UIViewControllers work."
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.description      = <<-DESC
  TODO: Add long description of the pod here.
                       DESC


  s.homepage         = "https://github.com/nathanlanza/CoordinatorKit"
  s.ios.deployment_target = '9.0'
  s.source           = { :git => "https://github.com/nathanlanza/CoordinatorKit.git", :tag => s.version }

  s.framework        = "UIKit"

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nathan Lanza' => 'nathan@lanza.io' }
  s.social_media_url = 'https://twitter.com/nlanzaio'

  s.source_files = 'Source/*.swift'
  
end
