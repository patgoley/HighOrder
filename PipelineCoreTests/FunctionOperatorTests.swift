//
//  FunctionOperatorTests.swift
//  PipelineCore
//
//  Created by Patrick Goley on 7/2/16.
//  Copyright © 2016 patrickgoley. All rights reserved.
//

import XCTest
import PipelineCore

class FunctionOperatorTests: XCTestCase {
    
    // MARK: Producers
    
    // producer, consumer
    
    func testProducerConsumer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFive = thunkify(5) |> expect(expt, 5)
        
        expectFive()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    // producer, transformer
    
    func testProducerTransformer() {
        
        let fiveToString = thunkify(5) |> toString
        
        XCTAssert(fiveToString() == "5")
    }
    
    
    // MARK: Transformers
    
    // transformer, consumer
    
    func testTransformerConsumer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFiveMore = addFive |> expect(expt, 5)
        
        expectFiveMore(0)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    // transformer, transformer
    
    func testTransformerTransformer() {
        
        let expt = expectationWithDescription("consumer")
        
        let expectFiveMoreString = addFive |> toString |> expect(expt, "5")
        
        expectFiveMoreString(0)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    
    // MARK: Consumers
    
    // consumer, producer
    
    func testConsumerProducer() {
        
        let firstExpt = expectationWithDescription("first consumer")
        
        let secondExpt = expectationWithDescription("second consumer")
        
        let consumeThenProduce = addFive
            |> expect(firstExpt, 5)
            |> thunkify("abc")
            |> expect(secondExpt, "abc")
        
        consumeThenProduce(0)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
}
