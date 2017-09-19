//
// Created by DTVD on 9/10/17.
// Copyright (c) 2017 orakaro. All rights reserved.
//

import Foundation

protocol DependencyInjectable {
    associatedtype Dependency = Void
    static func make(withDependency dependency: Dependency) -> Self
}