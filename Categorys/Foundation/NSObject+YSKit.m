#import "NSObject+YSKit.h"
#import <objc/runtime.h>

@implementation NSObject (YSKit)

+ (BOOL)ys_addInstanceMethodWithSelectorName:(NSString *)selectorName block:(void (^)(id))block {
	// don't accept nil name
	NSParameterAssert(selectorName);

	// don't accept NULL block
	NSParameterAssert(block);

	// See http://stackoverflow.com/questions/6357663/casting-a-block-to-a-void-for-dynamic-class-method-resolution

#if MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_7
    void *impBlockForIMP = (void *)objc_unretainedPointer(block);
#else
    id impBlockForIMP = (__bridge id)(__bridge void *)(block);
#endif

    IMP myIMP = imp_implementationWithBlock(impBlockForIMP);

    SEL selector = NSSelectorFromString(selectorName);
    return class_addMethod(self, selector, myIMP, "v@:");
}

#pragma mark - Method Swizzling

+ (void)ys_swizzleMethod:(SEL)selector withMethod:(SEL)otherSelector {
	// my own class is being targetted
	Class c = [self class];

	// get the methods from the selectors
	Method originalMethod = class_getInstanceMethod(c, selector);
	Method otherMethod = class_getInstanceMethod(c, otherSelector);

	if (class_addMethod(c, selector, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod))) {
		class_replaceMethod(c, otherSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
	}
	else {
		method_exchangeImplementations(originalMethod, otherMethod);
	}
}

+ (void)ys_swizzleClassMethod:(SEL)selector withMethod:(SEL)otherSelector {
	// my own class is being targetted
	Class c = [self class];

	// get the methods from the selectors
	Method originalMethod = class_getClassMethod(c, selector);
	Method otherMethod = class_getClassMethod(c, otherSelector);

	//    if (class_addMethod(c, selector, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod)))
	//	{
	//		class_replaceMethod(c, otherSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
	//	}
	//	else
	//	{
	method_exchangeImplementations(originalMethod, otherMethod);
	//	}
}

- (NSArray *)ys_getPropertyKeys{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}

- (NSMutableDictionary *)ys_getProperties{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableDictionary* propertiesDictionary = [NSMutableDictionary dictionaryWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        NSString *propertyName = [NSString  stringWithUTF8String:property_getName(properties[i])];
        id propertyValue = [self valueForKey:propertyName];
        if (propertyValue) {
            [propertiesDictionary setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return propertiesDictionary;
}

- (void)ys_reflectDataFromObject:(id)dataSource{
    BOOL ret = NO;
    for (NSString *key in [self ys_getPropertyKeys]) {
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            ret = [dataSource valueForKey:key]? YES : NO;
        }
        else {
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
        }
        if (ret) {
            id propertyValue = [dataSource valueForKey:key];
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue != nil) {
                [self setValue:propertyValue forKey:key];
            }
        }
    }
}


#pragma mark - DynamicProperties

+ (void)ys_implementDynamicPropertyAccessors {
	[self ys_implementDynamicPropertyAccessorsForPropertyMatching:nil];
}

+ (void)ys_implementDynamicPropertyAccessorsForPropertyName:(NSString *)propertyName {
	[self ys_implementDynamicPropertyAccessorsForPropertyMatching:[NSString stringWithFormat:@"^%@$", propertyName]];
}

+ (void)ys_implementDynamicPropertyAccessorsForPropertyMatching:(NSString *)regexString {
	[self enumeratePropertiesMatching:regexString withBlock: ^(objc_property_t property) {
	    [self implementAccessorsIfNecessaryForProperty:property];
	}];
}

+ (void)enumeratePropertiesMatching:(NSString *)regexString withBlock:(void (^)(objc_property_t property))block {
	NSParameterAssert(block);
	uint count = 0;
	objc_property_t *properties = class_copyPropertyList(self, &count);
	for (uint i = 0; i < count; i++) {
		objc_property_t property = properties[i];
		BOOL isMatch = !regexString || ({
		                                    NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
		                                    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:0 error:NULL];
		                                    [regex numberOfMatchesInString:propertyName options:0 range:NSMakeRange(0, propertyName.length)];
										});
		if (isMatch) {
			block(property);
		}
	}
	free(properties);
}

+ (void)implementAccessorsIfNecessaryForProperty:(objc_property_t)property {
	NSArray *attributes = [self attributesOfProperty:property];
	BOOL isDynamic = [attributes containsObject:@"D"];
	if (!isDynamic) {
		return;
	}

	BOOL isObjectType = YES;
	NSString *customGetterName;
	NSString *customSetterName;

	for (NSString *attribute in attributes) {
		unichar firstChar = [attribute characterAtIndex:0];
		switch (firstChar) {
			case 'T': isObjectType = [attribute characterAtIndex:1] == '@'; break;

			case 'G': customGetterName = [attribute substringFromIndex:1]; break;

			case 'S': customSetterName = [attribute substringFromIndex:1]; break;

			default: break;
		}
	}
	if (!isObjectType) {
		return;
	}

	const void *key = &key;
	key++;

	const char *name = property_getName(property);
	[self implementGetterIfNecessaryForPropertyName:name customGetterName:customGetterName key:key];

	BOOL isReadonly = [attributes containsObject:@"R"];
	if (!isReadonly) {
		[self implementSetterIfNecessaryForPropertyName:name customSetterName:customSetterName key:key attributes:attributes];
	}
}

+ (NSArray *)attributesOfProperty:(objc_property_t)property {
	return [[NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding] componentsSeparatedByString:@","];
}

+ (void)implementGetterIfNecessaryForPropertyName:(char const *)propertyName customGetterName:(NSString *)customGetterName key:(const void *)key {
	SEL getter = NSSelectorFromString(customGetterName ? : [NSString stringWithFormat:@"%s", propertyName]);
	[self implementMethodIfNecessaryForSelector:getter parameterTypes:NULL block: ^id (id _self) {
	    return objc_getAssociatedObject(self, key);
	}];
}

+ (void)implementSetterIfNecessaryForPropertyName:(char const *)propertyName customSetterName:(NSString *)customSetterName key:(const void *)key attributes:(NSArray *)attributes {
	BOOL isCopy = [attributes containsObject:@"C"];
	BOOL isRetain = [attributes containsObject:@"&"];
	objc_AssociationPolicy associationPolicy = isCopy ? OBJC_ASSOCIATION_COPY : isRetain ? OBJC_ASSOCIATION_RETAIN : OBJC_ASSOCIATION_ASSIGN;
	BOOL isNonatomic = [attributes containsObject:@"N"];
	if (isNonatomic) {
		objc_AssociationPolicy nonatomic = OBJC_ASSOCIATION_COPY_NONATOMIC - OBJC_ASSOCIATION_COPY;
		associationPolicy += nonatomic;
	}

	SEL setter = NSSelectorFromString(customSetterName ? : [NSString stringWithFormat:@"set%c%s:", toupper(*propertyName), propertyName + 1]);
	[self implementMethodIfNecessaryForSelector:setter parameterTypes:"@" block: ^(id _self, id var) {
	    objc_setAssociatedObject(self, key, var, associationPolicy);
	}];
}

+ (void)implementMethodIfNecessaryForSelector:(SEL)selector parameterTypes:(const char *)types block:(id)block {
	BOOL instancesRespondToSelector = [self instancesRespondToSelector:selector];
	if (!instancesRespondToSelector) {
		IMP implementation = imp_implementationWithBlock(block);
		class_addMethod(self, selector, implementation, types);
	}
}

@end
