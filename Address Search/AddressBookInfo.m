//
//  AddressBookClass.m
//  Address Search
//
//  Created by Staff on 3/9/15.
//  Created by Minh Dat Giap on 9/24/15.
//  Copyright © 2015 Hoat Ha Van. All rights reserved.
//

#import "AddressBookInfo.h"

@implementation AddressBookInfo

-(id)initAddressBook
{
    if (self = [super init]) {
        self.keyA = [[NSMutableArray alloc] init];
        self.keyB = [[NSMutableArray alloc] init];
        self.keyC = [[NSMutableArray alloc] init];
        self.keyD = [[NSMutableArray alloc] init];
        self.keyE = [[NSMutableArray alloc] init];
        self.keyF = [[NSMutableArray alloc] init];
        self.keyG = [[NSMutableArray alloc] init];
        self.keyH = [[NSMutableArray alloc] init];
        self.keyI = [[NSMutableArray alloc] init];
        self.keyJ = [[NSMutableArray alloc] init];
        self.keyK = [[NSMutableArray alloc] init];
        self.keyL = [[NSMutableArray alloc] init];
        self.keyM = [[NSMutableArray alloc] init];
        self.keyN = [[NSMutableArray alloc] init];
        self.keyO = [[NSMutableArray alloc] init];
        self.keyP = [[NSMutableArray alloc] init];
        self.keyQ = [[NSMutableArray alloc] init];
        self.keyR = [[NSMutableArray alloc] init];
        self.keyS = [[NSMutableArray alloc] init];
        self.keyT = [[NSMutableArray alloc] init];
        self.keyU = [[NSMutableArray alloc] init];
        self.keyV = [[NSMutableArray alloc] init];
        self.keyW = [[NSMutableArray alloc] init];
        self.keyX = [[NSMutableArray alloc] init];
        self.keyY = [[NSMutableArray alloc] init];
        self.keyZ = [[NSMutableArray alloc] init];
        self.keyOther = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addAddressBookWithKey:(NSString*)key addressBook:(NSMutableDictionary*)addressBook
{
    key = [key uppercaseString];
    
    if ([key isEqualToString:@"A"]) {
        [self.keyA addObject:addressBook];
    }
    else if ([key isEqualToString:@"B"])
    {
        [self.keyB addObject:addressBook];
    }
    else if ([key isEqualToString:@"C"])
    {
        [self.keyC addObject:addressBook];
    }
    else if ([key isEqualToString:@"D"])
    {
        [self.keyD addObject:addressBook];
    }
    else if ([key isEqualToString:@"E"])
    {
        [self.keyE addObject:addressBook];
    }
    else if ([key isEqualToString:@"F"])
    {
        [self.keyF addObject:addressBook];
    }
    else if ([key isEqualToString:@"G"])
    {
        [self.keyG addObject:addressBook];
    }
    else if ([key isEqualToString:@"H"])
    {
        [self.keyH addObject:addressBook];
    }
    else if ([key isEqualToString:@"I"])
    {
        [self.keyI addObject:addressBook];
    }
    else if ([key isEqualToString:@"J"])
    {
        [self.keyJ addObject:addressBook];
    }
    else if ([key isEqualToString:@"K"])
    {
        [self.keyK addObject:addressBook];
    }
    else if ([key isEqualToString:@"L"])
    {
        [self.keyL addObject:addressBook];
    }
    else if ([key isEqualToString:@"M"])
    {
        [self.keyM addObject:addressBook];
    }
    else if ([key isEqualToString:@"N"])
    {
        [self.keyN addObject:addressBook];
    }
    else if ([key isEqualToString:@"O"])
    {
        [self.keyO addObject:addressBook];
    }
    else if ([key isEqualToString:@"P"])
    {
        [self.keyP addObject:addressBook];
    }
    else if ([key isEqualToString:@"Q"])
    {
        [self.keyQ addObject:addressBook];
    }
    else if ([key isEqualToString:@"R"])
    {
        [self.keyR addObject:addressBook];
    }
    else if ([key isEqualToString:@"S"])
    {
        [self.keyS addObject:addressBook];
    }
    else if ([key isEqualToString:@"T"])
    {
        [self.keyT addObject:addressBook];
    }
    else if ([key isEqualToString:@"U"])
    {
        [self.keyU addObject:addressBook];
    }
    else if ([key isEqualToString:@"V"])
    {
        [self.keyV addObject:addressBook];
    }
    else if ([key isEqualToString:@"W"])
    {
        [self.keyW addObject:addressBook];
    }
    else if ([key isEqualToString:@"X"])
    {
        [self.keyX addObject:addressBook];
    }
    else if ([key isEqualToString:@"Y"])
    {
        [self.keyY addObject:addressBook];
    }
    else if ([key isEqualToString:@"Z"])
    {
        [self.keyZ addObject:addressBook];
    }
    else
    {
        [self.keyOther addObject:addressBook];
    }
}

@end
