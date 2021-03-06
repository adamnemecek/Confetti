//
//  Confetti
//
//  Created by Quentin Mathé on 02/06/2016.
//  Copyright © 2016 Quentin Mathé. All rights reserved.
//

import Foundation
import Tapestry

public protocol Geometry {

	/// The coordinate space transformation to obtain position, 
	/// orientation/rotation, and scale of an object from its parent coordinate
	/// space.
	///
	/// This is used to convert geometrical values from the parent coordinate 
	/// space to the object coordinate space. For converting geometry values 
	/// in the reverse direction, the invert matrix can be used.
	var transform: Matrix4 { get set }
	/// The center (x, y, z) of the object expressed in the parent coordinate
	/// space.
	///
	/// The position is derived from transform.
	var position: Position { get set }
	/// The top-left origin (x, y) of the object in the parent coordinate space,
	/// but constrained to a Z plane passing through the center of the object
	/// and tracking the rotation of the object.
	///
	/// This is usually useless when working with 3D objects which aren't planes.
	///
	/// The origin is derived from position and size.
	var origin: Point { get set }
	/// The coordinate space transformation to obtain the anchor point used to
	/// manipulate the object and apply geometry changes.
	var pivot: Matrix4 { get set }
	/// The anchor point used to manipulate the object and apply geometry changes.
	///
	/// Can be used to position the pivot.
	///
	/// The anchor point is derived from position and pivot.
	var anchor: Position { get set }
	/// The dimensions (x, y, z) of the object expressed in the world coordinate 
	/// space.
	///
	/// The size is derived from the mesh.
	var size: Size { get set }
	/// The dimensions (x, y) of the object in the parent coordinate space,
	/// but constrained to a Z plane passing through the center of the object
	/// and tracking the rotation of the object.
	///
	/// This is usually useless when working with 3D objects which aren't planes.
	///
	/// The extent is derived from origin and size.
	var extent: Extent { get set }
	var frame: Rect { get }
	/// The orientation of the object according to its width and height, 
	/// without considering its rotation and parent coordinate space.
	///
	/// This is usually useless when working with 3D objects which aren't planes.
	///
	/// Changing the orientation, swaps the width and height values.
	var orientation: Orientation { get set }
	var mesh: Mesh { get set }
}


public extension Geometry {

	public var position: Position {
		get { return Position(x: transform.m14, y: transform.m24, z: transform.m34) }
		set { transform.m14 = newValue.x; transform.m24 = newValue.y }
	}
	public var size: Size {
		get { return mesh.size }
		set { mesh.size = newValue }
	}
	// TODO: Implement converting between world and parent coordinate spaces as 
	// documented in Geometry.extent.
	public var extent: Extent {
		get { return Extent(width: mesh.size.x, height: mesh.size.y) }
		set { size = Size(x: newValue.width, y: newValue.height, z: size.z) }
	}
	public var frame: Rect {
		get { return Rect(origin: origin, extent: extent) }
	}
	public var anchor: Position {
		get { return position }
		set { position = newValue }
	}
	var orientation: Orientation {
		get {
			if size.x == size.y {
				return .none
			}
			else if size.x > size.y {
				return .horizontal
			}
			else if size.x < size.y {
				return .vertical
			}
			else {
				fatalError("Unexpected size comparison")
			}
		}
		set {
			if orientation == newValue {
				return
			}
			size = Size(x: size.y, y: size.x, z: size.z)
		}
	}
}
