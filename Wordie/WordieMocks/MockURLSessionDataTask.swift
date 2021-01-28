//
//  MockURLSessionDataTask.swift
//  WordieTests
//
//  Created by Ilia Gutu on 1/27/21.
//

import Foundation
@testable import Wordie

final class MockURLSessionDataTask: Task {
    private (set) var resumeWasCalled = false
    private (set) var cancelWasCalled = false

    func resume() {
        resumeWasCalled = true
    }

    func cancel() {
        cancelWasCalled = true
    }
}
