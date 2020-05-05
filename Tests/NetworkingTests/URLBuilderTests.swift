import XCTest
@testable import Networking

final class URLBuilderTests: XCTestCase {
    func testMakeRequest_success() {
        // given
        let builder = URLRequestBuilder()
        let endpoint = MockEndpoint_NoData()
        
        // when
        var requestError: Error?
        
        do {
            let _ = try builder.request(from: endpoint)
        } catch {
            requestError = error
        }
        
        // then
        XCTAssertNil(requestError)
    }
    
    func testMakeRequest_failure_badURL() {
        // given
        let builder = URLRequestBuilder()
        let endpoint = MockEndpoint_BadHost()
        
        // when
        var requestError: Error?
        
        do {
            let _ = try builder.request(from: endpoint)
        } catch {
            requestError = error
        }
        
        // then
        XCTAssertNotNil(requestError)
    }
    
    func testSetData_success_withParams() {
        // given
        let builder = URLRequestBuilder()
        let endpoint = MockEndpoint_WithParamData()
        
        // when
        var requestError: Error?
        
        do {
            let _ = try builder.request(from: endpoint)
        } catch {
            requestError = error
        }
        
        // then
        XCTAssertNil(requestError)
    }
    
    func testSetData_success_withBody() {
        // given
        let builder = URLRequestBuilder()
        let endpoint = MockEndpoint_WithBodyData()
        
        // when
        var requestError: Error?
        
        do {
            let _ = try builder.request(from: endpoint)
        } catch {
            requestError = error
        }
        
        // then
        XCTAssertNil(requestError)
    }
    
    func testSetData_sucess_withEmptyParams() {
        // given
        let builder = URLRequestBuilder()
        let endpoint = MockEndpoint_WithEmptyParamNameData()
        
        // when
        var query: String?
        let request = try? builder.request(from: endpoint)
        query = request?.url?.query
        
        // then
        XCTAssertTrue(query!.isEmpty, "empty params should yield and empty query")
    }
}
