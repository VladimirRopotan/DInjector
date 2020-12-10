//
//  Injector.swift
//  DInjector
//
//  Created by Vladimir on 10.12.2020.
//  Copyright © 2020 RVladimir. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

public final class Injector {
    
    public static func setup(modules: InjectorModule...) -> Injector {
        return Injector(modules: modules)
    }
    
    private let modules: [InjectorModule]
    
    private init(modules: [InjectorModule]) {
        self.modules = modules
    }
    
    public func get<Class>(name: String = "") -> Class {
        var optionalDependency: Class?
        
        modules.forEach { module in
            Mirror(reflecting: module).children.forEach { child in
                guard
                    let provide = child.value as? Provide<Class>,
                    provide.name == name
                else { return }
                
                if optionalDependency != nil { fatalError("Found two or more provides for '\(Class.self)' with name \(name)") }
                optionalDependency = provide.getValue(form: self)
            }
        }
        guard let dependency = optionalDependency else { fatalError("Provide for '\(Class.self)' with name \(name) is no found") }
        return dependency
    }
    
}
