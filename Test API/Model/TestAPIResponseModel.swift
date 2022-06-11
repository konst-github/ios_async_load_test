//
//  TestAPIResponseModel.swift
//  Test API
//

import UIKit
import ObjectMapper

final class TestAPIResponseModel: Mappable {

	var objects: [Row<BaseObject>] = []

	required init?(map: Map) {}

	func mapping(map: Map) {
		var data: [[String:Any]]?
		data <- map["data"]

		if let _ = data {
			for dict in data! {
				guard let type = dict["type"] as? String
				else { continue }

				guard let classType = TypesMapper.map(type: ClassType(rawValue: type) ?? .none)
				else { continue }
				debugPrint("classType \(classType)")

				guard let subdata = dict["data"] as? [String:Any]
				else { continue }

				guard let objectOfClass = TestAPIResponseModel.createObject(ofType: classType, JSON: subdata)
				else { continue }

				debugPrint("objectOfClass \(objectOfClass.self)")
				debugPrint("title \(objectOfClass.title ?? "nil")")
				debugPrint("subtitle \(objectOfClass.subtitle ?? "nil")")
				debugPrint("path \(objectOfClass.path ?? "nil")\n\n")

				objects.append(Row<BaseObject>(object: objectOfClass))
			}
		}
	}

	struct TypesMapper {
		static func map(type: ClassType) -> BaseObject.Type? {
			switch type {
			case .company:
				return Company.self
			case .person:
				return Person.self
			case .song:
				return Song.self
			case .vehicle:
				return Vehicle.self
			case .book:
				return Book.self
			default:
				return nil
			}
		}
	}

	enum ClassType: String {
		case none = ""
		case company = "company"
		case person = "person"
		case song = "song"
		case vehicle = "vehicle"
		// For tests only
		case book = "book"
	}
}

extension TestAPIResponseModel {
	fileprivate class func createObject<T: Initable>(ofType type: T.Type, JSON: [String:Any]) -> T? {
		debugPrint("Create object of type: \(type.self)")
		var object = type.init()
		object.mapping(map: Map(mappingType: MappingType.fromJSON, JSON: JSON))
		debugPrint("Created object: \(object.self)")
		return object
	}
}


extension TestAPIResponseModel {

	// This is just to test how quickly we can add any new class type to the project without breaking the whole app
	// By expanding ClassType, TypesMapper and adding new subclass of BaseObject - Book in this case,
	// and by adding proper mapping for Book class properties -
	// the whole app works fine out of the box.

	class func testJSON() -> String? {
		let json = """
			{
			  "data":[
				{
				  "type":"company",
				  "data":{
					"name":"Betbull",
					"sector":"Sports Betting",
					"logo":"https://i.ibb.co/fH4Pzzr/0ca6b83f66a23a11c87a23b4fff27451.png"
				  }
				},
				{
				  "type":"person",
				  "data":{
					"name":"John Doe",
					"occupation":"iOS Developer",
					"picture":"https://i.ibb.co/b5sGk6L/40a233a203be2a30e6d50501a73d3a0a8ccc131fv2-128.jpg"
				  }
				},
				{
				  "type":"song",
				  "data":{
					"name":"You Need to Calm Down",
					"singer":"Taylor Swift",
					"thumbnail":"https://i.ibb.co/27NwxSd/61q-Kb-Vkn-IYL-AA256.jpg"
				  }
				},
				{
				  "type":"vehicle",
				  "data":{
					"name":"Arteon",
					"brand":"Volkswagen",
					"photo":"https://i.ibb.co/k6VHZFq/2143.png"
				  }
				},
				{
				  "type":"book",
				  "data":{
					"name":"Swift in a nutshell",
					"author":"Swift Guru",
					"link":"https://freepngimg.com/thumb/book/2-books-png-image.png"
				  }
				}
			  ],
			  "error":null
			}
		"""

		return json
	}
}
