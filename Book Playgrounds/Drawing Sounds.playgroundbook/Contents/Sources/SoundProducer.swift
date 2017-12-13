// 
//  SoundProducer.swift
//
//  Copyright © 2016,2017 Apple Inc. All rights reserved.
//

/// An instrument and speech are both sound producers.
/// - localizationKey: SoundProducer
public protocol SoundProducer {
    var noteCount: Int { get }
}

