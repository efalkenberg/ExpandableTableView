//
//  Node.m
//  InsertRows
//
//  Created by Eike Falkenberg on 03/12/14.
//  Copyright (c) 2014 Eike Falkenberg. All rights reserved.
//

#import "Node.h"

@implementation Node


#pragma mark Initializers

-(id) init
{
    if(self = [super init])
    {
        _subNodes = [[NSMutableArray alloc]init];
        _expanded = NO;
        _level = 0;
        _nodeId = arc4random_uniform(UINT32_MAX);
    }
    return self;
}

-(id) initWithTitle: (NSString*) title andLevel:(NSInteger) level
{
    if([self init])
    {
        _title = title;
        _level = level;
    }
    return self;
}


#pragma mark Accees subnodes

-(void) addSubNode: (Node*) node
{
    [_subNodes addObject:node];
}

-(NSInteger) expandedRowCountWithSelf
{
    NSInteger count = 1;
    if(_expanded)
    {
        for (Node *subNode in _subNodes)
        {
            count += [subNode expandedRowCountWithSelf];
        }
    }
    return count;
}


#pragma mark - Overriding NSObject

-(NSString *)description
{
    return [NSString stringWithFormat:@"[%ld] '%@' (level: %ld)", (long)_nodeId, _title, (long)_level];
}

@end
