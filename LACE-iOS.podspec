Pod::Spec.new do |spec|
    # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    #
    #  These will help people to find your library, and whilst it
    #  can feel like a chore to fill in it's definitely to your advantage. The
    #  summary should be tweet-length, and the description more in depth.
    #

    spec.name               = 'LACE-iOS'
    spec.version            = '1.0.0'
    spec.summary            = 'LACE, local principal curve'
    spec.description        = 'A C++ implementation of the local principal curve (Lpc) algorithm described in Eur. Phys. J. C (2014) 74:2832'
    spec.homepage           = 'https://github.com/UniversityofWarwick/LACE'
    spec.license            = { type: 'Boost Software License, Version 1, (Aug 17 2003)', file: 'LACE/LICENSE_1_0.txt' }
    spec.author             = { 'John Back' => 'J.J.Back@warwick.ac.uk' }
    spec.source             = { :git => "https://github.com/jonkan/LACE-iOS.git", :tag => "v#{spec.version}" }

    spec.platform = :ios
    spec.ios.deployment_target = '8.0'

    spec.requires_arc = true
    spec.module_name = 'LACE'
    spec.prepare_command = 'git submodule update --init'
    # spec.prepare_command = 'git submodule update --init && make iframework'
    spec.vendored_frameworks = ['build/framework/LACE.framework', 'build/framework/Eigen.framework']
end
