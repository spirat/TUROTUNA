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

float DotProduct(CGPoint p1, CGPoint p2)
{
    return p1.x * p2.x + p1.y * p2.y;
}

bool MathVectorIntersects(CGPoint p1, CGPoint p2,
                          CGPoint p3, CGPoint p4,
                          CGPoint *result)
{
    CGPoint E;
    CGPoint F;
    CGPoint P;
    CGPoint AC;
    float h;
    
    E.x = (p2.x - p1.x);
    E.y = (p2.y - p1.y);
    F.x = (p4.x - p3.x);
    F.y = (p4.y - p3.y);
    P.x = - E.y;
    P.y = E.x;
    AC.x = p1.x - p3.x;
    AC.y = p1.y - p3.y;
    
    h = DotProduct(AC, P) / DotProduct(F, P);

    
    if (h >= 0 && h <= 1)
    {

        CGPoint r;
        r.x = (int)(p3.x + F.x * h);
        r.y = (int)(p3.y + F.y * h);
        
        NSLog(@"Vector (%f-%f, %f-%f) and (%f-%f,%f-%f) intersects in point (%f,%f)", p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y, r.x, r.y);
        
        if (r.x >= MIN(p1.x, p2.x) && r.x <= MAX(p1.x, p2.x) && r.x >= MIN(p3.x, p4.x) && r.x <= MAX(p3.x, p4.x)
            && r.y >= MIN(p1.y, p2.y) && r.y <= MAX(p1.y, p2.y) && r.y >= MIN(p3.y, p4.y) && r.y <= MAX(p3.y, p4.y))
        {
            if (result)
            {
                result->x = r.x;
                result->y = r.y;
            }
            NSLog(@"Collision properly detected !");
            return true;
        }
    }

    return false;
}


/*
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
*/