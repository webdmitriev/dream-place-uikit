//
//  String.ext.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 18.09.2025.
//

import Foundation

extension String {
    /// Убираем все HTML-теги кроме <br>, а <br> заменяем на \n
    var htmlToPlainText: String {
        var text = self
        
        // 1. Заменяем все <br> и <br/> на перенос строки
        text = text.replacingOccurrences(
            of: "(?i)<br\\s*/?>",
            with: "\n",
            options: .regularExpression
        )
        
        // 2. Удаляем остальные теги
        text = text.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
        
        // 3. Чистим пробелы по краям
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
