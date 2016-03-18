//
//  FBl_DBTool.m
//  越野e族
//
//  Created by 张杰 on 15/12/28.
//  Copyright © 2015年 罗树新. All rights reserved.
//

#import "FBl_DBTool.h"


@interface FBl_DBTool()
{
    FMDatabase *_db;
    
}
@end

@implementation FBl_DBTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //创建数据库
        NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
        NSString *path = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
        NSLog(@".....%@",path);
        _db = [FMDatabase databaseWithPath:path];
        if ([_db open]) {
            
            //建表
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE %@ (List_id INTEGER PRIMARY KEY, tpye text, content text, date text, huifubbsid text, fabiaoid text, username text, weibo text, huifubbfid text, title text, columns text, image text)",USER_NAME_GET];
            BOOL is = [_db executeUpdate:sql];
            if (!is) {
                
                NSLog(@"建表失败");
            }
        }else{
        
            NSLog(@"数据库创建失败");
        }
    }

    return self;
}


- (BOOL)addtype:(NSString *)thetype content:(NSString *)thecontent date:(NSString *)thedate username:(NSString *)theusername fabiaogid:(NSString *)thefabiaogid huifubbsid:(NSString *)thebbsid weiboid:(NSString *)theweiboid thehuifubbsfid:(NSString*)fid thetitle:(NSString*)title columns:(NSString *)columns image:(NSString *)image
{
    NSString *sql1 = [NSString stringWithFormat:@"insert into %@",USER_NAME_GET];
    NSString *sql2 = @"(tpye,content,date,huifubbsid,fabiaoid,username,weibo,huifubbfid,title,columns,image) values (?,?,?,?,?,?,?,?,?,?,?)";
    NSString *sql = [NSString stringWithFormat:@"%@%@",sql1,sql2];
       BOOL result = [_db executeUpdate:sql,thetype,thecontent,thedate,thefabiaogid,thebbsid,theusername,theweiboid,fid,title,columns,image];
    
    return result;
}

- (NSMutableArray *)findalldata
{
    
    NSMutableArray *modes = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"select * from %@ order by date desc",USER_NAME_GET];
    FMResultSet *ruslt =  [_db executeQuery:sql];
    while ([ruslt next]) {
        FBl_DBTool *dbTool = [self dbWithRuslt:ruslt];
        [modes addObject:dbTool];
    }
    
    return modes;
    
}


- (NSMutableArray *)findallbytheColumns:(NSString *)type
{
    NSMutableArray *modes = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"select * form %@",USER_NAME_GET];
    sql = [NSString stringWithFormat:@"%@%@",sql,@"where columns values (?)"];
    FMResultSet *ruslt =  [_db executeQuery:sql, type];
    while ([ruslt next]) {
        
        FBl_DBTool *dbTool = [self dbWithRuslt:ruslt];
    
        [modes addObject:dbTool];

    }

    return modes;
    
}


- (BOOL)deleteContentBytheId:(NSString *)selectId
{
    NSString *sql = [NSString stringWithFormat:@"delete from %@",USER_NAME_GET];
    sql = [NSString stringWithFormat:@"%@ %@",sql,@"where List_id = ?"];
    BOOL is = [_db executeUpdate:sql,selectId];
    
    if (is) {
        
//        [self updataTheTable];
    }
    return is;
}


- (FBl_DBTool *)dbWithRuslt:(FMResultSet*)ruslt
{
    FBl_DBTool *dbTool = [[FBl_DBTool alloc]init];
    dbTool.type = [ruslt stringForColumn:@"tpye"];
    dbTool.content = [ruslt stringForColumn:@"content"];
    dbTool.date = [ruslt stringForColumn:@"date"];
    dbTool.huifubbsid = [ruslt stringForColumn:@"huifubbsid"];
    dbTool.fabiaogid = [ruslt stringForColumn:@"fabiaoid"];
    dbTool.weiboid = [ruslt stringForColumn:@"weiboid"];
    dbTool.username = [ruslt stringForColumn:@"username"];
    dbTool.huifubbsfid = [ruslt stringForColumn:@"huifubbfid"];
    dbTool.title = [ruslt stringForColumn:@"title"];
    dbTool.columns = [ruslt stringForColumn:@"columns"];
    dbTool.draftId = [ruslt stringForColumn:@"List_id"];
    
    return dbTool;
}


- (void)updataTheTable
{
    NSArray *arr = [self findalldata];
    NSString *sql =  [NSString stringWithFormat:@"delete from %@",USER_NAME_GET];
    
    [_db beginTransaction];

    BOOL isRollBack = NO;
    @try {
        
        BOOL is = [_db executeUpdate:sql];
        
        if (!is) {
            NSLog(@"删除失败");
            return;
        }
        
    }
    @catch (NSException *exception) {
        
        isRollBack = YES;
        [_db rollback];
       
    }
    @finally {
        
        if (!isRollBack) {
            
            [_db commit];
        }
    }
    if (arr.count==0) return;
    
    for (int i= 0; i<arr.count; i++) {
        
        FBl_DBTool *dbMode = arr[i];
        
        [self addtype:dbMode.type content:dbMode.content date:dbMode.date username:dbMode.username fabiaogid:dbMode.fabiaogid huifubbsid:dbMode.huifubbsid weiboid:dbMode.weiboid thehuifubbsfid:dbMode.huifubbsfid thetitle:dbMode.title columns:dbMode.columns image:dbMode.image];
        
    }
    
    [_db close];


}

@end
