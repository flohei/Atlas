import Foundation

public struct Country {
	public let code: String

	public init(code: String) {
		self.code = code.uppercased()
	}

	public var emojiFlag: String {
		return code.unicodeScalars.map { String(regionalIndicatorSymbol(unicodeScalar: $0)!) }.joined()
	}

	func regionalIndicatorSymbol(unicodeScalar: UnicodeScalar) -> UnicodeScalar? {
	    let uppercaseA = UnicodeScalar("A")!
	    let regionalIndicatorSymbolA = UnicodeScalar("\u{1f1e6}")!
		let distance = unicodeScalar.value - uppercaseA.value
		return UnicodeScalar(regionalIndicatorSymbolA.value + distance)
	}

	public static func availableCountriesAndFlags() -> String {
		var resultString = String()
		for regionCode in Locale.isoRegionCodes {
			guard 
				let country = Locale.current.localizedString(forRegionCode: regionCode),
				let flag = Country(code: regionCode).emojiFlag 
				else { 
					continue 
				}
			resultString += "\(country): \(flag)\n"
		}

		return resultString
	}
}
