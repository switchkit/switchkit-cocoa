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
        case "black": return .black
        case "darkgray", "darkgrey": return .darkGray
        case "lightgray", "lightgrey": return .lightGray
        case "white": return .white
        case "gray","grey": return .gray
        case "red": return .red
        case "green": return .green
        case "blue": return .blue
        case "cyan": return .cyan
        case "yellow": return .yellow
        case "magenta": return .magenta
        case "orange": return .orange
        case "purple": return .purple
        case "brown": return .brown
        case "clear", "transparent", "": return .clear
        case "navy": return .from(string: "#000080")
        case "darkblue": return .from(string: "#00008b")
        case "mediumblue": return .from(string: "#0000cd")
        case "darkgreen": return .from(string: "#006400")
        case "teal": return .from(string: "#008080")
        case "darkcyan": return .from(string: "#008b8b")
        case "deepskyblue": return .from(string: "#00bfff")
        case "darkturquoise": return .from(string: "#00ced1")
        case "mediumspringgreen": return .from(string: "#00fa9a")
        case "lime": return .from(string: "#00ff00")
        case "springgreen": return .from(string: "#00ff7f")
        case "aqua": return .from(string: "#00ffff")
        case "midnightblue": return .from(string: "#191970")
        case "dodgerblue": return .from(string: "#1e90ff")
        case "lightseagreen": return .from(string: "#20b2aa")
        case "forestgreen": return .from(string: "#228b22")
        case "seagreen": return .from(string: "#2e8b57")
        case "darkslategray", "darkslategrey": return .from(string: "#2f4f4f")
        case "limegreen": return .from(string: "#32cd32")
        case "mediumseagreen": return .from(string: "#3cb371")
        case "turquoise": return .from(string: "#40e0d0")
        case "royalblue": return .from(string: "#4169e1")
        case "steelblue": return .from(string: "#4682b4")
        case "darkslateblue": return .from(string: "#483d8b")
        case "mediumturquoise": return .from(string: "#48d1cc")
        case "indigo ": return .from(string: "#4b0082")
        case "darkolivegreen": return .from(string: "#556b2f")
        case "cadetblue": return .from(string: "#5f9ea0")
        case "cornflowerblue": return .from(string: "#6495ed")
        case "rebeccapurple": return .from(string: "#663399")
        case "mediumaquamarine": return .from(string: "#66cdaa")
        case "dimgray", "dimgrey": return .from(string: "#696969")
        case "slateblue": return .from(string: "#6a5acd")
        case "olivedrab": return .from(string: "#6b8e23")
        case "slategray", "slategrey": return .from(string: "#708090")
        case "lightslategray", "lightslategrey": return .from(string: "#778899")
        case "mediumslateblue": return .from(string: "#7b68ee")
        case "lawngreen": return .from(string: "#7cfc00")
        case "chartreuse": return .from(string: "#7fff00")
        case "aquamarine": return .from(string: "#7fffd4")
        case "maroon": return .from(string: "#800000")
        case "olive": return .from(string: "#808000")
        case "skyblue": return .from(string: "#87ceeb")
        case "lightskyblue": return .from(string: "#87cefa")
        case "blueviolet": return .from(string: "#8a2be2")
        case "darkred": return .from(string: "#8b0000")
        case "darkmagenta": return .from(string: "#8b008b")
        case "saddlebrown": return .from(string: "#8b4513")
        case "darkseagreen": return .from(string: "#8fbc8f")
        case "lightgreen": return .from(string: "#90ee90")
        case "mediumpurple": return .from(string: "#9370db")
        case "darkviolet": return .from(string: "#9400d3")
        case "palegreen": return .from(string: "#98fb98")
        case "darkorchid": return .from(string: "#9932cc")
        case "yellowgreen": return .from(string: "#9acd32")
        case "sienna": return .from(string: "#a0522d")
        case "lightblue": return .from(string: "#add8e6")
        case "greenyellow": return .from(string: "#adff2f")
        case "paleturquoise": return .from(string: "#afeeee")
        case "lightsteelblue": return .from(string: "#b0c4de")
        case "powderblue": return .from(string: "#b0e0e6")
        case "firebrick": return .from(string: "#b22222")
        case "darkgoldenrod": return .from(string: "#b8860b")
        case "mediumorchid": return .from(string: "#ba55d3")
        case "rosybrown": return .from(string: "#bc8f8f")
        case "darkkhaki": return .from(string: "#bdb76b")
        case "silver": return .from(string: "#c0c0c0")
        case "mediumvioletred": return .from(string: "#c71585")
        case "indianred ": return .from(string: "#cd5c5c")
        case "peru": return .from(string: "#cd853f")
        case "chocolate": return .from(string: "#d2691e")
        case "tan": return .from(string: "#d2b48c")
        case "thistle": return .from(string: "#d8bfd8")
        case "orchid": return .from(string: "#da70d6")
        case "goldenrod": return .from(string: "#daa520")
        case "palevioletred": return .from(string: "#db7093")
        case "crimson": return .from(string: "#dc143c")
        case "gainsboro": return .from(string: "#dcdcdc")
        case "plum": return .from(string: "#dda0dd")
        case "burlywood": return .from(string: "#deb887")
        case "lightcyan": return .from(string: "#e0ffff")
        case "lavender": return .from(string: "#e6e6fa")
        case "darksalmon": return .from(string: "#e9967a")
        case "violet": return .from(string: "#ee82ee")
        case "palegoldenrod": return .from(string: "#eee8aa")
        case "lightcoral": return .from(string: "#f08080")
        case "khaki": return .from(string: "#f0e68c")
        case "aliceblue": return .from(string: "#f0f8ff")
        case "honeydew": return .from(string: "#f0fff0")
        case "azure": return .from(string: "#f0ffff")
        case "sandybrown": return .from(string: "#f4a460")
        case "wheat": return .from(string: "#f5deb3")
        case "beige": return .from(string: "#f5f5dc")
        case "whitesmoke": return .from(string: "#f5f5f5")
        case "mintcream": return .from(string: "#f5fffa")
        case "ghostwhite": return .from(string: "#f8f8ff")
        case "salmon": return .from(string: "#fa8072")
        case "antiquewhite": return .from(string: "#faebd7")
        case "linen": return .from(string: "#faf0e6")
        case "lightgoldenrodyellow": return .from(string: "#fafad2")
        case "oldlace": return .from(string: "#fdf5e6")
        case "fuchsia": return .from(string: "#ff00ff")
        case "deeppink": return .from(string: "#ff1493")
        case "orangered": return .from(string: "#ff4500")
        case "tomato": return .from(string: "#ff6347")
        case "hotpink": return .from(string: "#ff69b4")
        case "coral": return .from(string: "#ff7f50")
        case "darkorange": return .from(string: "#ff8c00")
        case "lightsalmon": return .from(string: "#ffa07a")
        case "lightpink": return .from(string: "#ffb6c1")
        case "pink": return .from(string: "#ffc0cb")
        case "gold": return .from(string: "#ffd700")
        case "peachpuff": return .from(string: "#ffdab9")
        case "navajowhite": return .from(string: "#ffdead")
        case "moccasin": return .from(string: "#ffe4b5")
        case "bisque": return .from(string: "#ffe4c4")
        case "mistyrose": return .from(string: "#ffe4e1")
        case "blanchedalmond": return .from(string: "#ffebcd")
        case "papayawhip": return .from(string: "#ffefd5")
        case "lavenderblush": return .from(string: "#fff0f5")
        case "seashell": return .from(string: "#fff5ee")
        case "cornsilk": return .from(string: "#fff8dc")
        case "lemonchiffon": return .from(string: "#fffacd")
        case "floralwhite": return .from(string: "#fffaf0")
        case "snow": return .from(string: "#fffafa")
        case "lightyellow": return .from(string: "#ffffe0")
        case "ivory": return .from(string: "#fffff0")
        case _ where string.starts(with: "#"):
            let scanner = Scanner(string: string)
            scanner.scanLocation = 1

            var color:UInt32 = 0
            scanner.scanHexInt32(&color)

            let mask = 0x000000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask

            let red   = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue  = CGFloat(b) / 255.0

            return .init(red:red, green:green, blue:blue, alpha:1)
        default: return .clear
        }
    }
}
