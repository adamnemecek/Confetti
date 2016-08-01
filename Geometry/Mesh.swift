//
//  Confetti
//
//  Created by Quentin Mathé on 02/06/2016.
//  Copyright © 2016 Quentin Mathé. All rights reserved.
//

import Foundation

/// A collection of vertices defining a surface with associated materials or 
/// textures.
protocol Mesh {
	var size: Size { get set }
	var materials: [Material] { get set }
}


class Plane: Mesh {

	var size: Size
	var materials = [Material]()

	init(size: Size) {
		self.size = size
	}
}
