//
//  logger.swift
//  BeisWastageProject
//
//  Created by junxi Yim on 2025/6/8.
//

import OSLog

extension Logger {

    // Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    // Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")

    // All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem, category: "statistics")

    // All logs related to database operations
    static let database = Logger(subsystem: subsystem, category: "database")

    // All logs related to user authentication
    static let authentication = Logger(subsystem: subsystem, category: "authentication")

    // All logs related to user searches or filtering
    static let search = Logger(subsystem: subsystem, category: "search")

    // All logs related to reports
    static let reports = Logger(subsystem: subsystem, category: "report")

}


