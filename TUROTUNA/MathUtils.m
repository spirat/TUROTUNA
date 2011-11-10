//
//  blah.m
//  TUROTUNA
//
//  Created by  on 11. 11. 3..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MathUtils.h"

struct divop
{
    union
    {
        float numerator;  
        float n;
    };
    union
    {
        float denumerator;
        float d;
    };
};

bool MathVectorIntersects(CGPoint p1, CGPoint p2,
                          CGPoint p3, CGPoint p4,
                          CGPoint *result)
{
    struct divop ua;
    struct divop ub;
    
    ua.n = (p4.x - p3.x) * (p1.y - p3.y) - (p4.y - p3.y) * (p1.x - p3.x);
    ua.d = (p4.y - p3.y) * (p2.x - p1.x) - (p4.x - p3.x) * (p2.y - p1.y);

    ub.n = (p2.x - p1.x) * (p1.y - p3.y) - (p2.y - p1.y) * (p1.x - p3.x);
    ub.d = (p4.y - p3.y) * (p2.x - p1.x) - (p4.x - p3.x) * (p2.y - p1.y);
    
    if (ua.d == 0 || ua.d == 0)
        return  false;
    
    float resulta = ua.n / ua.d;
    float resultb = ub.n / ub.d;
    
    if (resulta > 1 || resulta < 0 || resultb > 1 || resultb < 0)
        return false;
    
    if (result != NULL)
    {
        result->x = p1.x + resulta * (p2.x - p1.x);
        result->y = p1.y + resultb * (p2.y - p1.y);
    }
    return true;
}
