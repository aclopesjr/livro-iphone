//
//  SQLiteHelper.h
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/16/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface SQLiteHelper : NSObject {
    sqlite3 *db;
}

- (id)initWitDatabase:(NSString *)database;

- (NSString *) getFilePath:(NSString *)database;
- (sqlite3 *) open:(NSString *)database;

- (int) execSql:(NSString *)sql;
- (int) execSql:(NSString *)sql withParams:(NSArray *)params;

- (sqlite3_stmt *) query:(NSString *)sql;
- (sqlite3_stmt *) query:(NSString *)sql witParams:(NSArray *)params;

- (void) bindParams:(sqlite3_stmt *)stmt withParams:(NSArray *)params;

- (BOOL) nextRow:(sqlite3_stmt *) stmt;
- (void) close;
- (void) closeStatement:(sqlite3_stmt *) stmt;
- (NSString *) lastSQLErro;

- (int) getInt:(sqlite3_stmt *)stmt withIndex:(int)index;
- (double) getDouble:(sqlite3_stmt *)stmt withIndex:(int)index;
- (float) getFloat:(sqlite3_stmt *)stmt withIndex:(int)index;
- (NSString *) getString:(sqlite3_stmt *)stmt withIndex:(int)index;
- (int32_t) toCInt:(int) objectiveInt;

@end
