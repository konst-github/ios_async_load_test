//
//  TestAPIModel.swift
//  Test API
//

import UIKit
import ObjectMapper


protocol Initable : Mappable {
	init()
}

protocol RowMappable {
	var title: String? { get }
	var subtitle: String? { get }
	var path: String? { get }
	var image: UIImage? { get }
}

public class BaseObject : RowMappable, Initable {

	private var name: String?

	public required init?(map: Map) {}

	// Next 2 inits and Initable protocol were added to cover this issue during creation of objects with
	// TestAPIResponseModel.createObject<T: Initable>(ofType type: T.Type, JSON: [String:Any]) -> T?
	// https://forums.swift.org/t/creating-an-object-by-passing-a-metatype-to-a-generic-function-uses-the-default-parameter-values-of-the-base-class-init/12508
	required convenience init() { self.init(name: "BaseObject") }
	required init(name: String) {
		debugPrint("Init: BaseObject")
	}

	public func mapping(map: Map) {
		name <- map["name"]
	}

	var title: String? { return name }
	var subtitle: String? { return nil }
	var path: String? { return nil }
	var image: UIImage?
}


public final class Company : BaseObject {

	private var sector: String?
	private var logo: String?

	required init?(map: Map) { super.init(map: map) }

	required convenience init() { self.init(name: "Company") }
	required init(name: String) {
		debugPrint("Init: \(name)")
		super.init(name: name)
	}

	override public func mapping(map: Map) {
		super.mapping(map: map)
		sector <- map["sector"]
		logo <- map["logo"]
	}

	override var subtitle: String? { return sector }
	override var path: String? { return logo }
}


public final class Person : BaseObject {

	private var occupation: String?
	private var picture: String?

	public required init?(map: Map) {
		super.init(map: map)
	}

	required convenience init() { self.init(name: "Person") }
	required init(name: String) {
		debugPrint("Init: \(name)")
		super.init(name: name)
	}

	override public func mapping(map: Map) {
		super.mapping(map: map)
		occupation <- map["occupation"]
		picture <- map["picture"]
	}

	override var subtitle: String? { return occupation }
	override var path: String? { return picture }
}


public final class Song : BaseObject {

	private var singer: String?
	private var thumbnail: String?

	public required init?(map: Map) {
		super.init(map: map)
	}

	required convenience init() { self.init(name: "Song") }
	required init(name: String) {
		debugPrint("Init: \(name)")
		super.init(name: name)
	}

	override public func mapping(map: Map) {
		super.mapping(map: map)
		singer <- map["singer"]
		thumbnail <- map["thumbnail"]
	}

	override var subtitle: String? { return singer }
	override var path: String? { return thumbnail }
}


public final class Vehicle : BaseObject {

	private var brand: String?
	private var photo: String?

	public required init?(map: Map) {
		super.init(map: map)
	}

	required convenience init() { self.init(name: "Vehicle") }
	required init(name: String) {
		debugPrint("Init: \(name)")
		super.init(name: name)
	}

	override public func mapping(map: Map) {
		super.mapping(map: map)
		brand <- map["brand"]
		photo <- map["photo"]
	}

	override var subtitle: String? { return brand }
	override var path: String? { return photo }
}

public final class Book : BaseObject {

	private var author: String?
	private var link: String?

	public required init?(map: Map) {
		super.init(map: map)
	}

	required convenience init() { self.init(name: "Book") }
	required init(name: String) {
		debugPrint("Init: \(name)")
		super.init(name: name)
	}

	override public func mapping(map: Map) {
		super.mapping(map: map)
		author <- map["author"]
		link <- map["link"]
	}

	override var subtitle: String? { return author }
	override var path: String? { return link }
}
