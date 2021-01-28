//
//  Meanings.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/28/21.
//

import Foundation

// MARK: - Meanings

struct Meanings: Codable {
    let id: String
    let wordID, difficultyLevel: Int
    let partOfSpeechCode, meaningPrefix, text, soundURL: String
    let transcription: String
    let updatedAt, mnemonics: String
    let translation: Translation
    let images: [Image]
    let definition: Definition
    let examples: [Definition]
    let meaningsWithSimilarTranslation: [MeaningsWithSimilarTranslation]
    let alternativeTranslations: [AlternativeTranslation]

    enum CodingKeys: String, CodingKey {
        case id
        case wordID = "wordId"
        case difficultyLevel, partOfSpeechCode
        case meaningPrefix = "prefix"
        case text
        case soundURL = "soundUrl"
        case transcription, updatedAt, mnemonics, translation, images, definition, examples, meaningsWithSimilarTranslation, alternativeTranslations
    }
}

// MARK: - AlternativeTranslation
struct AlternativeTranslation: Codable {
    let text: String
    let translation: Translation
}

// MARK: - Definition
struct Definition: Codable {
    let text, soundURL: String

    enum CodingKeys: String, CodingKey {
        case text
        case soundURL = "soundUrl"
    }
}

// MARK: - Image
struct Image: Codable {
    let url: String
}

// MARK: - MeaningsWithSimilarTranslation
struct MeaningsWithSimilarTranslation: Codable {
    let meaningID: Int
    let frequencyPercent, partOfSpeechAbbreviation: String
    let translation: Translation

    enum CodingKeys: String, CodingKey {
        case meaningID = "meaningId"
        case frequencyPercent, partOfSpeechAbbreviation, translation
    }
}

// MARK: - Properties
struct Properties: Codable {
}
