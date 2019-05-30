//
//  SwitchKit
//
//  Copyright (c) 2019-Present SwitchKit Team - https://github.com/SwitchKit
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

extension SwitchKit {

    private static var requestModifiers = [String: ((URLRequest) -> URLRequest)]()

    public var requestModifier: ((URLRequest) -> URLRequest) {
        get {
            let instance = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return SwitchKit.requestModifiers[instance] ?? { $0 }
        }
        set(newValue) {
            let instance = String(format: "%p", unsafeBitCast(self, to: Int.self))
            SwitchKit.requestModifiers[instance] = newValue
        }
    }

    @discardableResult
    public func load(from: String, completion: ((Error?) -> Void)? = nil) -> SwitchKitLoadRequest {
        let load = SwitchKitLoadRequest(switchKit: self, url: from)
        load.now(completion: completion)
        return load
    }
}

public class SwitchKitLoadRequest {
    internal let switchKit: SwitchKit
    internal let url: String

    internal init(switchKit: SwitchKit, url: String) {
        self.switchKit = switchKit
        self.url = url
    }

    public func now(completion: ((Error?) -> Void)? = nil) {
        guard let url = URL(string: self.url) else {
            completion?(NSError(domain: "io.github.switchkit", code: 1, userInfo: nil))
            return
        }
        let request = switchKit.requestModifier(URLRequest(url: url))
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion?(error)
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: String] {
                object.forEach { key, value in self.switchKit.setValue(value, forKey: key) }
                completion?(nil)
            } else {
                completion?(NSError(domain: "io.github.switchkit", code: 2, userInfo: nil))
            }
        }.resume()
    }

    public func every(seconds: TimeInterval, completion: ((Error?) -> Void)? = nil) -> Timer {
        return Timer.scheduledTimer(withTimeInterval: seconds, repeats: true) { _ in
            self.now(completion: completion)
        }
    }
}
