//
//  TestAPIService.swift
//  Test API
//

import Foundation
import Alamofire
import ObjectMapper


extension Optional {
	func ifNil<Wrapped>(value: Wrapped) -> Wrapped {
		if self != nil {
			return self as! Wrapped
		}
		return value
	}
}


final class TestAPIService {

	private static let sourceURL = "http://www.mocky.io/v2/5d2504dc2f00006fbe241ce1"

	public func fetchRemoteData(completion: @escaping ([Row<BaseObject>]) -> Void) {
		AF.request(TestAPIService.sourceURL).response { response in
			debugPrint(response)
			do {
				if let data = response.data {
					// Uncomment this line and comment next one to test support of the new type - Book
//					let jsonString = TestAPIResponseModel.testJSON()
					let jsonString = String(data: data, encoding: .utf8)
					guard let responseModel = TestAPIResponseModel(JSONString: jsonString.ifNil(value: "")) else { throw JSONError.invalidData }
					debugPrint(responseModel.objects)
					completion(responseModel.objects)
				}
				else {
					throw JSONError.invalidData
				}
			}
			catch {
				print("Error with Json: \(error)")
			}
		}
	}
	
}

enum JSONError: Error {
	case invalidData
}

