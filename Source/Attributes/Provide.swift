//
//  Provide.swift
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

@propertyWrapper
public final class Provide<Class> {
    
    public let wrappedValue: (Injector) -> Class
    let name: String
    private let singletone: Bool
    private var singletoneValue: Class?
    
    public init(wrappedValue: @escaping (Injector) -> Class, name: String = "", singletone: Bool = true) {
        self.wrappedValue = wrappedValue
        self.name = name
        self.singletone = singletone
    }
    
    func getValue(form di: Injector) -> Class {
        var result: Class
        switch singletone {
        case true:
            if let value = singletoneValue {
                result = value
            } else {
                let value = wrappedValue(di)
                singletoneValue = value
                result = value
            }
        case false: result = wrappedValue(di)
        }
        return result
    }
}
