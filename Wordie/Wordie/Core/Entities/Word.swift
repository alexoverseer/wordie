//
//  Word.swift
//  Wordie
//
//  Created by Ilia Gutu on 1/25/21.
//

import Foundation

// MARK: - Word
struct Word: Codable {
    let id: Int
    let text: String
    let meanings: [Meaning]

    var images: [String] {
        meanings.compactMap { $0.imageURL }
    }
}

// MARK: - Meaning
struct Meaning: Codable {
    let id: Int
    let partOfSpeechCode: String?
    let translation: Translation
    let previewURL, imageURL, transcription, soundURL: String

    enum CodingKeys: String, CodingKey {
        case id, partOfSpeechCode, translation
        case previewURL = "previewUrl"
        case imageURL = "imageUrl"
        case transcription
        case soundURL = "soundUrl"
    }
}

// MARK: - Translation
struct Translation: Codable {
    let text: String
    let note: String?
}

extension Word {
    var translations: String {
        let translations = meanings.map { $0.translation.text }.joined(separator: ", ")
        return translations
    }
}
