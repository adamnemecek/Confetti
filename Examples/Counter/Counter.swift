/**
	Copyright (C) 2017 Quentin Mathe
 
	Date:  July 2017
	License:  MIT
 */

import Foundation
import Confetti
import Tapestry

class Counter: Viewpoint<Int>, UI {

    override func generate() -> Item {
        return column(items:
            [label(frame: Rect(x: 0, y: 0, width: 200, height: 20), text: "0"),
            row(items: [
                button(frame: Rect(x: 0, y: 0, width: 100, height: 20), text: "+") { value += 1 },
                button(frame: Rect(x: 0, y: 0, width: 100, height: 20), text: "-") { value += 1 }
            ])]
        )
    }
}
