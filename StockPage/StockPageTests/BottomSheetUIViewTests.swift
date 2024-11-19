//
//  BottomSheetUIViewTests.swift
//  StockPageTests
//
//  Created by Utkarsh Raj on 20/11/24.
//


import XCTest
@testable import StockPage

class BottomSheetUIViewTests: XCTestCase {
    
    var bottomSheetView: BottomSheetUIView!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        bottomSheetView = BottomSheetUIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
    }
    
    override func tearDownWithError() throws {
        bottomSheetView = nil
        try super.tearDownWithError()
    }
    
    func testInitialSetup() {
        XCTAssertEqual(bottomSheetView.backgroundColor, .bottomSheetColor, "Background color should match .bottomSheetColor")
        XCTAssertEqual(bottomSheetView.layer.cornerRadius, 8, "Corner radius should be 8")
        XCTAssertNotNil(bottomSheetView.layer.shadowColor, "Shadow color should be set")
    }
    
    func testStackViewConfiguration() {
        XCTAssertNotNil(bottomSheetView.subviews.first(where: { $0 is UIStackView }), "A UIStackView should exist in the view hierarchy")
    }
    
}
