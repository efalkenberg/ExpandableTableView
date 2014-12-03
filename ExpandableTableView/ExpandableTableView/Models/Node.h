//
//  Node.h
//  InsertRows
//
//  Created by Eike Falkenberg on 03/12/14.
//  Copyright (c) 2014 Eike Falkenberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, assign) NSInteger nodeId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong, readonly) NSMutableArray *subNodes;
@property (nonatomic, assign) BOOL expanded;
@property (nonatomic, assign) NSInteger level;

-(id) initWithTitle: (NSString*) title andLevel:(NSInteger) level;
-(void) addSubNode: (Node*) node;
-(NSInteger) expandedRowCountWithSelf;

@end
