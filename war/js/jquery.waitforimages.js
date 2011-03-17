/*
 * waitForImages 1.0
 * -----------------
 * Provides a callback when all images have loaded in your given selector.
 * http://www.alexanderdickson.com/
 *
 *
 * Copyright (c) 2011 Alex Dickson
 * Licensed under the MIT licenses.
 * See website for more info.
 *
 */

;(function($) {
    $.fn.waitForImages = function(finishedCallback, eachCallback) {
        
        eachCallback = eachCallback || function() {};

        if ( ! $.isFunction(finishedCallback) ||  ! $.isFunction(eachCallback)) {
            throw 'A non valid callback was supplied.';
        };

        var objs = $(this),
            allImgs = objs.find('img'),
            allImgsLength = allImgs.length,
            allImgsLoaded = 0;
        
        if (allImgsLength == 0) {
            finishedCallback.call();
        };

        return objs.each(function() {
            var obj = $(this),
                imgs = obj.find('img');

            if (imgs.length == 0) {
                return true;
            };
            
            var called = false;
           
            imgs.each(function() {
                var image = $(this)[0];
                image.onload = function() {
                    allImgsLoaded++;
                    eachCallback.call(image, allImgsLoaded, allImgsLength);
                    if (allImgsLoaded == allImgsLength) {
                    	called = true;
                        finishedCallback.call();
                        return false;
                    };
                };
            });
            
            // Give up after 3 seconds
            setTimeout(function () {
            	if (called === false) {
            		called = true;
            		finishedCallback.call();
            	}
            }, 3000);
            
            
        });
    };
})(jQuery);