//
//  FmdbMigrationColumn.h
//  fmdb-migration-manager
//
//  Created by Dr Nic on 6/09/08.
//  Copyright 2008 Mocra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDBMigrationColumn.h"

@interface FMDBMigration : NSObject {
	FMDatabase *db_;
}
@property (retain) FMDatabase *db;

+ (instancetype) migration;

- (void)up;
- (void)down;

- (void)upWithDatabase:(FMDatabase *)db;
- (void)downWithDatabase:(FMDatabase *)db;

- (void)createTable:(NSString *)tableName;
- (void)createTable:(NSString *)tableName primaryKey:(NSString *)primaryKey;
- (void)createTable:(NSString *)tableName withColumns:(NSArray *)columns;
- (void)dropTable:(NSString *)tableName;

- (void)addColumn:(FmdbMigrationColumn *)column forTableName:(NSString *)tableName;

@end
