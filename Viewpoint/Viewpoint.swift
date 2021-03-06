/**
	Copyright (C) 2017 Quentin Mathe

	Date:  July 2017
	License:  MIT
 */

import Foundation

open class Viewpoint<T>: Presentation {

	open var presentations: [Presentation] { return [] }
	/// The presented value.
    open var value: T {
		didSet {
			changed = true
		}
	}
	/// Whether the item representation or presented value have changed since the last UI update.
    public var changed = true
	/// The item representation.
	///
	/// The returned item tree is annotated with optimizations for `Renderer.render()`.
	public var item: Item {
		let item = generate()
		item.identifier = String(describing: self)
		item.changed = changed
		return item
	}
	/// The object graph used to generate the item representation.
	///
	/// Can be ignored when you don't intent to persist or copy the generated item tree.
	public var objectGraph: ObjectGraph

	// MARK: - Initialization

	/// Initializes a new viewpoint to present the given value.
	///
	/// The object graph argument can be omitted only when the viewpoint is passed to `run(...)`.
	public init(_ value: T, objectGraph: ObjectGraph? = nil) {
		self.value = value
		self.objectGraph = objectGraph ?? ObjectGraph()
	}

	// MARK: - Generating Item Representation
	
	/// Must be overriden to return a custom item tree.
	///
	/// By default, causes a fatal error.
	///
	/// You must never call this method directly.
	open func generate() -> Item {
		fatalError("Must be overriden")
	}
}
