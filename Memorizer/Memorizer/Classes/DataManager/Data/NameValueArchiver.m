//
//  NameValueArchiver.m
//  MobinilAndMe
//
//  Created by Rémi LAVEDRINE on 27/04/12.
//  Copyright (c) 2012 France Telecom. All rights reserved.
//

#import "NameValueArchiver.h"

@implementation NameValueArchiver
@synthesize name;
@synthesize value;


#pragma mark - Object life cycle

- (id)init{
  self = [super init];
  if (self) {
    self.name = nil;
    self.value = nil;
  }
  
  return self;
}

- (id)initWithName:(NSString *)aName andValue:(NSString *)aValue{
  self = [super init];
  if (self) {
    self.name = aName;
    self.value = aValue;
  }
  
  return self;
}


#pragma mark - NSCoding protocol - Archive management

//! Define the keys for the object that will need to be encoded or decoded.
#define kNameKey  @"name"
#define kValueKey @"value"
- (void) encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.name forKey:kNameKey];
  [encoder encodeObject:self.value forKey:kValueKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
  NSString *n = [decoder decodeObjectForKey:kNameKey];
  NSString *v = [decoder decodeObjectForKey:kValueKey];
  
  return [self initWithName:n andValue:v];
}


#pragma mark - Description

- (NSString *)description{
  return [NSString stringWithFormat:@"name : %@,\nvalue : %@,\n", 
          self.name, 
          self.value];
}


@end
