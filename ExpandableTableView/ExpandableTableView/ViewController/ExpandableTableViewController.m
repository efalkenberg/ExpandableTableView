//
//  MyTableViewController.m
//  InsertRows
//
//  Created by Eike Falkenberg on 01/12/14.
//  Copyright (c) 2014 Eike Falkenberg. All rights reserved.
//

#import "ExpandableTableViewController.h"
#import "Node.h"

@interface ExpandableTableViewController ()

@property (nonatomic, strong) NSMutableArray* nodes;

@end


@implementation ExpandableTableViewController


#pragma mark - View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _nodes = [[NSMutableArray alloc]init];
    
    // hardcoded data structure
    Node *node = [[Node alloc]initWithTitle:@"Fruit" andLevel:0];
    [node addSubNode:[[Node alloc]initWithTitle:@"Apple" andLevel:1]];
    [node addSubNode:[[Node alloc]initWithTitle:@"Pineapple" andLevel:1]];
    [node addSubNode:[[Node alloc]initWithTitle:@"Banana" andLevel:1]];
    [node addSubNode:[[Node alloc]initWithTitle:@"Peach" andLevel:1]];
    [_nodes addObject:node];
    
    node = [[Node alloc]initWithTitle:@"Vegetable" andLevel:0];
    [node addSubNode:[[Node alloc]initWithTitle:@"Carrot" andLevel:1]];
    [node addSubNode:[[Node alloc]initWithTitle:@"Broccoli" andLevel:1]];
    [node addSubNode:[[Node alloc]initWithTitle:@"Potato" andLevel:1]];
    [_nodes addObject:node];
    
    node = [[Node alloc]initWithTitle:@"Herbal" andLevel:0];
    [node addSubNode:[[Node alloc]initWithTitle:@"Basil" andLevel:1]];
    [node addSubNode:[[Node alloc]initWithTitle:@"Oregano" andLevel:1]];

    [_nodes addObject:node];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount = 0;
    for (Node* node in _nodes)
    {
        rowCount += [node expandedRowCountWithSelf];
    }
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Node *node = [self nodeForIndexPath:indexPath];
    
    // differenet table view cell prototypes for different node levels
    UITableViewCell *cell;
    if(node.level  == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"level1cell" forIndexPath:indexPath];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"level2cell" forIndexPath:indexPath];
    }
    
    // set the nodes title as row text
    cell.textLabel.text = node.title;
    
    // attach the nodeId for later lookup when selected
    cell.tag = node.nodeId;
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Node *node = [self nodeForIndexPath:indexPath];
    node.expanded = !node.expanded;
    
    if(node.expanded)
    {
        // add n rows
        NSMutableArray *indexPaths = [NSMutableArray array];
        for(NSInteger i=indexPath.row; i< indexPath.row+node.subNodes.count; i++)
        {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i+1 inSection:0]];
        }
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    else
    {
        // delete n rows
        NSMutableArray *indexPaths = [NSMutableArray array];
        for(NSInteger i=indexPath.row; i< indexPath.row+node.subNodes.count; i++)
        {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i+1 inSection:0]];
        }
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}


#pragma mark - Private helper

-(Node*) nodeForIndexPath:(NSIndexPath*)indexPath
{
    int idx = 0;

    for(Node *node in _nodes)
    {
        if(idx == indexPath.row)
        {
            return node;
        }
        idx++;
        
        if(node.expanded)
        {
            for (Node *subNode in node.subNodes)
            {
                if(idx == indexPath.row)
                {
                    return subNode;
                }
                idx++;
            }
        }
    }
    return nil;
}

@end
