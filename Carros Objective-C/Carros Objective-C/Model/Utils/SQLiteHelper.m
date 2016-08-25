//
//  SQLiteHelper.m
//  Carros Objective-C
//
//  Created by Antonio Lopes on 8/16/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

#import "SQLiteHelper.h"
#import "sqlite3.h"
#import "StringUtils.h"
#import "SQLiteObjc.h"

@implementation SQLiteHelper

- (id)initWitDatabase:(NSString *)database {
    if (self = [super init]) {
        db = [self open:database];
        return self;
    }
    return nil;
}

- (NSString *) getFilePath:(NSString *)database {
    return [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), database];
    
}

- (sqlite3 *) open:(NSString *)database {
    
    sqlite3 * sqlite3Database = nil;
    
    NSString * path = [self getFilePath:database];
    int result = sqlite3_open([path UTF8String], &sqlite3Database);
    if (result != SQLITE_OK) {
        NSLog(@"Não foi possível abrir o banco de dados SQLite %d", result);
        return nil;
    }
    
    return sqlite3Database;
}

- (int) execSql:(NSString *)sql {
    return [self execSql:sql withParams:nil];
}

- (int) execSql:(NSString *)sql withParams:(NSArray *)params {
    
    sqlite3_stmt * stmt = [self query:sql witParams:params];
    
    int result = sqlite3_step(stmt);
    if (result != SQLITE_OK && result != SQLITE_DONE) {
        sqlite3_finalize(stmt);
        NSLog(@"Erro ao executar o SQL %@", sql);
        return -1;
    }
    
    if ([[sql uppercaseString] hasPrefix:@"INSERT"]) {
        sqlite3_int64 rid = sqlite3_last_insert_rowid(db);
        result = (int)rid;
    } else {
        result = 1;
    }
    
    int iFinalize = sqlite3_finalize(stmt);
    
    return result;
}

- (sqlite3_stmt *) query:(NSString *)sql {
    return [self query:sql witParams:nil];
}

- (sqlite3_stmt *) query:(NSString *)sql witParams:(NSArray *)params {
    
    sqlite3_stmt * stmt = nil;
    char * cSql = [StringUtils toCString:sql];
    
    int result = sqlite3_prepare_v2(db, cSql, -1, &stmt, nil);
    
    if (result != SQLITE_OK) {
        int iFinalize = sqlite3_finalize(stmt);
        NSLog(@"Erro ao preparar o SQL %@", sql);
    } else {
        NSLog(@"SQL %@", sql);
    }
    
    [self bindParams:stmt withParams:params];
    
    return stmt;
}

- (void) bindParams:(sqlite3_stmt *)stmt withParams:(NSArray *)params {
    if (params != nil) {
        NSInteger size = [params count];
        
        for (int i = 1; i <= size; i++) {
            id value = [params objectAtIndex:i-1];
            
            if ([value isKindOfClass:[NSNumber class]]) {
                sqlite3_bind_int(stmt, i, [value intValue]);
            } else {
                NSString * text = (NSString *)value;
                [SQLiteObjc bindText:stmt idx:i withString:text];
            }
        }
    }
}

- (BOOL) nextRow:(sqlite3_stmt *)stmt {
    int result = sqlite3_step(stmt);
    return result == SQLITE_ROW;
}

- (void) close {
    int result = sqlite3_close(db);
}

- (void) closeStatement:(sqlite3_stmt *)stmt {
    int iFinalize = sqlite3_finalize(stmt);
}

- (NSString *) lastSQLErro {
    const char * erro = sqlite3_errmsg(db);
    
    if (erro != nil) {
        NSString * s = [NSString stringWithUTF8String:erro];
        return s;
    }
    return @"";
}

- (int) getInt:(sqlite3_stmt *)stmt withIndex:(int)index {
    return sqlite3_column_int(stmt, index);
}

- (double) getDouble:(sqlite3_stmt *)stmt withIndex:(int)index {
    return sqlite3_column_double(stmt, index);
}

- (float) getFloat:(sqlite3_stmt *)stmt withIndex:(int)index {
    return sqlite3_column_double(stmt, index);
}

- (NSString *) getString:(sqlite3_stmt *)stmt withIndex:(int)index {
    const unsigned char * result = sqlite3_column_text(stmt, index);
    return [NSString stringWithUTF8String:(char *)result];
}

- (int32_t) toCInt:(int) objectiveInt {
    NSNumber * number = [NSNumber numberWithInt:objectiveInt];
    return [number intValue];
}

@end
