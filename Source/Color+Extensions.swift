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

#if os(iOS) || os(tvOS)
import UIKit
public typealias Color = UIColor
#else
import AppKit
public typealias Color = NSColor
#endif

extension Color {

    static func from(string: String) -> Color {
        switch string.lowercased() {

        case _ where string.starts(with: "#"):
            let scanner = Scanner(string: string)
            scanner.scanLocation = 1

            var color: UInt32 = 0
            scanner.scanHexInt32(&color)

            let mask = 0xFF
            let red = Int(color >> 16) & mask
            let green = Int(color >> 8) & mask
            let blue = Int(color) & mask

            return .init(red: CGFloat(red) / 255.0,
                         green: CGFloat(green) / 255.0,
                         blue: CGFloat(blue) / 255.0,
                         alpha: 1)

        case _ where nativeMap.keys.contains(string):
            return nativeMap[string]!

        case _ where hexStringMap.keys.contains(string):
            return .from(string: hexStringMap[string]!)

        default: return .clear
        }
    }

    fileprivate static var nativeMap: [String: Color] = [
        "black": .black,
        "darkgray": .darkGray,
        "darkgrey": .darkGray,
        "lightgray": .lightGray,
        "lightgrey": .lightGray,
        "white": .white,
        "gray": .gray,
        "grey": .gray,
        "red": .red,
        "green": .green,
        "blue": .blue,
        "cyan": .cyan,
        "yellow": .yellow,
        "magenta": .magenta,
        "orange": .orange,
        "purple": .purple,
        "brown": .brown,
        "clear": .clear,
        "transparent": .clear,
        "": .clear
    ]

    fileprivate static var hexStringMap: [String: String] = [
        "navy": "#000080",
        "darkblue": "#00008b",
        "mediumblue": "#0000cd",
        "darkgreen": "#006400",
        "teal": "#008080",
        "darkcyan": "#008b8b",
        "deepskyblue": "#00bfff",
        "darkturquoise": "#00ced1",
        "mediumspringgreen": "#00fa9a",
        "lime": "#00ff00",
        "springgreen": "#00ff7f",
        "aqua": "#00ffff",
        "midnightblue": "#191970",
        "dodgerblue": "#1e90ff",
        "lightseagreen": "#20b2aa",
        "forestgreen": "#228b22",
        "seagreen": "#2e8b57",
        "darkslategray": "#2f4f4f",
        "darkslategrey": "#2f4f4f",
        "limegreen": "#32cd32",
        "mediumseagreen": "#3cb371",
        "turquoise": "#40e0d0",
        "royalblue": "#4169e1",
        "steelblue": "#4682b4",
        "darkslateblue": "#483d8b",
        "mediumturquoise": "#48d1cc",
        "indigo ": "#4b0082",
        "darkolivegreen": "#556b2f",
        "cadetblue": "#5f9ea0",
        "cornflowerblue": "#6495ed",
        "rebeccapurple": "#663399",
        "mediumaquamarine": "#66cdaa",
        "dimgray": "#696969",
        "dimgrey": "#696969",
        "slateblue": "#6a5acd",
        "olivedrab": "#6b8e23",
        "slategray": "#708090",
        "slategrey": "#708090",
        "lightslategray": "#778899",
        "lightslategrey": "#778899",
        "mediumslateblue": "#7b68ee",
        "lawngreen": "#7cfc00",
        "chartreuse": "#7fff00",
        "aquamarine": "#7fffd4",
        "maroon": "#800000",
        "olive": "#808000",
        "skyblue": "#87ceeb",
        "lightskyblue": "#87cefa",
        "blueviolet": "#8a2be2",
        "darkred": "#8b0000",
        "darkmagenta": "#8b008b",
        "saddlebrown": "#8b4513",
        "darkseagreen": "#8fbc8f",
        "lightgreen": "#90ee90",
        "mediumpurple": "#9370db",
        "darkviolet": "#9400d3",
        "palegreen": "#98fb98",
        "darkorchid": "#9932cc",
        "yellowgreen": "#9acd32",
        "sienna": "#a0522d",
        "lightblue": "#add8e6",
        "greenyellow": "#adff2f",
        "paleturquoise": "#afeeee",
        "lightsteelblue": "#b0c4de",
        "powderblue": "#b0e0e6",
        "firebrick": "#b22222",
        "darkgoldenrod": "#b8860b",
        "mediumorchid": "#ba55d3",
        "rosybrown": "#bc8f8f",
        "darkkhaki": "#bdb76b",
        "silver": "#c0c0c0",
        "mediumvioletred": "#c71585",
        "indianred ": "#cd5c5c",
        "peru": "#cd853f",
        "chocolate": "#d2691e",
        "tan": "#d2b48c",
        "thistle": "#d8bfd8",
        "orchid": "#da70d6",
        "goldenrod": "#daa520",
        "palevioletred": "#db7093",
        "crimson": "#dc143c",
        "gainsboro": "#dcdcdc",
        "plum": "#dda0dd",
        "burlywood": "#deb887",
        "lightcyan": "#e0ffff",
        "lavender": "#e6e6fa",
        "darksalmon": "#e9967a",
        "violet": "#ee82ee",
        "palegoldenrod": "#eee8aa",
        "lightcoral": "#f08080",
        "khaki": "#f0e68c",
        "aliceblue": "#f0f8ff",
        "honeydew": "#f0fff0",
        "azure": "#f0ffff",
        "sandybrown": "#f4a460",
        "wheat": "#f5deb3",
        "beige": "#f5f5dc",
        "whitesmoke": "#f5f5f5",
        "mintcream": "#f5fffa",
        "ghostwhite": "#f8f8ff",
        "salmon": "#fa8072",
        "antiquewhite": "#faebd7",
        "linen": "#faf0e6",
        "lightgoldenrodyellow": "#fafad2",
        "oldlace": "#fdf5e6",
        "fuchsia": "#ff00ff",
        "deeppink": "#ff1493",
        "orangered": "#ff4500",
        "tomato": "#ff6347",
        "hotpink": "#ff69b4",
        "coral": "#ff7f50",
        "darkorange": "#ff8c00",
        "lightsalmon": "#ffa07a",
        "lightpink": "#ffb6c1",
        "pink": "#ffc0cb",
        "gold": "#ffd700",
        "peachpuff": "#ffdab9",
        "navajowhite": "#ffdead",
        "moccasin": "#ffe4b5",
        "bisque": "#ffe4c4",
        "mistyrose": "#ffe4e1",
        "blanchedalmond": "#ffebcd",
        "papayawhip": "#ffefd5",
        "lavenderblush": "#fff0f5",
        "seashell": "#fff5ee",
        "cornsilk": "#fff8dc",
        "lemonchiffon": "#fffacd",
        "floralwhite": "#fffaf0",
        "snow": "#fffafa",
        "lightyellow": "#ffffe0",
        "ivory": "#fffff0"
    ]
}
