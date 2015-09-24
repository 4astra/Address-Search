//
//  AddressBookClass.h
//  Address Search
//
//  Created by Minh Dat Giap on 9/24/15.
//  Copyright © 2015 Hoat Ha Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookInfo : NSObject

@property (strong, nonatomic) NSMutableArray *keyA;
@property (strong, nonatomic) NSMutableArray *keyB;
@property (strong, nonatomic) NSMutableArray *keyC;
@property (strong, nonatomic) NSMutableArray *keyD;
@property (strong, nonatomic) NSMutableArray *keyE;
@property (strong, nonatomic) NSMutableArray *keyF;
@property (strong, nonatomic) NSMutableArray *keyG;
@property (strong, nonatomic) NSMutableArray *keyH;
@property (strong, nonatomic) NSMutableArray *keyI;
@property (strong, nonatomic) NSMutableArray *keyJ;
@property (strong, nonatomic) NSMutableArray *keyK;
@property (strong, nonatomic) NSMutableArray *keyL;
@property (strong, nonatomic) NSMutableArray *keyM;
@property (strong, nonatomic) NSMutableArray *keyN;
@property (strong, nonatomic) NSMutableArray *keyO;
@property (strong, nonatomic) NSMutableArray *keyP;
@property (strong, nonatomic) NSMutableArray *keyQ;
@property (strong, nonatomic) NSMutableArray *keyR;
@property (strong, nonatomic) NSMutableArray *keyS;
@property (strong, nonatomic) NSMutableArray *keyT;
@property (strong, nonatomic) NSMutableArray *keyU;
@property (strong, nonatomic) NSMutableArray *keyV;
@property (strong, nonatomic) NSMutableArray *keyW;
@property (strong, nonatomic) NSMutableArray *keyX;
@property (strong, nonatomic) NSMutableArray *keyY;
@property (strong, nonatomic) NSMutableArray *keyZ;
@property (strong, nonatomic) NSMutableArray *keyOther;

-(id)initAddressBook;

-(void)addAddressBookWithKey:(NSString*)key addressBook:(NSMutableDictionary*)addressBook;

@end
